# Android

## Configure

1. I will write detailed instructions later, but configuration is similar to original: https://github.com/mehcode/rn-splash-screen. More info will be 

## How to make native screen

1. Configure it in your android/app/src/main/res/drawable/your_screen_name_drawable.xml add drawables representing your view - like normal android view. Add style for it in android/app/src/main/res/values/styles.xml. 

### How to add text to native view?

1. When showing your view add message (as string) as a second argument: 
```showNativeView('YourViewName', 'Your message;);```

2. Configuring text for message - configure it in native android files.

### How to make your screen fade out?

1. In your `styles.xml` in style representing your view add line:
```<item name="android:windowExitAnimation">@android:anim/fade_out</item>```

2. for example:
```xml
<style name="YourViewName">
        <item name="android:statusBarColor">@color/color_primary</item>
        <item name="android:windowAnimationStyle">@style/RNSplashScreen_SplashAnimation</item>
        <item name="android:windowBackground">@drawable/my_view_drawable</item>
        <item name="android:windowExitAnimation">@android:anim/fade_out</item>
    </style>
```
