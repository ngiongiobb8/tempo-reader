TEMPO READER — files in this folder

index.html            the app
config.js             your Supabase URL + publishable key go here (edit it on GitHub)
supabase.js           Supabase's library (don't edit)
supabase-setup.sql    paste into Supabase SQL Editor once (sets up tables, storage, privacy rules)
sw.js                 offline support (version number changes with each update)
jszip.min.js          reads EPUB files
manifest.webmanifest + icons   home-screen app icon/name

UPDATING THE APP LATER
Upload the new index.html and sw.js to GitHub (Add file -> Upload files -> Commit).
Do NOT re-upload config.js, or you'll overwrite your keys with the blank one.
On the phone: open Tempo, wait a few seconds, swipe it closed, reopen.

IF SYNC STOPS WORKING AFTER A WEEK+ OF NOT READING
Free Supabase projects pause after ~7 days without use. Log in at supabase.com,
open the project, click "Resume project". Nothing is lost.
