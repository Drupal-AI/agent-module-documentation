# Push Notifications Registration Tokens — manual setup guide

**Push Notifications Registration Tokens** (`push_notifications_registration_tokens`)
provides a dedicated **entity type** for storing and managing push-notification
registration tokens. When a web or mobile app registers a device for push, this is
where that token gets recorded, so other modules can later target notifications to
registered devices. It is one piece of a suite of modules for sending push
notifications to mobile apps while maximizing user privacy — this module's job is
purely storage and management; **sending** notifications requires a separate library
or module (for example Firebase PHP or APNs PHP).

Privacy is a deliberate design goal. By default it logs **no additional device
info** beyond the token itself. It **automatically deletes stale tokens after 90
days** — in line with Google's and Apple's recommendations — though that period can
be changed and auto-deletion can be disabled. When a token is added you can record
its **type** (`android`, `apple`, or `web`), and it exposes a **JSON-RPC endpoint**
for saving tokens (a REST endpoint is not yet available). Optionally, if the
**Universal Device Detection** module is installed and the setting is enabled, it
can log the device user agent using the Matomo analytics library, which is more
privacy-preserving than many alternatives.

It depends on core **Options** (`options`) and **User** (`user`), and requires
**Drupal 11.2+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no conventional settings form to document separately — the module adds a
token entity type with a couple of behavior options, described in "How to use it"
below, and is meant to be driven by the rest of the push suite and a sending
library.

## Where it lives in the admin menu

The module manages a **registration-token entity type**. Tokens are created
programmatically (via the JSON-RPC endpoint or the rest of the push suite) rather
than hand-entered, and the entity's behavior options (retention period, optional
user-agent logging) govern how those stored tokens are handled.

## How to use it

1. Enable this module together with the rest of the push suite you are using, and a
   **sending** library/module (Firebase PHP, APNs PHP, or similar) — this module
   does not send notifications itself.
2. Have your app register devices by saving tokens through the module's **JSON-RPC
   endpoint**. Include the token **type** (`android`, `apple`, or `web`).
3. Decide on your **retention behavior**: keep the 90-day auto-deletion (the
   recommended default), change the period, or disable auto-deletion — knowing that
   disabling it means stale tokens accumulate.
4. If you want to record the device user agent, install **Universal Device
   Detection** and enable the corresponding config setting; otherwise the module
   keeps its privacy-first default of storing no extra device info.

### Handle stored tokens as personal data

A registration token identifies a device and can be used to push to it, so treat
the token store as sensitive:

- **Keep the auto-deletion / retention rule in place.** The 90-day default exists
  precisely because tokens outlive the app installs that created them; only disable
  it if you have another pruning plan.
- **Minimize what you log.** Stick to the privacy-preserving defaults unless you
  have a clear need for user-agent data, and remember that even the optional logging
  is device-level personal data.
- **Restrict access** to the token entity and any views over it to trusted roles.
