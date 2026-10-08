# Endroid QR Code — manual setup guide

**Endroid QR Code** (`endroid_qr_code`) provides a field formatter that renders the value
of a text or link field as a scannable QR-code image, using the well-known
`endroid/qr-code` PHP library. Put a URL in a link field and display it with this formatter
and you get a "scan to open this page" QR code; put a coupon code, Wi-Fi string, or vCard in
a text field and you get a QR code for that.

The formatter emits an `<img>` whose source points at a small module route that generates
the QR image on the fly. Those image routes are intentionally open to anonymous visitors so
the images render for everyone — and importantly, the value is only *encoded into the QR
bitmap*; the module never fetches the URL server-side, so the routes are QR generators, not
proxies.

A single site-wide settings form controls the QR appearance — size, quiet-zone margin, an
optional center logo, and an optional text label — so all generated codes look consistent.
The module requires PHP 8.4 and the `endroid/qr-code` Composer library.

> **Deprecation note.** The module used to include its own `endroid_qr_code` field type and
> widget. Those are **deprecated in 4.1 and removed in 5.0** — use a plain **string** or
> **link** field with this formatter instead.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with the QR library),
   check the PHP requirement, and enable the module.
2. [Configuration](configuration/index.md) — the site-wide settings form, field by field.

## How to use it

To show a field as a QR code:

1. Add or reuse a **string** or **link** field on your content type (or other entity).
2. Go to **Manage display** for that entity and set the field's format to **"Endroid Qr
   Code"**.

At render, the formatter builds the `<img>` for you — link fields use the link's URL, string
fields use their text. If the value is a valid URL it is routed through the "with URL"
generator; otherwise the raw string is encoded. There are no per-field formatter options:
size, margin, logo, and label all come from the site-wide settings form (see
[Configuration](configuration/index.md)). The same formatter works in Views-rendered
listings, so you can show QR codes in a table of links, for example.
