# QR Code Generator — manual setup guide

**QR Code Generator** (`qrcode_generator`) adds a QR code for the **current page**
to your site, rendered as a **floating icon block**, and gives content authors admin
tools to generate QR codes from any text or URL. A visitor can scan the floating
code to open the page on their phone, and the QR link can be shared over email,
messages, and some social platforms. Each generated code can be downloaded for
reuse or promotion.

The QR images are produced **locally** by the `chillerlan/php-qrcode` library and
returned as base64 data URIs — the module does **not** fetch anything from a remote
QR service, so the encoded data stays on your server (there is no server-side
fetch of user-supplied URLs, and therefore no SSRF risk).

There are three admin tools:

- A **global settings** form that controls the floating icon's default position,
  colour, and type.
- **Per-page overrides**, so specific pages can use a different icon style.
- An **ad-hoc generator** that turns any text or URL you type into a downloadable
  QR code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `chillerlan/php-qrcode` library) and enable the module.
2. [Configuration](configuration/index.md) — the global settings, per-page
   overrides, the ad-hoc generator, and placing the block.

## Where it lives in the admin menu

- **Global settings:** `/admin/qr-page/config` (icon position, colour, type).
- **Per-page overrides:** `/admin/qr-page/override/add` and
  `/admin/qr-page/override/list`.
- **Ad-hoc generator:** `/admin/generate-qr/from-text-url`.

All three require the core **Administer site configuration** permission. There is
also a scanner page at `/scanqrcode` (available to any user with **Access
content**) that renders a JavaScript QR scanner. The configure route is
`qrcode_generator.settings`.

## How to use it

Enable the module, set the floating icon's appearance on the global settings form,
then place the **All Pages QR Code Block** from Block layout to show the floating QR
on the front end. Add per-page overrides where you want a different look, and use
the ad-hoc generator whenever you need a downloadable QR for an arbitrary URL.
