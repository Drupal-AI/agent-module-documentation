# Cookiebot + GTM — manual setup guide

**Cookiebot + GTM** (`cookiebot_gtm`) connects **Cookiebot**'s consent signal to
**Google Tag Manager** so that tags fire according to the consent categories each
visitor chose. It is meant for the setup large organizations end up with, and it is
worth understanding why both pieces are needed. **Cookiebot** scans your site,
categorizes the cookies it finds, and shows the banner — but it cannot, by itself,
stop a GTM tag from firing. **Google Tag Manager** fires tags and knows nothing
about consent. The join between them is Google's **Consent Mode**: the consent state
is pushed into GTM's data layer, and each tag's trigger tests it. Getting that join
right is the whole compliance question — this module supplies the Drupal side of it.

Setup is meant to be simple: create a Cookiebot profile, get a GTM container id,
enter both on the module's configuration page, and the wiring is done. All your
other external JavaScript can then be added through GTM and be checked by Cookiebot.
For multilingual sites you can also set the banner language and, if you want, a
separate GTM id per language. The module additionally provides a page that lists
which cookies are enabled/available on your site, fetched from your Cookiebot
profile. Administration is gated by a dedicated **`access cookiebot gtm config`**
permission (correctly marked restricted).

Three things fail silently in this architecture, so verify rather than assume:

1. **The consent signal must arrive before any tag can fire**, or the first
   pageview leaks tracking no matter what the visitor later chooses.
2. **Tags added in GTM by someone who does not know the convention fire
   unconditionally** — the consent check lives in each tag's *trigger*, not in the
   container — so auditing your tag inventory is a recurring governance task, not a
   one‑time setup step.
3. **Anything Drupal itself adds is outside GTM entirely.** A module that attaches
   an analytics script through Drupal's asset system is governed by none of this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Cookiebot profile and GTM
   id, and set any per‑language options.

## Where it lives in the admin menu

Once enabled, the module adds a **Cookiebot + GTM** settings form under
**Configuration** (its settings route is `cookiebot_gtm.cookiebot_gtm_config_form`).
Open it to enter your Cookiebot profile and GTM container id.
