# Push Framework OneSignal — manual setup guide

**Push Framework OneSignal** (`pf_onesignal`) adds
[OneSignal](https://onesignal.com/) mobile push notifications as a delivery
channel for the [Push Framework](https://www.drupal.org/project/push_framework)
module. Once it is enabled and configured, notifications you send through the
Push Framework can reach your users' phones as native push messages, delivered
to whichever devices each user has registered.

The module handles device registration as well as delivery. Your mobile app (built
with the OneSignal SDK) posts the device's OneSignal player id to a Drupal
endpoint, and the module stores it against the logged‑in user's account. When a
notification goes out, the OneSignal channel looks up that user's active devices
and pushes to all of them. Authenticated users can review their own registered
devices under a **My devices** tab on their user profile.

Everything the channel needs from you is two credentials — a **OneSignal App ID**
and a **REST API key** — entered on the module's settings form. It also serves the
Apple App Site Association manifest so iOS universal links work. It depends on the
Push Framework module and core's User module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Push Framework.
2. [Configuration](configuration/index.md) — enter your OneSignal App ID and REST
   API key, and store the key safely.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Push Framework → OneSignal**
(`/admin/config/system/push_framework/onesignal`), behind the *Administer site
configuration* permission. Each user's own device list lives on their profile at
**My account → Devices** (`/user/{user}/devices`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Enter your OneSignal App ID and REST API key (see
   [Configuration](configuration/index.md)).
3. In your mobile app, wire up the OneSignal SDK and have it POST the device
   payload (the OneSignal player id, plus optional OS, model, language and app
   version) to `/onesignal/register`. That endpoint only accepts requests from an
   **authenticated** Drupal user, so the device is tied to the right account.
4. Enable the **OneSignal** channel inside Push Framework's own settings so the
   framework uses it for delivery.

From then on, any notification sent through Push Framework to a user who has at
least one active registered device is pushed to those devices, with the target
content's link included so a tap opens the right page.
