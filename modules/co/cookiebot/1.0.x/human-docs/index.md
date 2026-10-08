# Cookiebot — manual setup guide

**Cookiebot** (`cookiebot`) integrates the hosted Cookiebot (by Usercentrics)
consent service into your Drupal site. Once you enter your Cookiebot **Domain Group
ID (CBID)**, the module injects Cookiebot's consent-banner script on every page and
can automatically block cookies until the visitor gives consent — a quick way to
meet GDPR / ePrivacy requirements without hand-coding the Cookiebot embed snippet.

The module is thin glue around the third-party service: the actual consent UI,
cookie scanning and blocking all happen on Cookiebot's servers. Drupal's job is
configuration and script injection. Everything is driven from a single settings
form and one required value — the CBID. Beyond that you can turn on automatic
cookie blocking, the IAB Transparency & Consent Framework, sending Drupal's current
interface language to the banner, and rules for **where** the banner loads
(excluding admin pages, specific paths, or certain user roles).

It can also render Cookiebot's auto-generated **cookie declaration** (the table of
cookies your site sets) — either on a chosen node or through a provided **Cookie
declaration block** — and show a placeholder message where marketing elements are
blocked before consent. Two alter hooks let developers override path exclusion and
the culture code. The module depends on the **JS Cookie** module (`js_cookie`) and
provides one permission, **Administer cookiebot settings**. It stays completely
inert until you set a CBID, so it's safe to enable on staging without a live
banner appearing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the permission.
2. [Configuration](configuration/index.md) — enter your CBID and set every option,
   field by field.

## Where it lives in the admin menu

Cookiebot's settings form is at **Configuration → Cookiebot**
(`/admin/config/cookiebot`), reached by users with the **Administer cookiebot
settings** permission. The optional **Cookie declaration block** is placed from
**Structure → Block layout**.
