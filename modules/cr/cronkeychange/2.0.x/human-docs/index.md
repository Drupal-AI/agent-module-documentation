# Cron Key Change — manual setup guide

**Cron Key Change** (`cronkeychange`) is a tiny security utility that does one
useful thing Drupal core cannot: it lets you **rotate the cron key**. Drupal
stores a secret cron key and bakes it into the external cron URL
(`/cron/<key>`), which lets a remote scheduler trigger cron without logging in.
Core has no button to change that key, so if it ever leaks — in a log file, a
screenshot, a shared URL, or a database copied down to staging — you normally
have to change it in code. This module adds a simple way to regenerate it.

Once enabled, the module adds a **"Change cron key"** fieldset to Drupal's own
Cron settings page. The fieldset shows the current key and gives you a **Generate
new key** button; clicking it replaces the key with a fresh, cryptographically
strong random value. The moment you do, the old `/cron/<old-key>` URL stops
working and the new URL becomes `/cron/<new-key>`. The same action is available
from the command line as `drush cronkeychange`, which is handy for deploy scripts
or scheduled rotation.

There is nothing to configure and the module adds no permission of its own — the
cron form is already protected by core's **Administer site configuration**
permission, and the key itself lives in Drupal's *state* (so it is per‑environment
and is not exported with your configuration).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — rotating the key from the admin UI
   and from Drush.

## Where it lives in the admin menu

Cron Key Change doesn't add a page of its own. Its controls appear on the core
**Configuration → System → Cron** page (`/admin/config/system/cron`), inside a
new **Change cron key** fieldset.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → System → Cron**, expand **Change cron key**, and click
   **Generate new key** — or run `drush cronkeychange` from the command line.
3. Update any external scheduler with the new `/cron/<key>` URL, since the old one
   stops working immediately.
