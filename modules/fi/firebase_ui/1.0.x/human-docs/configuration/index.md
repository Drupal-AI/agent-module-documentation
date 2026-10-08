# Configuration

Firebase UI has three screens: a settings form for your Firebase credentials, a
send form for composing notifications, and a management list. Set up the
credentials first — nothing can be sent until Firebase UI knows how to reach your
Firebase project.

## 1. Enter your Firebase credentials

1. Log in as an administrator (a trusted user — sending push is a broadcast
   capability).
2. Go to **Configuration → Web services → Firebase UI → Settings**, or navigate
   directly to `/admin/config/services/firebase-ui/settings`.
3. Enter your Firebase project's web credentials. These come from your Firebase
   project settings:
   - **apiKey** — the project's web API key.
   - **projectId** — the Firebase project ID.
   - **messagingSenderId** — the FCM sender ID.
   - **appId** — the Firebase web app ID.
   - **vapidKey** — the Web Push (VAPID) key used for browser push.
4. Save the form.

> **Keep credentials safe.** Treat these values as secrets: don't commit them to
> version control, serve the site over HTTPS, and restrict who can reach the Firebase
> UI screens to trusted staff. Where your setup allows, keep secret values in an
> environment variable (with DDEV, in `.ddev/.env`, kept out of the repo) rather
> than in exported configuration.

## 2. Send a notification

1. Go to **Send a notification** (`/admin/config/services/firebase-ui/send`).
2. **Choose the recipients** — **All Users**, **Specific Users**, or **Roles**.
3. **Set the schedule** — **Immediately**, or a **Scheduled Date/Time** for future
   delivery.
4. Enter the **Title** (up to 50 characters) and the **Message** (up to 150
   characters).
5. Submit. The notification is placed on the queue and delivered when the queue is
   processed (by cron, or manually with
   `drush queue:run firebase_ui_notification_queue`).

## 3. Manage notifications

Go to the management list (`/admin/config/services/firebase-ui/list`) to review
notifications you've created. From here you can **pause and resume** scheduled
sends and **resend** notifications as needed. Invalid device tokens are cleaned up
automatically as part of the module's token management.
