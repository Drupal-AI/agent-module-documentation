# EU Cookie Compliance GTM — manual setup guide

**EU Cookie Compliance GTM** (`eu_cookie_compliance_gtm`) is the glue between two
popular modules: **EU Cookie Compliance** (the GDPR cookie‑consent banner) and
**Google Tag Manager** (via the `google_tag` module). Its job is to let your GTM
tags fire — or not — according to what each visitor has actually consented to. It
does that by pushing the visitor's per‑category consent state into GTM's
`dataLayer` whenever their choices change.

The way you configure it is per **cookie category**. On each cookie category's
add/edit form the module adds a **GTM data** field where you enter a small JSON
object. That JSON is stored on the category (as a third‑party setting) and gets
pushed to the `dataLayer` on every consent change. Inside the JSON you can use two
placeholder tokens: `@status`, which becomes `1` or `0` depending on whether *this*
category is currently accepted, and `@<machine_name>_status`, which references
another category's accepted state (for example `@functional_status`).

On the front end the module attaches a small JavaScript file that listens for the
consent events the main EU Cookie Compliance module fires. When consent is given
or changed, it reads each category's GTM data, substitutes the status tokens with
the current 1/0 values, and pushes the result to the GTM `dataLayer` — so your GTM
triggers can react to consent without any custom code or manual container edits.

The module has **no settings form of its own** — all configuration is the
per‑category JSON, edited on the existing cookie‑categories screen. It depends on
**EU Cookie Compliance** (`^1.24`) and **Google Tag** (`^1.6 || ^2.0`), and works
with both the 1.x and 2.x lines of `google_tag`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm its dependencies.
2. [Configuration](configuration/index.md) — the per‑category **GTM data** field,
   the status tokens, and how the values reach GTM.

## Where it lives in the admin menu

There is no dedicated settings page. You configure it on the existing cookie
categories screen at **Configuration → System → EU Cookie Compliance →
Categories** (`/admin/config/system/eu-cookie-compliance/categories`), where each
category's add/edit form now includes a **GTM data** field.
