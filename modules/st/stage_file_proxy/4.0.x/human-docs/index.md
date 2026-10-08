# Stage File Proxy — manual setup guide

**Stage File Proxy** (`stage_file_proxy`) solves a familiar development headache:
your local or staging site's database is a copy of production, but its **files**
directory is empty, so every image and download shows up broken. Rather than
rsyncing gigabytes of user uploads to every developer's machine, Stage File Proxy
fetches each missing file **on demand** from the production (origin) server the
first time it is requested — and caches a local copy so the next request is
instant.

It works by watching incoming requests to the public files directory. When a
requested file is missing locally, it downloads it from the configured **origin**
website and saves a copy (the default), or, in **hotlink** mode, serves a `301`
redirect straight to the origin so nothing is stored locally at all — handy for
very large or rarely‑needed files. It understands image styles too: with the
"imagecache root" option on, it fetches the *original* image from the origin and
lets Drupal regenerate the derivative locally, so later requests for other styles
of the same image are fast.

You can configure the origin URL, SSL verification, a remote files path (for
multisite), excluded file extensions, and extra proxy HTTP headers — either in the
settings form or, preferably, in `settings.php`. A Drush command
(`stage_file_proxy:dl`, alias `sfdl`) bulk‑downloads every managed file from the
origin to warm the cache in one go. **Important:** this is a development tool. It
is explicitly intended for non‑production sites and should never be enabled on
production. It depends only on core's **Image** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (on non‑production only).
2. [Configuration](configuration/index.md) — the origin URL and all proxy
   settings, plus the Drush warm‑up command.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Stage File Proxy Settings**
(`/admin/config/system/stage_file_proxy`, route `stage_file_proxy.admin_form`),
gated by the **Administer stage_file_proxy settings** permission. Many teams skip
the UI and set everything in `settings.php` instead — see
[Configuration](configuration/index.md).

## How to use it

1. On your dev or staging site (never production), install and enable the module
   (see [Installation](installation/index.md)).
2. Set the **origin** to your production site's URL — in `settings.php`
   (recommended) or the settings form.
3. Browse the site. Missing images and files now stream in from production the
   first time you view them.
4. Optionally run `drush sfdl` to pre‑download all files at once instead of waiting
   for on‑demand fetches.
