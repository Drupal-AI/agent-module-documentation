# Configuration

All of PWA Firebase's settings live at **Configuration → System → PWA Firebase**
(`/admin/config/system/pwa_firebase`). Before you can fill them in you need a
Firebase project.

## Step 1 — Create a Firebase project and get credentials

1. Go to the [Firebase console](https://console.firebase.google.com/) and create a
   project (or reuse an existing one).
2. In the project, open **Settings → Cloud Messaging** and make sure Cloud
   Messaging is enabled.
3. Because this release uses the **HTTP v1** API, download a **service account key
   JSON** file for the project (Firebase console → Project settings → Service
   accounts → Generate new private key). You will attach this file to the settings
   form.
4. Note the client-side Firebase config values (API key, project id, sender id,
   app id, and so on) from **Project settings → General → Your apps** — the
   settings form needs these so the browser can register for push.

> **Upgrading from a pre-2.0.9 install?** The switch to the HTTP v1 API means the
> old settings no longer apply — you must re-open the settings form and refill all
> the variables, including attaching the service account key JSON.

## Step 2 — Fill in the settings form

On the **PWA Firebase** settings form you provide two kinds of information:

- **Service account key (JSON file)** — upload (attach) the service account key
  JSON you downloaded. This is what authorizes your server to send through the
  HTTP v1 API. Treat this file as a **secret**: keep it out of a web-accessible
  directory and out of version control.
- **Firebase web config** — the API key, project id, messaging sender id, app id,
  and the VAPID / web push key pair, as shown in your Firebase project settings.
  These are handed to the browser so it can register a push token, and the service
  worker uses them to initialise the Firebase SDK.

Fill in the fields to match the values from your Firebase project, then **Save**.

## Step 3 — Optional: the permission prompt block

The module can show a block that asks visitors to grant notification permission.
Place it from **Structure → Block layout** if you want an on-page prompt in
addition to the browser's own request.

## Keeping credentials safe

The service account key JSON is a sensitive credential — anyone who has it can send
notifications as your project. Store it securely (outside the docroot, not in
Git). Where your hosting supports it, keep the file path or its contents in an
environment variable rather than committing them.

## Sending a test notification

Once configured, go to **Content → Notification**
(`/admin/content/notification`), compose a title, message, and target URL, and
send. A browser that has accepted the notification prompt (and therefore
registered a token) should receive the push.
