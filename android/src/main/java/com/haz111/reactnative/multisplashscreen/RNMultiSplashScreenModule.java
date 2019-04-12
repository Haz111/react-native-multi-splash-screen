package com.haz111.reactnative.multisplashscreen;

import com.facebook.react.ReactActivity;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import android.util.Log;

class RNMultiSplashScreenModule extends ReactContextBaseJavaModule {

    public RNMultiSplashScreenModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "RNMultiSplashScreen";
    }

    /**
     * Close the active splash screen.
     */
    @ReactMethod
    public void hideSplashScreen() {
        this.backToReact();
    }

    /**
     * Show image like the splash screen.
     */
    @ReactMethod
    public void showNativeView(String name) {
        RNMultiSplashScreen.show((ReactActivity)getCurrentActivity(), null, name);
    }

    /**
     * Show image like the splash screen with text on it.
     */
    @ReactMethod
    public void showNativeViewWithText(String name, String text) {
        RNMultiSplashScreen.show((ReactActivity)getCurrentActivity(), null, name, text);
    }

    @ReactMethod
    public void backToReact() {
        RNMultiSplashScreen.hide(getCurrentActivity());
    }
}
