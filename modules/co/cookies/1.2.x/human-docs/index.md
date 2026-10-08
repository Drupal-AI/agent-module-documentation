# COOKiES — manual setup guide

**COOKiES** (`cookies`) is a GDPR consent-management framework for Drupal. It
shows a configurable consent banner and — crucially — **blocks third-party
scripts and services from running until the visitor grants consent** for the
matching category. It's built on the vanilla-JavaScript `cookiesjsr` library and
designed so each popular integration (Google Analytics, Matomo, Facebook Pixel,
embedded videos, and more) is a small, ready-made bridge submodule you enable as
needed.

Consent is organised into **service groups** (categories such as functional,
performance, marketing, tracking, social, and video) and individual **services**
(each describing one data processor for your GDPR documentation). The banner
itself is a **block** you place through Drupal's Block layout. The technical heart
of the framework is the "knock-out" pattern: a bridge rewrites a third-party
`<script>` so the browser won't run it, and only swaps it back to a live script
once the visitor consents to that category. Everything is fully
config-translatable, so you can produce per-language cookie documentation as a
page, a block, or a token.

Around a dozen `cookies_*` submodules ship ready-made gates for common tools, and
you can build your own for anything un-bridged by copying one as a pattern.
Styling is themeable through CSS variables, or you can disable the bundled CSS and
start fresh. Admins configure the banner behavior, texts, and service definitions
from the COOKiES settings pages under **Configuration → System**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the JS/PHP consent
API and the knock-out mechanics — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `cookiesjsr` library), enable the module, and pick the integration submodules
   you need.
2. [Configuration](configuration/index.md) — place the banner block, set the base
   options and texts, and define service groups and services.

## Where it lives in the admin menu

- **Base settings:** **Configuration → System → COOKiES**
  (`/admin/config/system/cookies/config`).
- **Banner/widget texts:** `/admin/config/system/cookies/texts`.
- **Services and service groups:** managed as config entities under the same
  COOKiES area.
- **The banner itself:** placed via **Structure → Block layout** (the *COOKiES UI*
  block).

## How to use it

1. Install the module and the `cookiesjsr` library, then enable COOKiES (see
   [Installation](installation/index.md)).
2. Place the **COOKiES UI** block in a region via Block layout — this is what
   shows the consent banner and what makes script-blocking active on a page.
3. Configure the base settings and texts, and review the shipped service groups.
4. For each tracker or embed you use, enable its `cookies_*` submodule (or define
   a custom service) so it is blocked until the visitor consents.
5. Optionally add a footer link to `#editCookieSettings` so visitors can re-open
   the consent dialog.

See [Configuration](configuration/index.md) for the full walkthrough.
