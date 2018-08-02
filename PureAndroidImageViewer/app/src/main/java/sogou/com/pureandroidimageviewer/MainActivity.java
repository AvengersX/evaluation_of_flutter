package sogou.com.pureandroidimageviewer;

import android.support.annotation.NonNull;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.ViewTreeObserver;
import android.widget.LinearLayout;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadFactory;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import static android.support.v7.widget.RecyclerView.SCROLL_STATE_IDLE;

public class MainActivity extends AppCompatActivity {

    RecyclerView mRecyclerView;
    RecyclerViewAdapter mRecyclerViewAdapter;
    OkHttpClient mOkHttpClient = new OkHttpClient();


    int mCurNum = -1;
    boolean mIsFetching = false;

    ThreadPoolExecutor mThreadPoolExecutor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mRecyclerView = findViewById(R.id.recycler_view);
        mRecyclerViewAdapter = new RecyclerViewAdapter(this);
        mRecyclerView.setAdapter(mRecyclerViewAdapter);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(this));

        List<String> imgList = new ArrayList<>();
        for (int i = 1; i <= 31; i++) {
            imgList.add("img_" + i);
        }
        mRecyclerViewAdapter.addData(imgList);

//        mThreadPoolExecutor = new ThreadPoolExecutor(1, 1, 0L, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>(1024), new ThreadFactory() {
//            @Override
//            public Thread newThread(@NonNull Runnable r) {
//                return new Thread(r);
//            }
//        }, new ThreadPoolExecutor.AbortPolicy());

//        mRecyclerView.addOnScrollListener(new RecyclerView.OnScrollListener() {
//            @Override
//            public void onScrollStateChanged(RecyclerView recyclerView, int newState) {
//                super.onScrollStateChanged(recyclerView, newState);
//                if (newState == SCROLL_STATE_IDLE) {
//                    LinearLayoutManager linearLayoutManager = (LinearLayoutManager) recyclerView.getLayoutManager();
//                    if (linearLayoutManager.findLastVisibleItemPosition() == recyclerView.getAdapter().getItemCount() - 1) {
//                        fetchData();
//                    }
//                }
//            }
//
//            @Override
//            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
//                super.onScrolled(recyclerView, dx, dy);
//            }
//        });

//        fetchData();
    }

    public void fetchData() {
        if (mIsFetching) {
            return;
        }

        mIsFetching = true;
        mCurNum += 1;

        mThreadPoolExecutor.submit(new Runnable() {
            @Override
            public void run() {
                try {
                    System.out.println("before performFetchDataSync");
                    final List<String> urlList = performFetchDataSync(mOkHttpClient, mCurNum);
                    mRecyclerView.post(new Runnable() {
                        @Override
                        public void run() {
                            mRecyclerViewAdapter.addData(urlList);
                        }
                    });
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (JSONException e) {
                    e.printStackTrace();
                } finally {
                    mIsFetching = false;
                }
            }
        });
    }

    public List<String> performFetchDataSync(OkHttpClient okHttpClient, int curNum) throws IOException, JSONException {

        String url = "http://image.baidu.com/channel/listjson?&rn=30&tag1=%E5%AE%A0%E7%89%A9&tag2=%E5%85%A8%E9%83%A8&ie=utf8&pn=" + curNum;
        Request request = new Request.Builder()
                .url(url)
                .build();

        List<String> urls = new ArrayList<>();
        Response response = okHttpClient.newCall(request).execute();

        System.out.println("got response , start to parse it");

        if (response.isSuccessful() && response.body() != null) {
            assert response.body() != null;
            String result = response.body().string();
            JSONObject jsonObject = new JSONObject(result);
            JSONArray data = (JSONArray) jsonObject.get("data");
            for (int i = 0; i < data.length(); i++) {
                JSONObject jsonObject1 = (JSONObject) data.get(i);
                if (jsonObject1.has("image_url")) {
                    String imageUrl = (String) jsonObject1.get("image_url");
                    urls.add(imageUrl);
                }
            }
        }
        return urls;
    }
}
