# Silktide — manual setup guide

**Silktide** (`silktide`) connects your Drupal site to the hosted
[Silktide](https://silktide.com) website‑quality platform — the external service
that audits pages for SEO, accessibility (WCAG), broken links, spelling, and
general content quality. The module is a thin, two‑way integration: it tells
Silktide when your content changes, and it lets the Silktide browser toolbar jump
straight back into your CMS.

Concretely, it does two things. First, whenever a **published** node is created
or updated, the module sends a notification to Silktide's API with that page's
URL, so Silktide re‑scans just the changed page within seconds rather than
waiting for a full site crawl. Second, on node pages it injects an encrypted meta
tag that lets the Silktide toolbar recognize your site and deep‑link an editor
from a scanned page straight to that node's Drupal edit form.

To use it you need a **Silktide account** and its **API key**, which you paste
into the module's settings form. The same key both authenticates the API
notifications and encrypts the editor deep‑link. Note that this module
deliberately "phones home" — it makes an outbound call to Silktide's servers on
every publish or update. That's expected behavior; to stop it, clear the API key
or uninstall the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (needs PHP 8.3+ and the OpenSSL extension).
2. [Configuration](configuration/index.md) — enter your Silktide API key and how
   the integration then behaves.

## Where it lives in the admin menu

The settings form is at **Configuration → Web Services → Silktide**
(`/admin/config/services/silktide`), behind the **Configure Silktide**
permission.

## How to use it

1. Get your API key from your Silktide account (under Settings → Integrations).
2. Enable the module, open the settings form, paste the key, and save.
3. Publish or update a node — Silktide is notified automatically and re‑scans the
   page.
