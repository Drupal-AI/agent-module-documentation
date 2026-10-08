# Mobile App Link — manual setup guide

**Mobile App Link** (`mobile_app_links`) serves the `.well-known` domain-association
files that mobile platforms require to link your website to your native apps. If you
want an iOS app to open your site's URLs as **Universal Links**, or an Android app to
verify your domain for **App Links**, the phone first fetches a special file from your
domain — and this module generates and serves those files from admin-entered
configuration, so you never have to hand-place static files.

It publishes four public files under `/.well-known/`:
`apple-app-site-association` (iOS Universal Links and App Clips), `assetlinks.json`
(Android App Links / Digital Asset Links), and two Apple domain-association text files
(`apple-developer-domain-association.txt` and
`apple-developer-merchantid-domain-association.txt`, the latter used for Apple Pay
domain verification). You fill in the data — app IDs, deep-link paths, App Clips,
Android package names and signing fingerprints, and the Apple association strings —
through four simple config forms, and the module serves the correct JSON or plain-text
response for each.

Because these files must resolve at their exact well-known URL, a built-in path
processor makes sure they still work on multilingual sites that use URL prefixes. The
files are cacheable, keep their contents in exportable Drupal config, and — as Apple
and Google require — are publicly reachable by anyone. It needs no third-party
libraries and works on Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the four config forms and the files
   they generate.

## Where it lives in the admin menu

The four config forms live under **Configuration → *(Mobile App Links)***
(`/admin/config/mobile-app-links`). The generated files are served at
`/.well-known/...` on your domain.

## How to use it

Decide which associations you need — iOS Universal Links, Android App Links, Apple
developer domain, and/or Apple Pay merchant ID — then fill in the matching form(s)
with the details your app teams provide. The module serves the files immediately at
the well-known URLs. See [Configuration](configuration/index.md) for what goes in each
form.
