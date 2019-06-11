import { NativeModules } from 'react-native';
import { Platform } from 'react-native';

const { RNMultiSplashScreen } = NativeModules;

function showNativeView({androidView, iosBackground}) {
    if (Platform.OS === "ios")
        RNMultiSplashScreen.showNativeViewWithText(iosBackground);
    if (Platform.OS === "android")
        RNMultiSplashScreen.showNativeViewWithText(androidView);
}

function showNativeViewWithText({androidView, iosBackground}, text) {
    if (Platform.OS === "ios")
        RNMultiSplashScreen.showNativeViewWithText(iosBackground, text);
    if (Platform.OS === "android")
        RNMultiSplashScreen.showNativeViewWithText(androidView, text);
}

function hideNativeScreen() {
    RNMultiSplashScreen.hideNativeScreen();
}

export {showNativeView, showNativeViewWithText, hideNativeScreen}
