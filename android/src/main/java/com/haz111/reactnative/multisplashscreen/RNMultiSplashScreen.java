package com.haz111.reactnative.multisplashscreen;

import android.app.Activity;
import android.app.Dialog;
import android.graphics.Color;

import com.facebook.react.ReactInstanceManager;
import com.facebook.react.bridge.ReactContext;

import java.lang.ref.WeakReference;

public class RNMultiSplashScreen {
    private static Dialog mSplashDialog;
    private static WeakReference<Activity> mActivity;

    /**
     * Show the splash screen.
     */
    public static void show(final Activity activity, final ReactInstanceManager instanceManager, final String splashName) {
        if (activity == null) return;

        // Store weak-reference to showing activity (in case we try to hide too early)
        // NOTE: For instance in direct execution of index.android.js
        mActivity = new WeakReference<Activity>(activity);

        activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                if (!activity.isFinishing()) {
                    String name = "RNSplashScreen_SplashTheme";

                    if (splashName != null) {
                        name = name + "_" + splashName;
                    }

                    int styleId = activity.getResources().getIdentifier(name, "style", activity.getPackageName());

                    mSplashDialog = new Dialog(activity, styleId);
                    mSplashDialog.setCancelable(false);

                    if (!mSplashDialog.isShowing()) {
                        mSplashDialog.show();
                    }

                    // If given an instance manager; ensure that we transition to the stage-2
                    // splash screen
                    // TODO: If you think of a better way to do this; PR please
                    if (instanceManager != null) {
                        // A non-null context means that we are resuming from a
                        // background state and we will not get the context created event
                        ReactContext ctx = instanceManager.getCurrentReactContext();
                        if (ctx != null) {
                            activity.getWindow().getDecorView().setBackgroundColor(Color.WHITE);
                        } else {
                            // Else; wait until react is initialized before we release the native splash
                            instanceManager.addReactInstanceEventListener(new ReactInstanceManager.ReactInstanceEventListener() {
                                @Override
                                public void onReactContextInitialized(ReactContext context) {

                                    activity.runOnUiThread(new Runnable() {
                                        @Override
                                        public void run() {
                                            // Hide the native splash screen
                                            activity.getWindow().getDecorView().setBackgroundColor(Color.WHITE);
                                        }
                                    });
                                }
                            });
                        }
                    }
                }
            }
        });
    }

    /**
     * Close the active splash screen.
     */
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
}
