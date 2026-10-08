# Configuration

Push Framework OneSignal needs two pieces of information from your OneSignal
account before it can deliver anything. You enter them once on the module's
settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Push Framework → OneSignal**, or navigate
   directly to `/admin/config/system/push_framework/onesignal`.

## The fields

- **OneSignal App ID** — the unique identifier of your OneSignal application. You
  find it in the OneSignal dashboard under your app's settings ("Keys & IDs"). It
  identifies which OneSignal app your pushes belong to.
- **REST API key** (the OneSignal REST API auth key) — the secret key OneSignal
  uses to authenticate your server's send requests. The module sends it as an
  `Authorization: Basic <key>` header when it POSTs a notification to OneSignal's
  API over HTTPS. Treat this key as a **secret** — anyone who has it can send
  pushes as your app.

Click **Save configuration** when both are filled in.

## Keep the REST API key out of version control

The REST API key is a credential, so it should not be committed to your repository
in exported configuration. Store it in an environment variable and override the
config value at runtime rather than hard‑coding it.

With DDEV, save the value into the project's dotenv file and restart so the
container picks it up:

```bash
ddev dotenv set .ddev/.env --onesignal-rest-key=<your-key>
ddev restart
```

Then reference that variable from `settings.php` as a configuration override, for
example:

```php
$config['pf_onesignal.settings']['authkey'] = getenv('ONESIGNAL_REST_KEY');
```

This keeps the live key in the environment while the settings form still shows a
value in configuration. Never commit `.ddev/.env` or the raw key.

## After saving

Enter the App ID and key, then switch to Push Framework's own settings and enable
the **OneSignal** channel so the framework routes notifications through it. Devices
still need to register (your mobile app POSTs to `/onesignal/register` as a
logged‑in user) before there is anywhere to push to.
