import { NativeModules } from 'react-native';
import { Platform } from 'react-native';

const { RNMultiSplashScreen } = NativeModules;

function showNativeView(backgroundViewName, text) {
    RNMultiSplashScreen.showNativeView(backgroundViewName, text);
}

function hideNativeView() {
    RNMultiSplashScreen.hideNativeView();
}

export {showNativeView, hideNativeView}
