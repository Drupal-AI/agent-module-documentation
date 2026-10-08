# hCaptcha — manual setup guide

**hCaptcha** (`hcaptcha`) lets you protect any Drupal form with the privacy‑focused
**hCaptcha** widget — the "I am human" checkbox — instead of a math question or Google
reCAPTCHA. It's a thin integration layer on top of the contributed **CAPTCHA** module: it
registers a new challenge type called *hCaptcha*, and you then assign that challenge to
whichever forms you want to guard (user registration, login, contact, comments, webforms)
or make it the site‑wide default.

To work, hCaptcha needs a **site key** and a **secret key** from your hCaptcha account:
the site key is public and goes into the widget, the secret key is used server‑side to
verify each submission against hCaptcha's servers. The module fails safe — if the keys
aren't set yet, it quietly falls back to CAPTCHA's built‑in Math challenge, so a form is
never left unprotected. You can also tune the widget's appearance (light/dark theme,
normal/compact size, tabindex) and, for enterprise accounts, a score threshold for
invisible verification.

hCaptcha depends on the **CAPTCHA** module and works on Drupal 9.2+, 10, and 11. It adds
one settings form (guarded by an *administer hcaptcha* permission) and no Drush commands.

> **Security note — treat the secret key as a secret.** The hCaptcha *secret key* is a
> credential. Don't paste it into a shared config export or commit it to version control.
> The recommended pattern on this project is to store it in an environment variable via
> DDEV's dotenv and reference it, rather than typing it into plain configuration — see the
> [Configuration](configuration/index.md) guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   (including the CAPTCHA dependency).
2. [Configuration](configuration/index.md) — enter your keys (safely), tune the widget,
   and assign the hCaptcha challenge to forms.

## Where it lives in the admin menu

The settings form is at **Configuration → People → CAPTCHA module settings → hCaptcha**
(`/admin/config/people/captcha/hcaptcha`), a tab under the CAPTCHA settings, guarded by
the *administer hcaptcha* permission. You decide which forms use it from the main CAPTCHA
administration (as "CAPTCHA points") or by setting the default challenge.

## How to use it

1. Get a site key and secret key from your hCaptcha dashboard
   (<https://www.hcaptcha.com/>).
2. Enter them on the hCaptcha settings form (storing the secret via an environment
   variable — see [Configuration](configuration/index.md)).
3. Tell the CAPTCHA module to use the *hCaptcha* challenge on the forms you want to
   protect, or set it as the site‑wide default.

Until both keys are set, protected forms show the Math challenge fallback rather than the
hCaptcha widget.
