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

    @ReactMethod
    public void hideNativeView() {
        RNMultiSplashScreen.hide(getCurrentActivity());
    }

    @ReactMethod
    public void showNativeView(String name, String text) {
        RNMultiSplashScreen.show((ReactActivity)getCurrentActivity(), name, text);
    }


}
