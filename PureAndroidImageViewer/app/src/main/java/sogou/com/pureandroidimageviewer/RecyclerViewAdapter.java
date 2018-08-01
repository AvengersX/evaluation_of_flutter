package sogou.com.pureandroidimageviewer;

import android.content.Context;
import android.net.Uri;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.RecyclerView.ViewHolder;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.bumptech.glide.Glide;

import java.util.ArrayList;
import java.util.List;

public class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.SimpleViewHolder> {

    List<String> mUriList = new ArrayList<>();

    Context mContext;

    RecyclerViewAdapter(Context context) {
        mContext = context;
    }

    @NonNull
    @Override
    public SimpleViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.listitem, parent, false);
        return new SimpleViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull SimpleViewHolder holder, int position) {
        int drawableResourceId = mContext.getResources().getIdentifier(mUriList.get(position), "drawable", mContext.getPackageName());

        Glide.with(mContext)
                .load(drawableResourceId)
                .into(holder.mImageView);
    }

    @Override
    public int getItemCount() {
        return mUriList.size();
    }

    public void addData(List<String> uriList) {
        mUriList.addAll(uriList);
        notifyDataSetChanged();
    }

    public static class SimpleViewHolder extends ViewHolder {

        ImageView mImageView;

        public SimpleViewHolder(View itemView) {
            super(itemView);
            mImageView = itemView.findViewById(R.id.image);
        }
    }
}
