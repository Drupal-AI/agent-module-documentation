# Commerce File — manual setup guide

**Commerce File** (`commerce_file`) extends Drupal Commerce so you can **sell
access to downloadable files** — e‑books, PDFs, software installers, design
assets, course materials, and so on. When a customer buys a product, they receive
a **license** that unlocks the attached file(s) for download, with optional
limits on how many times each file can be downloaded.

Under the hood it builds on the [Commerce
License](https://www.drupal.org/project/commerce_license) module. You add a
**file trait** to a product variation type, which gives its variations a file
field (stored privately by default) holding the digital goods. Purchasing such a
variation causes Commerce License to issue an active **File license** to the
buyer, and that license is what grants download access.

Access is enforced strictly and "fail closed": a licensable file simply cannot be
downloaded or viewed by anyone who does not hold an active, non‑expired license —
they get a 403. Downloads happen through a dedicated download route, and each
download is logged (user, file, license, IP, time) so download limits can be
counted and abuse reviewed. Store administrators, and anyone with the **bypass
license control** permission, skip both the limits and the logging.

Out of the box you also get a checkout "Files download" pane (so buyers see their
files on the order‑complete page), a **My files** page listing everything a
customer is licensed to download, a themed download‑link field formatter, and
optional Amazon S3 (Flysystem) redirect support for public buckets.

This guide is written for a **human** setting the store up. If you want terse,
token‑cheap references for an AI coding agent — the `LicenseFileManager` service,
the access hooks, and the download logger — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   Commerce License) and enable the module.
2. [Configuration](configuration/index.md) — add the file trait to a variation
   type, set download limits, and expose the checkout pane and "My files" view.

## Where it lives in the admin menu

The global settings form is at **Commerce → Configuration → License → File
download settings** (`/admin/commerce/config/licenses/file`). The per‑product
setup happens on your **product variation types** under Commerce → Configuration.

## How to use it

1. Install and enable the module.
2. On the product variation type you want to sell as downloads, enable the
   **"Provides a file for download"** trait — this adds the file field (and turns
   on licensing automatically).
3. Create products, upload the file(s) to each variation, and set any download
   limits.
4. Customers buy the product, receive a File license, and download their files
   from the checkout‑complete pane or their **My files** page.
