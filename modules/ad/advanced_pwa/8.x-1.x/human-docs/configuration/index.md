# Configuration

All of Advanced PWA's admin screens require the **Administer site configuration**
permission. The main settings form is at **Configuration → System → Advanced PWA**
(`/admin/config/system/advanced-pwa`).

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Advanced PWA**, or navigate directly to
   `/admin/config/system/advanced-pwa`.

## Manifest settings

The manifest is the file (served at `/manifest.json`) that tells a browser how to
install your site as an app. Here you set the app's identity — its name, icons,
and colours — so that when a visitor chooses "Add to Home Screen" or "Install",
the app appears with the right label and artwork. Fill these in to match your
brand; the module then serves the manifest automatically.

## Push notification settings

This is where you enable web push and enter the **VAPID keys** — the public/private
key pair that authorises your site to send push messages to a subscriber's
browser. Enter the key pair here. Because the private key is a secret, avoid
committing it to version control; prefer keeping it in an environment variable and
referencing that value.

## Device caching

A separate option controls **device caching** behaviour for the service worker —
how the PWA caches assets on the visitor's device. Adjust it to suit how
aggressively you want offline/cached content served.

## Subscriptions report

An admin report lists the current push **subscriptions** — the browsers/devices
that have opted in, each stored with its endpoint and keys. Use it to review who
is subscribed. Note that the front-end subscribe/unsubscribe endpoints are gated
by the **Access content** permission, and a separate **Display push notification
prompt** permission controls which visitors are actually shown the prompt to
subscribe.

## Broadcast a notification

The **broadcast form** lets you compose a push message and send it to all current
subscribers. In addition, the module can automatically notify subscribers when new
content is published, so you do not have to send every announcement by hand.

## Save

Save each form after editing. Push messages can only be delivered once the VAPID
keys are configured and visitors have subscribed over HTTPS, so confirm the keys
are in place before expecting the subscription list to grow or broadcasts to
arrive.
