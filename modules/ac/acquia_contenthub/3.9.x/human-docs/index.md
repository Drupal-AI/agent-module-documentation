# Acquia ContentHub — manual setup guide

**Acquia ContentHub** (`acquia_contenthub`) connects a Drupal site to Acquia's
Content Hub SaaS so that content entities can be syndicated between many Drupal
sites. It is a large content‑distribution suite, not a one‑feature module: think of
it as the plumbing for a "hub and spoke" publishing model (one authoring site
feeding many delivery sites) or for bidirectional content sharing across a fleet
of sites.

The base module handles the **service connection** — it registers the site as a
Content Hub "client" (with an API key, secret key, origin UUID, and hostname),
receives service webhooks at `/acquia-contenthub/webhook`, and validates them with
HMAC signatures. Content is turned into a Common Data Format (CDF) document through
an event‑driven pipeline, and full dependency graphs are calculated by the
required **depcalc** module so that an imported entity arrives complete — with its
fields, referenced entities, files, and configuration.

The actual publish/subscribe roles live in **submodules** you enable per site:
`acquia_contenthub_publisher` exports content and manages the export queue;
`acquia_contenthub_subscriber` imports content and runs the import queue. Others
add curation, a dashboard, metatag/canonical handling, moderation‑state mapping,
selective‑language import, S3 file support, site‑health audits, and per‑entity
unsubscribe.

Because this is a hosted‑service integration, using it requires **Acquia Content
Hub credentials** (an API key, secret key, and the service hostname) that you get
from your Acquia Content Hub subscription. This guide covers connecting a site and
the recommended, secure way to supply those credentials — it does not attempt to
document every submodule and event in the suite.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite (and its libraries)
   with Composer, enable the base module and the publisher/subscriber submodules.
2. [Configuration](configuration/index.md) — connect the site to Content Hub and
   supply credentials securely.

## Where it lives in the admin menu

The connection settings live at **Configuration → Web services → Acquia Content
Hub** (`/admin/config/services/acquia-contenthub`), gated by the **Administer
Acquia Content Hub** permission. A rich set of Drush commands
(`acquia:contenthub-*`) covers connect/disconnect, queue runs, filters, webhooks,
purge, audit, and reindex.

## How to use it (in brief)

At a high level, a working syndication setup looks like this:

1. Install the suite and enable the base module on every participating site.
2. On each site, enable **publisher** (to send content) and/or **subscriber** (to
   receive content).
3. Connect each site to Content Hub with its credentials (see
   [Configuration](configuration/index.md)).
4. On publishers, add content to the export queue and run it (via cron or `drush
   acquia:contenthub-export-queue-run`).
5. On subscribers, incoming webhooks queue imports, which run via cron or `drush
   acquia:contenthub-import-queue-run`, resolving all dependencies.

The [agent docs](../agent/start.md) go deeper on the Drush commands, the
serialization events you can subscribe to, and the file‑scheme handler plugin
type.
