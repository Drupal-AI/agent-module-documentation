# Configuration

Google Analytics Push has a settings form that controls how it talks to Google
Analytics. It is gated by the **Admin GA Push** (`admin ga push`) permission.

## Open the settings form

1. Log in as a user with the **Admin GA Push** permission.
2. Open the Google Analytics Push settings under **Configuration** (the form is
   registered as `ga_push.settings`).

## What to configure

The form controls the mechanics of sending events:

- **Tracking / Measurement details** — your GA4 property's identifiers (for
  example the Measurement ID) that tell the module which property to send to.
- **Push mode** — whether events are sent **client‑side** (through the browser /
  dataLayer) or **server‑side** (through the GA4 Measurement Protocol from PHP).
  Choose the mode that fits each event: server‑side for facts the browser cannot
  see, client‑side where the browser is the source of truth.

## Identifiers vs. secrets

A **Measurement ID / tracking ID is a public identifier**, not a secret — it is
configuration you can safely store in the settings form. A GA4 Measurement
Protocol **API secret**, however, *is* a secret: never hard‑code or commit it.
Store it in an environment variable (with DDEV, `ddev dotenv set .ddev/.env
--ga-api-secret=…` then `ddev restart`) and reference it through a **Key** entity
or `getenv()` rather than pasting it into a config field that ends up in your
configuration export.

## Consent and privacy — read before enabling tracking

Because this module can send events **server‑side**, those events bypass ad
blockers and browser‑level opt‑outs. That makes consent your responsibility in
code:

- **Do not send events for visitors who declined tracking.** Gate every push on
  your consent signal — a server‑side event is not something a consent manager can
  withhold for you.
- **Be careful what you attach.** Order values, email addresses, and especially
  search terms leave your site when included in an event. Send only what you need,
  and avoid personal data unless your privacy policy and Google's terms allow it.

## Save

Click **Save configuration**. Then trigger a test event and confirm it lands in
your GA4 property's realtime or DebugView reports — this also confirms the event
*shape* matches what GA4 expects.
