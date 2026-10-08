# Configuration

ALTCHA has two parts to set up: its own settings form (which integration mode to
use and how the widget behaves), and placing the ALTCHA challenge on the forms you
want to protect through the CAPTCHA module.

## Open the settings form

1. Log in as a user with the **Administer ALTCHA** permission.
2. Go to **Configuration → People → CAPTCHA → ALTCHA**, or navigate directly to
   `/admin/config/people/captcha/altcha`.

## Integration type

This chooses where challenges are generated and verified:

- **Self‑hosted** *(default)* — Drupal issues challenges at `/altcha/v1/challenge`
  and verifies solutions locally using an HMAC secret key that was created on
  install. Nothing leaves your server. If you ever need to rotate the secret, use
  the **Regenerate secret key** button on this form. (The site status report warns
  if the key is missing.)
- **Sentinel API** — use the hosted ALTCHA Sentinel service; you supply its URL, API
  key, and secret. A **fallback** option lets ALTCHA verify self‑hosted if the API
  is unreachable.
- **SaaS API** *(deprecated)* — use the ALTCHA SaaS service with an API key and a
  region (EU or US).

For most sites the self‑hosted default is the right choice and needs no extra
credentials.

## Widget behaviour and appearance

- **Complexity** (`max_number`) — how hard the proof‑of‑work is, from 1,000 to
  1,000,000. Higher values cost bots more effort (and legitimate clients a little
  more too). A moderate value is a good balance.
- **Expiry / delay** — how long a challenge stays valid, and an optional artificial
  delay, in seconds.
- **Auto‑verification** — when the widget solves itself: *off*, on focus, on load,
  or on submit.
- **Floating (invisible) mode** — enable this for a widget that verifies
  automatically without a visible checkbox. You can set the floating position (auto,
  top, or bottom), a CSS anchor selector, and an offset.
- **Hide logo / hide footer** — remove the ALTCHA branding for a cleaner form.
- **Library overrides** — point the widget's JavaScript at a custom or CDN build
  instead of the bundled one.
- **Label overrides (i18n)** — override the widget's text (verify, verifying, error,
  footer, and so on) per language.

Click **Save configuration** when done.

## Place ALTCHA on your forms

The settings above only define how ALTCHA behaves; you still choose which forms use
it through the CAPTCHA module:

1. Go to **Configuration → People → CAPTCHA**
   (`/admin/config/people/captcha`).
2. Add a CAPTCHA point for the form you want to protect (for example the user login,
   user registration, or contact form), and choose the **ALTCHA** challenge type.
3. Save. That form now shows the ALTCHA widget and rejects submissions that fail
   verification.

You can also set ALTCHA as the default challenge type in the CAPTCHA settings so it
applies to all protected forms at once.

## A note on caching

Because self‑hosted challenges are served from `/altcha/v1/challenge` and
verification does not depend on a session, pages containing the ALTCHA widget can
still be cached normally.
