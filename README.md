# temphttp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This is a Flutter app that translates text from one language to another using the Google Translate API. The app has a simple UI with a text input for the source text, dropdown menus for selecting the source and target languages, and a button to initiate the translation.

When the user clicks the "Translate" button, the app makes an HTTP GET request to the Google Translate API with the selected source and target languages and the source text as parameters. The translated text is returned in the response body, which is then parsed using JSON decoding. Finally, the translated text is displayed in a container below the input form.
