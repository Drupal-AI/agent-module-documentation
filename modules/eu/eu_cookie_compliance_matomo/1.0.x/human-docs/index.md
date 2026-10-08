# EU Cookie Compliance Matomo — manual setup guide

**EU Cookie Compliance Matomo** (`eu_cookie_compliance_matomo`) is a small bridge
between two other modules — **EU Cookie Compliance** (the consent banner) and
**Matomo** (analytics) — so that Matomo only starts tracking after a visitor gives
cookie consent. It wires the banner to Matomo's own consent API (`requireConsent`,
`disableCookies`, `setConsentGiven`), so no analytics cookies are set until the
visitor opts in.

The module does no tracking of its own and shows no banner of its own — those
belong to Matomo and EU Cookie Compliance respectively. Its job is purely the
consent wiring in between. On every page it injects a small script that reads EU
Cookie Compliance's consent cookie and, when consent hasn't been given yet, tells
Matomo to require consent (and usually to disable cookies). When the visitor clicks
"Agree" — or saves their cookie preferences including the relevant categories — a
companion behaviour calls Matomo's `setConsentGiven`, and tracking begins.

It works with both of EU Cookie Compliance's consent modes: plain **opt-in**, and
**opt-in with categories**. In categories mode, this module's one setting lets you
choose exactly which cookie categories must be agreed before Matomo gets consent.
It depends on both **EU Cookie Compliance** and **Matomo**, and reuses EU Cookie
Compliance's own permission for its settings form (it adds no permission of its
own).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the one setting (which categories map
   to Matomo consent) and the config it reads from the other modules.

## Where it lives in the admin menu

The settings form is at **Configuration → System → EU Cookie Compliance → Matomo**
(`/admin/config/system/eu-cookie-compliance/matomo`), reached with EU Cookie
Compliance's **Administer EU Cookie Compliance popup** permission. Everything else
you configure lives in the EU Cookie Compliance and Matomo modules themselves.
