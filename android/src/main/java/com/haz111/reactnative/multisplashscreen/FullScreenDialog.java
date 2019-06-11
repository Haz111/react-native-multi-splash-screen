package com.haz111.reactnative.multisplashscreen;

import android.app.Activity;
import android.app.Dialog;
import android.widget.TextView;
import android.graphics.Typeface;

class FullScreenDialog extends Dialog {
    private Activity activity;

    FullScreenDialog(Activity activity, String themeName) {
        super(activity, activity.getResources().getIdentifier(themeName, "style", activity.getPackageName()));
        this.setCancelable(false);
        this.activity = activity;
    }

    public void setText(String text, String fontName, float size, int color) {
        int textLayoutId = activity.getResources().getIdentifier("rnms_text_layout", "layout", activity.getPackageName());
        int textEditId = activity.getResources().getIdentifier("textView", "id", activity.getPackageName());

        this.setContentView(textLayoutId);

        TextView textView = (TextView) this.findViewById(textEditId);
        textView.setTextSize(size);
        if (fontName != null && !fontName.isEmpty()) {
            Typeface tf= Typeface.createFromAsset(activity.getAssets(), fontName);
            textView.setTypeface(tf);
        }
        textView.setTextColor(color);

        textView.setText(text);
    }
}
