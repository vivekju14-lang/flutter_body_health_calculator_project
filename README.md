# Body ร่าง — Body Health Calculator

Rajesh Kumar Upadhayay · Student ID 6819110001

Flutter assignment with SplashScreenUI, HomeUI, BmiUI, BmrUI and AboutUI.
The app uses local Kanit fonts and the instructor-supplied PNG assets.
BMI, About and BMR tabs preserve their state. Calculate and reset buttons work.
No data is transmitted or stored outside the app.

## Run
```sh
flutter pub get
flutter run -d chrome
```

## Formulas from the course mockup
BMI = weight in kg / (height in metres squared).
The course uses Asian BMI thresholds: below 18.5, 18.5–22.9, 23–24.9, 25–29.9 and 30 or above.
Classification uses unrounded values.

Revised Harris–Benedict BMR equations:
- Male: 88.362 + 13.397 × kg + 4.799 × cm − 5.677 × years
- Female: 447.593 + 9.247 × kg + 3.098 × cm − 4.330 × years

This is an educational calculator. BMR is an estimate of resting energy, not a total daily calorie target.
BMI labels follow the assignment and are not a personal medical diagnosis.
The formula for BMI is also documented at https://www.cdc.gov/growth-chart-training/hcp/using-bmi/calculating-bmi.html

## Verification
`flutter analyze`, `flutter test` and `flutter build web`.
Only the PNG files were copied from the supplied resource folder; ZoomIt.exe is not required.
