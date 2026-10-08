# Internationalization Single Sign-On — manual setup guide

**Internationalization Single Sign-On** (`i18n_sso`) provides single sign‑on
across a multilingual site that serves each language from a **different domain**.
If you run, say, `example.com` for English and `example.es` for Spanish from one
Drupal install, browser cookie policies prevent the session cookie set on
`example.com` from being read on `example.es`. Without help, users — and
administrators — have to log in to each language domain separately even though
it's the same site. This module bridges that gap so a login on one language
domain carries over to the sibling domains.

On Drupal 8 and later, it works by intercepting the **403 (access denied)** page:
if a visitor hits a 403 on one language domain but is already logged in on the
default language domain, the module quietly logs them in on the current domain
too. It does this with a small JavaScript file that runs on 403 pages and makes
two AJAX requests behind the scenes — first to fetch a short‑lived token from the
default domain, then to exchange that token on the current domain to establish a
session — reloading the page once you're in.

The design is deliberately careful about security (short‑lived tokens bound to
the user and IP, and CORS restricted to your configured domains), which makes the
few setup rules below important to follow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How it works and how to set it up

This module has **no dedicated settings form**. It relies on your site's existing
**language negotiation by domain** configuration, plus a couple of operational
rules.

1. **Configure language detection by domain.** Under **Configuration → Regional
   and language → Languages → Detection and selection**
   (`/admin/config/regional/language/detection`), enable URL‑based detection and
   set each language to its own domain (for example `example.com` and
   `example.es`). The module reads this list of language domains — it only ever
   shares login across the domains configured there.
2. **Serve every domain over HTTPS.** The SSO token travels between domains, so
   HTTPS protects it in transit. The module's own documentation recommends
   serving the `i18n_sso/*` paths over HTTPS for this reason.
3. **Keep the domain list trustworthy.** Only your own trusted sibling language
   domains should appear in the language‑domain configuration — the module's CORS
   handling echoes an allow‑origin header *only* for those configured domains
   (never a wildcard), so an inaccurate list is the main thing to avoid.

Once language‑by‑domain detection is set up and the module is enabled, the SSO
behaviour works automatically when a logged‑in user encounters a 403 on a sibling
domain.

## The security model, briefly

When a 403 is hit on a non‑default domain, the JavaScript calls the default
domain's `i18n_sso/get-token` endpoint. If the user isn't logged in there, they
see a message asking them to log in on the default language domain. If they are,
a **short‑lived, randomly generated token** (10‑minute lifetime, bound to the
user's ID and IP address, stored in the database and cleaned up by cron) is
returned. The JavaScript then calls `i18n_sso/login` on the current domain with
that token; if it's still valid, the session cookie is set on that domain and the
page reloads. This is an authentication/session convenience across *your own*
domains — it grants no other access.

You can also control the jQuery selector the module uses to append its status
markup on 403 pages by overriding a parameter in your site's `services.yml`; see
the module's own `i18n_sso.services.yml` for the parameter to override.
