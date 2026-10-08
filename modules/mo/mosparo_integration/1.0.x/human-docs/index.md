# mosparo Integration — manual setup guide

**mosparo Integration** (`mosparo_integration`) protects your Drupal forms from
spam using **[mosparo](https://mosparo.io/)** — a modern, privacy-friendly,
self-hostable spam-protection system. Instead of asking visitors to solve a
CAPTCHA or prove they're human, mosparo analyses the form data itself and decides
whether a submission looks legitimate. This module adds a mosparo field to your
forms and, crucially, **re-checks each submission on the server** against your
mosparo instance before the form is allowed through.

You need your **own mosparo installation** for this to work — the module is the
Drupal-side connector to it. mosparo Integration itself is the base module and
provides the connection and a form element; three submodules wire mosparo into
specific form systems:

- **`mosparo_captcha`** — integrates with the
  [CAPTCHA](https://www.drupal.org/project/captcha) module, so mosparo can protect
  any form CAPTCHA covers.
- **`mosparo_contact`** — protects the core **Contact** forms.
- **`mosparo_webform`** — protects **[Webform](https://www.drupal.org/project/webform)**
  forms.

This is a security/anti-abuse feature, and it's implemented the right way: each
submission is **re-validated server-side** against the mosparo API — it checks
that the submission is submittable *and* that the required field set matches
(which defends against field tampering), and it **fails closed** (if the mosparo
API can't be reached, the submission is blocked rather than let through). It does
not merely trust a token sent by the browser. **TLS certificate verification is
on by default.**

Two things to keep in mind: there is an admin toggle that *can* disable TLS
verification (it's off by default — leave it off against any public mosparo), and
the mosparo **private key is stored in Drupal's configuration in plain text**
(and is therefore config-exportable). Prefer storing the private key via the
**[Key](https://www.drupal.org/project/key)** module or an environment variable
so it doesn't end up committed in a config export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus the submodule(s) for the form system you use.
2. [Configuration](configuration/index.md) — connect to your mosparo instance
   (host, public key, private key) and apply protection to forms.

## Where it lives in the admin menu

Once enabled, you configure a mosparo **connection** (the link to your mosparo
project) and then apply it to forms. See [Configuration](configuration/index.md).
