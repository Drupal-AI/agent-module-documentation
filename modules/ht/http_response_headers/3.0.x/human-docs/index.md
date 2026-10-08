# HTTP Response Headers — manual setup guide

**HTTP Response Headers** (`http_response_headers`) lets you add, change, or remove
any HTTP response header from your Drupal site through the admin UI — no code, no
edits to your web server config. Its focus is **security headers** (X-Frame-Options,
Content-Security-Policy, Strict-Transport-Security, Referrer-Policy, and friends) and
**performance/cache headers**, but it will manage any header you name.

Each header you manage is stored as a small configuration entity with a name (the
actual HTTP header), a value, an enabled flag, and optional **visibility
conditions** that scope it to certain pages, roles, languages, or content types. A
response subscriber runs late in the request and applies every enabled header. A neat
trick: if you leave the **value empty**, the module *removes* that header from the
response instead of adding it — which is exactly how you strip revealing headers like
`X-Powered-By` or `X-Generator`.

The module works as soon as you enable it, and it installs **ten ready-made header
configurations** you can turn on and tune (Access-Control-Allow-Origin,
Content-Security-Policy, Public-Key-Pins, Referrer-Policy, Strict-Transport-Security,
X-Content-Type-Options, X-Frame-Options, X-Generator, X-Powered-By, and
X-Xss-Protection). None of them do anything until you enable and configure them, so
nothing about your site's headers changes just by installing the module. It has no
dependencies beyond core, no submodules, and no Drush commands — everything is
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the header list, adding and removing
   headers, visibility conditions, and the shipped defaults.

## Where it lives in the admin menu

All header management lives at **Configuration → System → HTTP Response Headers**
(`/admin/config/system/response-headers`). That page lists every header with links
to enable, disable, edit, or delete it, plus an **Add response header** button.
Access is gated by the **Administer HTTP response headers** permission, with finer
**add**, **edit**, and **delete** permissions available too.
