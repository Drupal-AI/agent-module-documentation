# Document Loader Plugin - API — manual setup guide

**Document Loader Plugin - API** (`document_loader_plugin_api`) is a **loader plugin
for [Document Loader](../../../document_loader/2.0.x/human-docs/index.md)** that fetches
data from **HTTP/HTTPS API endpoints** and converts the response into several output
formats. It lets a Drupal site pull content from a third-party API as a document
source and turn a JSON response into **TOML, JSON, YAML, or plain text** — handy for
importing, processing, and displaying external API data through the same normalized
Document Loader interface you use for files and web pages.

Once enabled it becomes one of the loaders Document Loader can dispatch to. The
endpoint URL and any credentials are **admin-configured**; store credentials
securely (backed by an environment variable rather than committed config). It
depends on the **Document Loader** module and supports Drupal 10.3+ and 11.

Because the plugin makes an **outbound request from your server** to whatever
endpoint it is pointed at, keep it pointed at trusted APIs and restrict who can
configure that endpoint.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no standalone settings form** documented for this plugin; it is
configured through Document Loader (and any credentials it needs should come from an
environment variable). After enabling it, the API plugin appears at **Configuration
→ Media → Document Loader** (`/admin/config/media/document-loader`).

## Where it lives in the admin menu

The plugin is listed in the Document Loader configuration at **Configuration → Media
→ Document Loader** as an available loader, where you point it at an endpoint and
choose the output format. It adds no separate settings page of its own.
