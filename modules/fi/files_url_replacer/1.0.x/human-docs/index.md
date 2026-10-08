# Public files URL replacer — manual setup guide

**Public files URL replacer** (`files_url_replacer`) rewrites the base URL of your
site's **public files** so their links point at a different host — typically your
production site. It exists for a very common development headache: you pull a copy
of the production database down to a local or staging environment, but you don't
want to copy the gigabytes of `sites/*/files` that go with it. With this module,
image and document links on your dev copy resolve to the live site, so pages render
with real media without ever syncing the files folder.

Under the hood it replaces Drupal's `file_url_generator` service with its own
version. When the feature is active, public‑scheme file URLs (everything except
`.css` and `.js`, which are left alone) have the local base URL swapped for the
external one you configure. An optional **"check if local file exists"** mode makes
the swap conditional: files that *do* exist locally keep their local URL, and only
the missing ones are pointed remotely — with special handling so a missing image‑
style derivative still resolves against the live site.

The replacement target is a single administrator‑set, validated **external** URL —
not per‑request or user input — so there is no way for an unprivileged visitor to
inject arbitrary URLs into your file links. It is a lightweight alternative to
[Stage File Proxy](https://www.drupal.org/project/stage_file_proxy) for simple
cases, and it is meant for dev/test environments, not production.

Public files URL replacer works on **Drupal 9.4, 10, and 11** and has no module
dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the three settings (activate, base
   URL, check‑if‑local), field by field.

## Where it lives in the admin menu

Once enabled, the settings form sits at **`/admin/config/files_url_replacer`**,
behind the dedicated **Administer files_url_replacer settings** permission.

## How to use it

1. On your dev/staging copy, enable the module.
2. Open the settings form and enter your **production site URL** as the replacement
   base URL.
3. Tick **Activate Replacer** to turn it on. Optionally enable **check if local
   file exists** so only missing files are served remotely.
4. Save — the container is rebuilt and file links now resolve against the live
   site. To turn it off again, untick **Activate Replacer**, save, and clear
   caches.
