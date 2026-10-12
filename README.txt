TEMPO READER — run it as an app on your phone

EASIEST: GitHub Pages (free, permanent)
1. Make a free account at github.com
2. New repository -> name it "tempo-reader" -> Public -> Create
3. "uploading an existing file" -> drag in EVERYTHING from this folder -> Commit
4. Settings -> Pages -> Source: "Deploy from a branch", Branch: main, folder: / (root) -> Save
5. Wait ~1 minute. Your app is at:  https://YOUR-USERNAME.github.io/tempo-reader/

INSTALL ON iPHONE
Open that link in Safari -> Share button -> "Add to Home Screen".
It gets its own icon, opens full screen with no browser bars, and works offline.

INSTALL ON ANDROID
Open the link in Chrome -> menu (three dots) -> "Install app" / "Add to Home screen".

UPDATING LATER
Replace index.html in the repo, and change VERSION in sw.js (v1 -> v2) so phones fetch the new copy.

NOTES
- Your books live on the device, inside the installed app. The Claude version and this version
  have separate libraries, so re-add your EPUBs once after installing.
- Open the installed app every so often; iOS can clear storage for web apps that go unused for a long time.
