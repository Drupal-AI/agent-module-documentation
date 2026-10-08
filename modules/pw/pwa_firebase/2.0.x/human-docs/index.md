# PWA Firebase — manual setup guide

**PWA Firebase** (`pwa_firebase`) adds **web push notifications** to a Drupal
Progressive Web App using **Firebase Cloud Messaging (FCM)**. It serves the two
files a browser needs to receive pushes — a `manifest.json` and a
`firebase-messaging-sw.js` service worker — registers each visitor's browser push
token, and gives administrators a page at **Content → Notification**
(`/admin/content/notification`) to compose and send a notification. It can send to
a single user (all their devices) or to everyone, and it uses asynchronous Guzzle
requests so it can fan out bulk sends efficiently (it can also be wired into Views
Bulk Operations with a "send a notification" action).

From version 2.0.9 onward the module uses Firebase's **HTTP v1** API rather than
the legacy FCM API, which means you configure it with a Firebase **service account
key JSON file** (downloaded from the Firebase console) instead of a legacy server
key. Because it does not use cURL to talk to Firebase, it also works on shared
hosting.

> The public `manifest.json`, service worker, and `offline.html` routes being
> reachable anonymously is normal and expected for a PWA. The service worker also
> loads the Firebase SDK from `gstatic.com`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create a Firebase project, attach the
   service account key, and fill in the Firebase settings.

## Where it lives in the admin menu

- **Firebase settings:** **Configuration → System → PWA Firebase**
  (`/admin/config/system/pwa_firebase`) — the configure route
  `pwa_firebase.configuration`.
- **Compose / send notifications:** **Content → Notification**
  (`/admin/content/notification`).

## How to use it

1. Create a Firebase project and enable Cloud Messaging (see
   [Configuration](configuration/index.md)).
2. Attach the service account key JSON and fill in the settings form.
3. Visitors are prompted to allow notifications; when they accept, their browser
   push token is registered.
4. Compose a message at **Content → Notification** and send it, or call the send
   service from code:

   ```php
   \Drupal::service('pwa_firebase.send')->sendMessageToAllUsers($title, $message, $url);
   \Drupal::service('pwa_firebase.send')->sendMessageToUser($uid, $title, $message, $url);
   ```
