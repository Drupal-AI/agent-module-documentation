# CDNetworks Purge — manual setup guide

**CDNetworks Purge** (`cdnetworks_purge`) connects Drupal's
[Purge](https://www.drupal.org/project/purge) pipeline to the **CDNetworks** CDN.
When Drupal signals that cached content is stale — through cache tags or URLs —
this module invalidates the matching pages on CDNetworks' edge, so visitors stop
seeing outdated content after you publish changes. It can clear by URL, by regex
URL, and by tag, and it removes the need to log into CDNetworks and purge by hand.

Architecturally it is a **purger plugin** for the Purge module rather than a
standalone tool: Purge provides the queue and processing machinery, and this
module contributes the CDNetworks-specific "how to actually invalidate" step. It
depends on both **Purge** and the **Key** module, and supports Drupal 10 and 11.

To talk to CDNetworks you need an **API key and an account** with access to one or
more of their Content Management CDN services (CDNetworks does not publish its API
documentation publicly). Those credentials are stored through the Key module,
which is why Key is a hard dependency — keep the secret in an environment variable
and reference it via a Key entity rather than pasting it into configuration. See
[Configuration](configuration/index.md) for the secure setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

Two permissions govern the module — **administer cdnetworks_purge configuration**
(who may configure it) and **perform cdnetworks_purge manual purge** (who may
trigger a purge by hand). Restrict both to trusted roles.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, Purge, and Key.
2. [Configuration](configuration/index.md) — store your CDNetworks credentials
   with Key and add the purger to your Purge pipeline.

## Where it lives in the admin menu

CDNetworks Purge does not add a top-level settings page of its own; you configure
it from within the **Purge** admin UI at **Configuration → Development →
Performance → Purge** (`/admin/config/development/performance/purge`), where you
add and configure the CDNetworks purger. Credentials are managed through the Key
module at **Configuration → System → Keys**.
