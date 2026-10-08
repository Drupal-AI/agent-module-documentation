# Scan code - Barcode — manual setup guide

**Scan code - Barcode** (`scan_code`) lets people fill in a form field by scanning
a barcode instead of typing it. It extends Drupal's text form widget so a site
builder can add a "scan" capability: the user points their device camera at a
barcode (or supplies an image), the module reads the code and drops the decoded
value straight into the field.

It is handy anywhere barcode‑driven data entry saves time and reduces typos —
capturing product codes, ticket numbers or inventory identifiers. The module is
based on the barcode‑scanning submodule of Commerce POS, and it uses the Quagga2
JavaScript library plus the WebRTC adapter to do the actual decoding in the
browser.

The module needs a little configuration and then it surfaces on the fields you
enable it for. It has its own settings page, provides its own permissions, and has
no module dependencies or submodules. The required JavaScript libraries are
installed automatically through the standard Composer installation.

One thing to keep in mind: a scanned value is ordinary user‑supplied input, so
validate and escape it just as you would anything a user types. And because
scanning uses the camera, the browser will prompt the user for camera permission
the first time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (libraries come
   along automatically) and enable it.
2. [Configuration](configuration/index.md) — the settings page and how the scan
   capability is added to fields.

## Where it lives in the admin menu

The module's settings live on its own configuration page (route
`scan_code.admin_config`).

## How to use it

Once configured, the scan capability appears as an extension of the text form
widget on the fields you enable it for. An editor filling in that field can start a
scan, point the camera at a barcode, and have the decoded value entered
automatically.
