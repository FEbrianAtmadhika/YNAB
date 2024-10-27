# Keep javax.annotation classes
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**

# Keep Google Crypto Tink classes
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**
