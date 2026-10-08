<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenApi Redoc Document Converter — manual setup guide

**OpenApi Redoc Document Converter** (`api_redoc_document`) lets you publish an
OpenAPI/Swagger specification as human-readable API documentation on a page of your
Drupal site. You place a special `<redoc spec-url="…">` tag in a node's body, and
the module loads the **Redoc** standalone JavaScript, which renders that spec into
formatted, browsable API docs right in the page.

It is presentation-only: it provides no routes, permissions or services, and there
is no admin settings form. The spec URL you point the tag at can be a remote URL or
a local file path serving JSON or YAML, and Redoc renders it **client-side** — the
browser fetches and formats the spec, not Drupal. The module also ships a small
stylesheet for basic styling of the output.

Two things are worth knowing before you use it. First, the Redoc library
(`redoc.standalone.js`) is loaded from the **jsDelivr CDN** as an external script,
which matters for offline/air-gapped installs or sites with a strict Content
Security Policy — see the installation notes. Second, the library attaches on
**every** page, not only the pages where you embed a spec. It supports Drupal 8, 9
and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   allow the `<redoc>` tag in the text format you'll use.

## How to use it

1. Enable the module and clear caches so the Redoc library attaches.
2. On the field where you want the docs (typically a node body), use a text format
   that allows the `<redoc>` tag — **Full HTML** works, or a filtered format
   configured so the tag is not stripped.
3. Embed the tag in the field, pointing it at your spec:
   `<redoc spec-url="path/to/spec.json"></redoc>`. The path may be a remote URL or
   a local file serving valid OpenAPI JSON or YAML.
4. View the page — Redoc renders the spec into formatted API documentation in the
   browser.

If nothing renders, check that the text format did not strip the `<redoc>` tag and
that the spec is valid OpenAPI JSON/YAML.
