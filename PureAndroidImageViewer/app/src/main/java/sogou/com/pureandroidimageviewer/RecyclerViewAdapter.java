package sogou.com.pureandroidimageviewer;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.RecyclerView.ViewHolder;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;

import java.util.ArrayList;
import java.util.List;

public class RecyclerViewAdapter extends RecyclerView.Adapter<RecyclerViewAdapter.SimpleViewHolder> {

    List<SimpleModel> mData = new ArrayList<>();

    Context mContext;

    RecyclerViewAdapter(Context context) {
        mContext = context;
    }

    @NonNull
    @Override
    public SimpleViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.listitem, parent, false);
        if (parent.getMeasuredHeight() != 0
                && view.getLayoutParams() instanceof RecyclerView.LayoutParams) {
            RecyclerView.LayoutParams layoutParams = (RecyclerView.LayoutParams) view.getLayoutParams();
            layoutParams.height = parent.getMeasuredHeight() / 2;
            view.setLayoutParams(layoutParams);
        }
        return new SimpleViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull SimpleViewHolder holder, int position) {
        SimpleModel simpleModel = mData.get(position);
        if (simpleModel instanceof SimpleLocalUriText) {
            int drawableResourceId = mContext.getResources().getIdentifier(simpleModel.value, "drawable", mContext.getPackageName());
            Glide.with(mContext)
                    .load(drawableResourceId)
                    .into(holder.mImageView);
            holder.mTextView.setVisibility(View.GONE);
        } else {
            holder.mImageView.setVisibility(View.GONE);
            holder.mTextView.setText(simpleModel.value);
        }

    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void addData(List<SimpleModel> uriList) {
        mData.addAll(uriList);
        notifyDataSetChanged();
    }

    public static class SimpleViewHolder extends ViewHolder {

        ImageView mImageView;
        TextView mTextView;

        public SimpleViewHolder(View itemView) {
            super(itemView);
            mImageView = itemView.findViewById(R.id.image);
            mTextView = itemView.findViewById(R.id.text);
        }
    }

    public static class SimpleModel {
        public String value;
        public SimpleModel(String value) {
            this.value = value;
        }
    }

    public static class SimpleText extends SimpleModel{

        public SimpleText(String value) {
            super(value);
        }
    }

    public static class SimpleLocalUriText extends SimpleModel {

        public SimpleLocalUriText(String value) {
            super(value);
        }
    }
}
