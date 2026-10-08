# AutoShortQR — manual setup guide

**AutoShortQR** (`autoshortqr`) automatically generates a self‑referencing **QR
code** for pages. The QR code encodes the current page's own URL, so a visitor can
scan it with a phone to open or share the page they're looking at — handy for
printed materials, presentations, or any "scan to open on your phone" use.

The QR image is produced through the **Barcodes** module (`drupal/barcode`), which
AutoShortQR depends on. This is a content‑display / user‑engagement feature: the QR
encodes a public page URL and the module has no content or access role of its own.

A note on the name: despite "short" in the title and the "short link" keyword, the
documentation describes a QR code that points at the current page's URL — a
self‑referencing code. There's nothing to configure beyond how and where the QR
code is displayed.

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Barcodes) with
   Composer and enable it.
2. [How to use it](#how-to-use-it) — where the QR code appears.

## Where it lives in the admin menu

The module provides no dedicated settings page of its own — it generates a QR code
for the current page via the Barcodes module. Manage where it appears through your
site's normal display tools.

## How to use it

1. Install and enable AutoShortQR along with its **Barcodes** dependency (see
   [Installation](installation/index.md)).
2. On your pages, the module makes available a self‑referencing QR code that encodes
   the current page's URL, rendered through the Barcodes library.
3. Place or theme that QR output where you want visitors to scan it. Because it
   always encodes the page it's shown on, no per‑page setup is needed.
