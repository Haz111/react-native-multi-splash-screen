package com.haz111.reactnative.multisplashscreen;

import android.app.Activity;
import android.app.Dialog;
import android.widget.TextView;

class FullScreenDialog extends Dialog {
    private Activity activity;

    FullScreenDialog(Activity activity, String themeName) {
        super(activity, activity.getResources().getIdentifier(themeName, "style", activity.getPackageName()));
        this.setCancelable(false);
        this.activity = activity;
    }

    public void setText(String text) {
        int textLayoutId = activity.getResources().getIdentifier("update_message", "layout", activity.getPackageName());
        int textEditId = activity.getResources().getIdentifier("textView", "id", activity.getPackageName());

        this.setContentView(textLayoutId);

        TextView textView = (TextView) this.findViewById(textEditId);
        textView.setText(text);
    }
}
