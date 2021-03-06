# How to sign and deploy your Flutter app

### Introduction

App-signing, building artifacts and releasing your app to Google and Apple is hell (second to writing documentation). This article will only cover deploying your app to the Google Play Store. This article is up-to-date as of 17th of November 2019, please see (the official Flutter docs)[https://flutter.dev/docs/deployment/android].

Keep in mind that the Google Play Store requirements evolve over time, please Google if you encounter any errors. Good luck 👍. I generally find StackOverflow and Github to provide the best answers.

## 1. Generate your keystore
Every app needs to be digitally signed by its own keystore (a `.jks` file) before being uploaded to Google or Apple. When you deploy newer versions, they will use the digital signature to verify the authenticity of the upload. Therefore DO NOT lose this file and DO NOT check it into version control, keep a copy of it somewhere safe. If you lose this file, you will need to generate a new one and contact Google and Apple to get it verified. 
Prepare and write down a key password and store password, you will need to use this in the next step
Run the following command to generate your keystore file. Make sure you replace nutella with the name of your app in both the keystore argument and the alias argument. After running this command your file will be saved in `~` or `C:/Users/USER_NAME` change the directory if desired.

Run the following command to generate your keystore on Mac/Linux:
`keytool -genkey -v -keystore ~/nutella.jks -keyalg RSA -keysize 2048 -validity 10000 -alias nutella`

Run this on Windows (replace USER_NAME with your username):
`keytool -genkey -v -keystore C:/Users/USER_NAME/nutella.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias nutella`

## 2. Create keystore properties file  
Create a new file `{project-root}/android/key.properties` with the following and replace each field with the details from the previous step. DO NOT check this file into version control.
```
storePassword=unicorns
keyPassword=kittens
keyAlias=nutella
storeFile=C:\\Users\\USER_NAME\\Desktop\\nutella.jks
```

## 3. Update build.gradle
1. Set `compileSdkVersion` to `28`
1. Set `minSdkVersion` to `28`
1. Set `targetSdkVersion` to `28`
1. Open `{project-root}/android/app/build.gradle`
1. Under `defaultConfig`, replace the `buildTypes` block with this fragment of code (use `androidx.fragment:fragment:1.0.0` instead of `com.android.support:support-fragment:28.0.0` when using AndroidX):
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
        }
    }
```


## 4. Update Pubspec.yaml
Open `pubspec.yaml` and update the version, the first part before the `+` sign is the version name, I recommend using semantic versioning. And increment the number after the `+` sign, it is the version code and if it is not updated Google/Apple could reject your APK. Please see https://flutter.dev/docs/deployment/android#updating-the-apps-version-number or https://stackoverflow.com/questions/54357468/how-to-set-build-and-version-number-of-flutter-app for more information.

Typically I like to update my version name semantically, either incrementing the major or minor number like 1.1.0 -> 1.2.0, if it has breaking changes 1.1.0 -> 2.0.0 etc. And I always increment the version number like +1 to +2.


## 5. Build and upload APK to Google Play
1. Run this in command line in your project root `flutter clean && flutter build appbundle --release`, this could take up to 10 minutes, don't freak out.
1. Login to Google Play Console
1. Click on 'Release Management' on the left hand side, then 'App releases'
1. Then create a new release, and fill in the details, I like to use the version name as the release name.
1. Upload your appbundle files in this directory: `{project-root}/build/app/output/bundle/release/app-release.aab`
1. Practise your Google skills to fix any issues
1. Party 🎉


## Subsequent deployments
1. Update version name and version number in `pubspec.yaml` 
1. Run `flutter clean && flutter build appbundle --release`
1. Go to Google Play Console -> Release Management -> Create new release
1. Upload new `{project-root}/build/app/output/bundle/release/app-release.aab` files
1. Checkin changes
