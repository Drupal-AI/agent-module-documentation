# Serve Plain File — manual setup guide

**Serve Plain File** (`serve_plain_file`) lets an administrator define plain-text
files and their contents in the Drupal back end, and serves them at chosen URLs.
It is built for the small verification and metadata files that SEO and marketing
teams add or tweak regularly — things like `ads.txt`, `sellers.json`, a Google
site-verification file, or a Facebook domain-ownership file.

Normally each of these means editing the docroot or adding server configuration,
which is awkward — especially when the docroot is not writable or when the change
has to happen on production without a deployment. Serve Plain File turns each file
into a piece of Drupal configuration: you enter the path, a cache max-age, and the
file's content, and the file becomes available at that path immediately. Because
the files are stored as configuration, they can be exported and imported with the
rest of your config, or — if you want to manage them directly on production
without config import overwriting them — used together with the **Config Ignore**
module.

There is no separate settings form to tune; the module *is* its file-management
UI. You enable it, grant the administration permission, and add files. It has no
module dependencies and works across Drupal 8 through 11.

On security: the content is admin-authored configuration served at admin-chosen
paths — there is no filesystem-path input and no user-supplied content, so there
is no path-traversal or injection surface. The management routes are gated by the
**Administer served files** permission, so restrict that to trusted roles. Two
practical notes: make sure a served path does not unintentionally shadow a real
route on your site, and if you run external caches (Varnish, a CDN), remember to
purge them when a file changes — the module exposes the URLs to purge via entity
update/delete hooks so you can wire that into your own code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the permission and add your
   served files, path by path.

## Where it lives in the admin menu

The served-files management screen is at
**`/admin/config/system/served_files`** (Configuration → System). Access is gated
by the **Administer served files** permission.
