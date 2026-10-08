# GovCMS Akamai Purge — manual setup guide

**GovCMS Akamai Purge** (`govcms_akamai_purge`) is a helper for invalidating
**Akamai** CDN cache from Drupal. It plugs into the
[Purge](https://www.drupal.org/project/purge) module suite so that when content
changes, the corresponding Akamai-cached objects are purged and visitors see fresh
content. It is built specifically for the **GovCMS** platform (the Australian
government's Drupal hosting).

Concretely, the module adds an `Edge-Cache-Tag` header to every cacheable response
(hashing the tags to keep the header short), registers a purger whose values come
from the hosting environment, and sends purge requests through Purge's *Late
Runtime* processor. It also provides a small administration form for purging by
path, its own permissions, and Drush commands.

The connection details are supplied through **environment variables** set by the
GovCMS platform rather than through a settings form — the module reads them to know
where and how to send its purge requests. See
[Configuration](configuration/index.md) for the variables involved and how to keep
the purge token secret.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Purge dependencies.
2. [Configuration](configuration/index.md) — the environment variables, secret
   handling, and the path-invalidation form.

## How to use it

On an Akamai-fronted GovCMS site with the environment variables in place, the
module keeps the CDN in sync automatically: content edits invalidate the matching
cache tags. For ad-hoc clears, use the module's path-invalidation form or its Drush
commands.
