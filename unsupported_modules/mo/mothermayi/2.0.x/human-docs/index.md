# Mother May I — manual setup guide

**Mother May I** (`mothermayi`) is a lightweight anti-spam gate for **user
registration**. It lets a site administrator define a site-specific **secret
word** (or phrase); anyone who wants to create an account must enter that word
before the registration form will proceed. It's aimed at sites with a limited,
known audience — a company extranet, an NGO, a housing society — where you can
share the word with genuine new members out-of-band, while bots and strangers who
don't know it are turned away.

The administrator can also set a **hint** shown on the form: descriptive enough
that a real member can work out the word, but not enough for an outsider. If no
secret word is defined, the module does nothing, leaving the normal registration
process untouched. Incorrect attempts are logged, so you can see them under your
site's **Recent log messages**. Note that Mother May I only protects the
**account registration form** — for other spam targets (like the contact form),
use a general CAPTCHA solution.

> **Important — this module is unsupported.** Its project page states it is
> **unsupported due to a security issue the maintainer did not fix**, and its
> Drupal security-advisory coverage has been **revoked**. Do not rely on it for a
> site where security matters. Prefer an actively maintained alternative; if you
> must use Mother May I, do so with full awareness of that status. This guide
> documents the module as it exists — it is not an endorsement.

Understand the security model even setting the above aside: the secret word is a
**shared, low-entropy gate**, not per-user authentication. Anyone who learns the
word (it may be shared widely or leak) can register, and the module doesn't
rate-limit guesses by itself. Treat it as a mild deterrent, pair it with stronger
anti-spam such as [Honeypot](https://www.drupal.org/project/honeypot),
[CAPTCHA](https://www.drupal.org/project/captcha), and core flood control, and
rotate the word if it leaks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the secret word and hint.

## Where it lives in the admin menu

Once enabled, the settings form is at the route `mothermayi.settings`, under
**Configuration**. See [Configuration](configuration/index.md).
