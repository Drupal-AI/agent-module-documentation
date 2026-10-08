# Robots Rerouter — manual setup guide

**Robots Rerouter** (`robots_rerouter`) serves a **different `robots.txt`
depending on which environment a request lands on**. On your production domain it
delivers your real, carefully written `robots.txt`; on any other environment — QA,
staging, dev, preview — it serves a **disallow-all** fallback that tells crawlers
to stay away. That's the safety net that stops Google (or anyone else) from
accidentally indexing a non-production copy of your site.

Unlike a meta-tag approach, this module works at the actual `/robots.txt` level. It
decides based on the current domain: if the host matches your configured production
hostname, visitors to `/robots.txt` get the production file; otherwise they get the
disallow-all fallback. It's built for the common multi-environment reality of
CI/CD and Composer-based deployments, so you don't have to resort to per-environment
`.htaccess` hacks.

It's also considerate about files. When you save the settings, it will
**automatically create** the folders and files it needs under Drupal's public
files directory (`public://`) if they don't already exist, using secure, sandboxed
file handling that works even on hosted platforms like Acquia. You can then edit
the production file to hold your real rules, and adjust the fallback if you want
something other than the default "disallow everything".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your production hostname and the
   file paths for the production and fallback `robots.txt`.

## Where it lives in the admin menu

Robots Rerouter adds a settings form at **Configuration → Search and metadata →
Robots Rerouter** (`/admin/config/search/robots-rerouter`). That's where you name
your production hostname and point the module at the two files it should serve — see
the [Configuration](configuration/index.md) guide.
