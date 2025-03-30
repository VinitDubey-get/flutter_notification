Steps to Follow ---#####----

Step-1 #####

   timezone: ^0.9.2
   hive: ^2.2.3
   hive_flutter: ^1.1.0
   intl: ^0.18.1
   path_provider: ^2.1.5
   flutter_local_notifications: ^18.0.1
   permission_handler: ^11.4.0

<----Add These in pubspec.yaml ---->>

Step-2 ###

    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
    <uses-permission android:name="android.permission.USE_EXACT_ALARM" />

<<<------- Add this Permissions in AndroidManifest.xml -------->>>

      <meta-data
            android:name="flutterEmbedding"
            android:value="2" />

<<<<----- Add these Code below the Above Code in AndroidManifest.xml ------->>>>>

        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:exported="false" android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>

Step -3 ####

<<<<--- Set NDK version in app level build.kts if it's gives error to ---->>>>

             ndkVersion = "27.0.12077973"

<<<<--- Set Minimum Compiled SDK version in app level build.kts if it's gives error to ---->>>>

             compileSdk = 33 (Android 12+)

<<<<---- Put Your Audio File in android/app/src/main/res/raw and change file name in notification_services.dart accordimgly ---->>>>

Step-5 ####

<<<<--- Cope the code and you are Ready to Go --->>>>