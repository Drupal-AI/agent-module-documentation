# Advanced PWA — manual setup guide

**Advanced PWA** (`advanced_pwa`) turns your Drupal site into an installable
**Progressive Web App** and lets you broadcast **web push notifications** to
people who subscribe. A PWA is a website that a phone or desktop can "install" so
it behaves more like a native app — it gets an icon, opens in its own window, and
can receive push messages. This module supplies the two technical pieces that make
that possible: a **web app manifest** (served at `/manifest.json`) that describes
the app's name, icons, and colours, and a **service worker** script that runs in
the background to handle installation and push delivery.

On top of that it adds a subscription flow: front-end visitors can subscribe or
unsubscribe to push notifications, their subscription details are stored per user,
and administrators can broadcast a message to all subscribers from an admin form —
or have the site automatically notify subscribers when new content is published.
An admin report lists current subscriptions, and an optional submodule,
**Advanced PWA Unregister** (`advanced_pwa_unregister`), is provided as well.

Sending web push requires a pair of **VAPID keys** (the credentials that authorise
your site to push to a browser), which you enter in the module's configuration.
Keep the private key secret. This version targets Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and note the optional submodule.
2. [Configuration](configuration/index.md) — the manifest, push/VAPID settings,
   device caching, subscriptions, and the broadcast form.

## Where it lives in the admin menu

The main settings form is at **Configuration → System → Advanced PWA**
(`/admin/config/system/advanced-pwa`), where you set up the manifest and push
options. The broadcast form, device-caching options, and the subscriptions report
live alongside it. All of these admin screens require the **Administer site
configuration** permission. The `manifest.json` and service-worker files are
served automatically once the module is enabled.
