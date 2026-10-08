# Bibliocommons Book List — manual setup guide

**Bibliocommons Book List** (`bibliocommons`) renders book lists pulled from
BiblioCommons — the library discovery platform many public libraries use — so a
library website can display curated lists such as staff picks or new arrivals
straight from its BiblioCommons catalog. The lists are fetched through the
BiblioCommons API and presented using UI Patterns.

It is an integration and content-display feature: the module talks to an external
service (BiblioCommons) to fetch the list data, then hands it to UI Patterns for
rendering on your pages. This lets a library keep its featured reading lists in
BiblioCommons and surface them on its Drupal site without copying them by hand.

Because it calls an authenticated external API, it needs BiblioCommons API
credentials. These are stored through the **Key** module and backed by an
environment variable rather than being written into plain configuration — see the
[Configuration](configuration/index.md) guide for the secure-credential steps.
Administration of the module is gated by the `administer bibliocommons` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies (Key, WSData, UI Patterns).
2. [Configuration](configuration/index.md) — store the BiblioCommons API key
   securely and connect the module to your catalog.

## Where it lives in the admin menu

Administration is controlled by the `administer bibliocommons` permission (set it
under **People → Permissions**, `/admin/people/permissions`). The API key it needs
is managed as a **Key** entity under **Configuration → System → Keys**
(`/admin/config/system/keys`).

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Store your BiblioCommons API key securely and configure the module (see
   [Configuration](configuration/index.md)).
3. Grant the `administer bibliocommons` permission to the roles that should manage
   the integration, then display the book lists fetched from your catalog using the
   UI Patterns rendering.
