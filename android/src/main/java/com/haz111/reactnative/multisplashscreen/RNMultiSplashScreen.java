package com.haz111.reactnative.multisplashscreen;

import android.app.Activity;
import android.graphics.Color;
import android.content.res.Resources;
import android.widget.TextView;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.bridge.ReactContext;
import java.lang.ref.WeakReference;

public class RNMultiSplashScreen {
    static final String defaultSplashName = "RNMultiSplashScreen_SplashTheme";

    private static FullScreenDialog mSplashDialog;
    private static WeakReference<Activity> mActivity;
    private static String fontName = null;
    private static float fontSize = 16.0f;
    private static int fontColor = Color.BLACK;

    public static void show(final Activity activity, final String viewName) {
        RNMultiSplashScreen.show(activity, viewName, null);
    }

    public static void show(final Activity activity, final String viewName, final String text) {
        if (activity == null) return;

        mActivity = new WeakReference<Activity>(activity);

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!activity.isFinishing()) {
                    String name = (viewName != null) ? viewName : defaultSplashName;
                    mSplashDialog = new FullScreenDialog(activity, name);
                    if (text != null) {
                        mSplashDialog.setText(text, fontName, fontSize, fontColor);
                    }

                    if (!mSplashDialog.isShowing()) {
                        mSplashDialog.show();
                    }
                }
            }
        });
    }

    public static void hide(Activity activity) {
        if (activity == null) activity = mActivity.get();
        if (activity == null) return;

         activity.runOnUiThread(new Runnable() {
             @Override
             public void run() {
                 if (mSplashDialog != null && mSplashDialog.isShowing()) {
                     mSplashDialog.dismiss();
                 }
             }
         });
    }

    public static void setFontProperties(String name, Float size, Integer color) {
        if(name != null && !name.isEmpty())
            fontName = name;

        if (size != null)
            fontSize = size;

        if (color != null)
            fontColor = color;
    }
}
