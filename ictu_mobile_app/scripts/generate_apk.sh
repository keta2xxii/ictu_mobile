echo "Run pub get"
fvm flutter pub get
echo "Generate file .g"
fvm flutter pub run build_runner build --delete-conflicting-outputs 
echo "Generate APK file enviroment Prod"
fvm flutter build apk --release --dart-define=mgv_env=prod
echo "Change file name from app-release to $2-b$1-`date +%d-%m-%Y`"
cd build/app/outputs/flutter-apk
mv app-release.apk $2-b$1-`date +%d-%m-%Y`.apk
echo "File located at build/app/outputs/flutter-apk/Prod-b$1-`date +%d-%m-%Y`.apk"
echo "Generate APK file enviroment Staging"
fvm flutter build apk --release --dart-define=mgv_env=staging
echo "Change file name from app-release to $2-b$1-`date +%d-%m-%Y`"
mv app-release.apk Staging-b$1-`date +%d-%m-%Y`.apk
echo "File located at build/app/outputs/flutter-apk/Staging-b$1-`date +%d-%m-%Y`.apk"

echo "Successfully"