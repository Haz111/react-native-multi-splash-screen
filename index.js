import { NativeModules } from 'react-native';
import { Platform } from 'react-native';

const { RNMultiSplashScreen } = NativeModules;

function showNativeView({androidView, iosBackground}) {
    console.log("codepush showNativeView", androidView, iosBackground);
    if (Platform.OS === "ios")
        RNMultiSplashScreen.showNativeViewWithText(iosBackground);
    if (Platform.OS === "android")
        RNMultiSplashScreen.showNativeViewWithText(androidView);
}

function showNativeViewWithText({androidView, iosBackground}, text) {
    console.log("codepush showNativeViewWithText", text, androidView, iosBackground);
    if (Platform.OS === "ios")
        RNMultiSplashScreen.showNativeViewWithText(iosBackground, text);
    if (Platform.OS === "android")
        RNMultiSplashScreen.showNativeViewWithText(androidView, text);
}

function hideNativeScreen() {
    console.log("codepush hideNativeScreen");
    RNMultiSplashScreen.hideNativeScreen();
}

export {showNativeView, showNativeViewWithText, hideNativeScreen}
