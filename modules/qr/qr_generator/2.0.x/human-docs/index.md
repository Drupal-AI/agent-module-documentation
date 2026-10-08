# QR Code Generator — manual setup guide

**QR Code Generator** (`qr_generator`) lets you create, manage, and **host** QR
codes directly in Drupal. Crucially, it generates the codes **on your own server**
(using the `endroid/qr-code` library) rather than calling an external QR service, so
nothing about the encoded data is sent to a third party. It handles two kinds of QR
code:

- **Online QR codes** — managed as content entities with a redirect. A scan lands
  on your Drupal site (`/api/qr-code/{uuid}`) and is automatically redirected to
  the destination you set. You can give these an optional **expiration date**, and
  change where they point without reprinting the code.
- **Offline (self-contained) QR codes** — the target data (a URL, email, or plain
  text) is embedded directly in the code, so it works with no internet connection
  and no dependency on your site being up.

When you export a code you can brand and style it: embed a **logo** in the centre
(from an uploaded image or a URL), add a **label** such as "Scan Me" below it,
choose **foreground and background colours** (full hex control), pick an **error
correction level** (Low / Medium / Quartile / High — automatically raised to High
when a logo is used), and export as **PNG, SVG, or PDF**.

This guide covers the recommended **2.0.x** branch (Drupal 10.3+ / 11, PHP 8.3+).
Use the 1.0.x branch only on older, unsupported Drupal releases.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the QR
   and PDF libraries) and enable the module.

There is **no global settings page** — you work with QR codes as content and set
their appearance on the export form, described in "How to use it" below.

## Where it lives in the admin menu

Manage QR codes under **Content → QR Codes**. Each code's **Export** action (in the
Operations column) opens the styling/export form; the offline flow is reached with
**Generate Offline QR Code**. The per-entity export form is at
`/admin/qr-code/export/{entityId}`.

## How to use it

**Online QR code with branding:**

1. Go to **Content → QR Codes** and add a QR code; set the **redirect URL** and
   (optionally) an **expiry date**.
2. In the list, click **Export** in the Operations column.
3. Choose the **logo**, **colours**, **label**, **format** (PNG/SVG/PDF), and
   **size**.
4. Submit the form to download the file. Because it is an online code, you can later
   change the redirect target without changing the printed code.

**Offline (self-contained) QR code:**

1. Go to **Content → QR Codes** and click **Generate Offline QR Code**.
2. Enter the target data to embed — a URL, email address, or plain text.
3. Configure branding and technical parameters (logo, colours, label, error
   correction, size).
4. Download the file. The resulting code works independently of your Drupal site.
