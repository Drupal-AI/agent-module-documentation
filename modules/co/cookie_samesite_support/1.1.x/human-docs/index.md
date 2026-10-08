# Cookie SameSite support — manual setup guide

**Cookie SameSite support** (`cookie_samesite_support`) sets `SameSite=None` on
Drupal's session cookie and, for older browsers that reject that value outright,
emits a **legacy duplicate** of the cookie without the attribute. Together this
keeps sessions working when your Drupal site is used in a **cross‑site context** —
most commonly when it is **embedded in an iframe on another domain**.

Here is the problem it solves. The `SameSite` attribute controls whether a cookie
is sent on requests that originate from another site, and browsers now default it to
`Lax` as an anti‑CSRF measure. That default breaks one legitimate pattern: a Drupal
site inside an iframe on a partner's page — an authenticated widget, a booking flow,
an app inside a portal — never receives its session cookie, so the user appears
logged out. Setting `SameSite=None` restores it. The complication is that some older
browsers reject `None` and drop the cookie entirely, so the module sends two
cookies: a modern one with `SameSite=None; Secure` and a legacy duplicate without
the attribute. It implements this by decorating `SessionManager` and
`SessionConfiguration`. The module works on enable — there is no settings form.

**Understand what you are giving up — this is a security‑relevant change:**

- **`SameSite` is a CSRF defense.** `None` switches it off *for the session cookie*.
  Drupal's own form tokens and `_csrf_token` route requirements remain and are the
  primary defense, but a layer has been removed — any route that changes state
  without a token becomes materially more exposed.
- **`Secure` is mandatory with `None`.** The site must be served over HTTPS
  throughout.
- **The legacy duplicate is a second copy of a session identifier** travelling on
  every request. Confirm the browsers you actually serve still need it.

Install this only when you genuinely need cross‑site sessions (an embedded/iframe
scenario, or an external redirect flow such as a payment gateway's 3‑D Secure
return that lands the user back on Drupal).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — no settings form. It takes
effect on the session cookie as soon as it is enabled.

## Where it lives in the admin menu

Cookie SameSite support adds no admin page. It changes how the session cookie is set
and read as soon as it is enabled.
