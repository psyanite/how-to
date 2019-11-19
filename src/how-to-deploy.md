# How to sign and release your Flutter app


#### How it works
This article will only cover release your app to the Android Play Store. This article is up-to-date as of 17th of November 2019, please see (the official Flutter docs) [ https://flutter.dev/docs/deployment/android#signing-the-app] for the proper instructions.


## 1. Generate your keystore
Every app needs to be digitally signed by its own keystore (a `.jks` file) before being uploaded to Google or Apple. When you deploy newer versions, they will use the digital signature to verify the authenticity of the upload. Therefore DO NOT lose this file, keep a copy of it somewhere safe. If you lose this file, you will need to generate a new one and contact Google and Apple to get it verified. 
Run the following command to generate your keystore file. Make sure you replace nutella with the name of your app in both the keystore argument and the alias argument.

Run the following command to generate your keystore on Mac/Linux:
`keytool -genkey -v -keystore ~/nutella.jks -keyalg RSA -keysize 2048 -validity 10000 -alias nutella`

Run this on Windows (replace USER_NAME with your username):
`keytool -genkey -v -keystore c:/Users/USER_NAME/nutella.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias nutella`


## 2. Update build.gradle
1. Set `compileSdkVersion` to `28`
1. Set `minSdkVersion` to `28`
1. Set `targetSdkVersion` to `28`
1. Open `{project-root}/android/app/build.gradle`
1. Under `defaultConfig` add this fragment of code (use `androidx.fragment:fragment:1.0.0` instead of `com.android.support:support-fragment:28.0.0` when using AndroidX):
```
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            
            dependencies {
                implementation 'com.android.support:support-fragment:28.0.0'
            }
        }
    }
```
