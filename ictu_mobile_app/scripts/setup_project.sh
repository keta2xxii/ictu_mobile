echo "Set Flutter verion"
fvm use $1
echo "Pub get"
fvm flutter pub get
echo "Generate .g file"
fvm flutter pub run build_runner build --delete-conflicting-outputs
echo "Generate LocaleKey file"
fvm flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart