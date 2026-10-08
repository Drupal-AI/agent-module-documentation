# Pantheon Content Publisher — manual setup guide

**Pantheon Content Publisher** (`pantheon_content_publisher`) connects your Drupal
site to **Pantheon's Content Cloud**, so authors can draft, preview, and publish
content straight from **Google Docs** into Drupal. It's aimed at Pantheon-hosted
sites using the Content Publisher service, and it leans on Drupal's **Search API**
to index the content it brings in.

Its headline features are realtime and draft previews, approval-workflow support,
smart components, publish/unpublish directly from Google Docs, and custom metadata
fields. Content flows from Pantheon's service into Drupal over an authenticated
connection, and the module provides its own permission for who may manage that
connection. It supports Drupal 10 and 11 and PHP 8.2–8.5.

Because it talks to an external service with credentials, two things matter for a
safe setup: **store the access token as a secret** (via the Key module, not in
exported configuration) and keep the connection over **HTTPS**. Also treat content
imported from the external source according to how much you trust that source. The
[Configuration](configuration/index.md) page walks through both the credential
storage and the collection setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Search API
   dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — store the Pantheon access token as a
   secret, create a Search API server, and add a Content Publisher collection.

## Where it lives in the admin menu

After installation you configure the connection under **Structure → Pantheon
Content Publisher Collection**, where you add a collection with your access token
and the Collection Identifier from the Content Publisher dashboard. See
[Configuration](configuration/index.md).
