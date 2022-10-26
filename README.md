# 🔖 Quiz With Flutter

A simple Quiz App built with Flutter and Appwrite

## 🎬 Getting Started

### 🤘 Install Appwrite

Follow our simple [Installation Guide](https://appwrite.io/docs/installation) to get Appwrite up and running in no time. You can either deploy Appwrite on your local machine or, on any cloud provider of your choice.

> Note: If you setup Appwrite on your local machine, you will need to create a public IP so that your hosted frontend can access it.

We need to make a few configuration changes to your Appwrite server.

1. Add a new Flutter App (Android or iOS or both) in Appwrite and enter application id of your application (`io.appwrite.quiz` etc)
   ![Add Flutter App](https://user-images.githubusercontent.com/20852629/113019434-3c27c900-919f-11eb-997c-1da5a8303ceb.png)

2. Create a new API Key from Api Keys section

3. Update `load_questions.dart` with your own `endpoint`, `project id` and `api key`.

4. Run `flutter pub get` to get the dependencies and then run `load_questions.dart` using `dart <path_to_dir>/load_questions.dart`

5. In the appwrite console in your project, it will create new collection, the collection id is also printed at the end of the script in the console. Get the id of that collection and update `lib/constants.dart` with your own `endpoint`, `project id` and `collection id`

### 🚀 Run the Application

First get the dependencies by running `flutter pub get`. Then you can run the application simply using `flutter run` command. It works on **Android**, **iOS** and **Web** platforms.

## 🤕 Support

If you get stuck anywhere, hop onto one of our [support channels in discord](https://appwrite.io/discord) and we'd be delighted to help you out 🤝
