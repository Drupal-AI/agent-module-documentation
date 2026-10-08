# Persistent Visitor Parameters — manual setup guide

**Persistent Visitor Parameters** (`persistent_visitor_parameters`) captures
selected **GET query parameters and HTTP request values** from a visitor — things
like `utm_source`, `utm_medium`, `utm_campaign`, or the referring URL
(`HTTP_REFERER`) — and **persists them** so they survive as the visitor moves
around your site. That way, when someone lands from a campaign link and later
takes an action (registers, makes a purchase, submits a form), the original
attribution parameters are still available to record against that action.

The module reads the configured parameters on the first request and stores them,
then keeps them for the lifetime you choose. Other modules can read the stored
values through its integrated `cookie_manager` service, so your own code can pick
up the campaign context wherever it needs it. A companion submodule,
**persistent_visitor_parameters_user_registration**, wires this into the user
registration flow so the UTM / referrer / form source that brought a person to
the site is logged when they register.

This is a marketing / attribution tool, not an access‑control feature — it holds
no special permissions over your content beyond its own administration
permission. One thing to keep in mind: the values it captures come **straight
from the visitor's request**, so they are **untrusted input**. Any code that
later *outputs* them must escape them (to avoid reflected cross‑site scripting),
anything that stores them against a user or entity should validate them first,
and you should never trust them for a security decision. Because it can retain
identifiers like referral sources, treat the stored data with the same care as
other visitor tracking information under your privacy obligations — it honours the
browser's Do‑Not‑Track signal when you enable that option.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally add the registration‑tracking submodule.

## Where it lives in the admin menu

The settings form is at **`/admin/config/persistent-visitor-parameters`**. This
module has no separate configuration handbook page — its options are described in
"How to set it up" below.

## How to set it up

1. After enabling, open the settings form at
   **`/admin/config/persistent-visitor-parameters`** (you will need the
   *Administer site configuration* permission, or the module's own administration
   permission).
2. **Choose which parameters to capture** — list the GET/request parameters you
   care about, for example `utm_source`, `utm_medium`, `utm_campaign`,
   `utm_term`, `utm_content`, or the HTTP referrer.
3. **Set the cookie lifetime** — how long the captured values persist: for the
   **current session**, for a **custom** duration, or **forever**.
4. **Respect Do‑Not‑Track** — enable this so the module honours the visitor's
   browser DNT setting and skips capturing when DNT is on. Turning this on helps
   with privacy compliance.
5. Save the form.

Once configured, the parameters are captured automatically on incoming requests.
To use the stored values in your own module, read them through the module's
service, for example:

```php
$params = \Drupal::service('persistent_visitor_parameters.cookie_manager')->getCookie();
// $params now holds the captured attribution values — escape on output,
// and validate before storing them anywhere.
```

If you enable the **registration‑tracking submodule** (see
[Installation](installation/index.md)), captured parameters are attached to new
user registrations automatically, giving you the source of each registered user.
