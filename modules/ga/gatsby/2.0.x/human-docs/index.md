# Gatsby — manual setup guide

**Gatsby** (`gatsby`) connects a Drupal back-end to a
[GatsbyJS](https://www.gatsbyjs.com/) front-end in a decoupled ("headless") setup.
It gives content editors a live **preview** of how their draft will look on the
Gatsby site, triggers **incremental and full builds** when published content
changes, and serves a **Fastbuilds** incremental-sync feed so Gatsby only has to
pull the entities that actually changed since its last sync.

The module watches content-entity changes (insert, update, delete) and, for the
entity types you opt in, sends a fire-and-forget webhook to your Gatsby preview and
build endpoints. It also records every change as a log entity so the
`gatsby-source-drupal` plugin can fetch just the deltas from a sync endpoint.
Editors get an **Open Gatsby Preview** button on moderated node forms (this needs
core Content Moderation) and, optionally, an inline iframe preview embedded right in
the edit form.

Almost everything is driven from one settings form: your Gatsby server URL, the
preview / build / content-sync webhook URLs, path mappings, which entity types are
sent, private-file handling, and how long the Fastbuilds log is kept. Three
submodules ship with it, though only **gatsby_extras** (a JSON:API menu/link
enhancer) is generally useful today — the other two are hidden legacy stubs whose
behavior has been folded into the main module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and understand its dependencies and submodules.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus the per-content-type preview button and iframe preview.

## Where it lives in the admin menu

- **Settings:** **Configuration → Web services → Gatsby → Settings**
  (`/admin/config/services/gatsby/settings`).
- **Fastbuilds log:** **Configuration → Web services → Gatsby → Fastbuilds logs**
  (`/admin/config/services/gatsby/fastbuilds/logs`).

## How to use it

The typical flow is: install the module and its dependencies, fill in your Gatsby
**server URL** and **webhook URLs** on the settings form, tick the **entity types**
you want sent to Gatsby, then (for previews) turn on the preview button per node
type and make sure those bundles use Content Moderation. See
[Configuration](configuration/index.md) for the details and for the
Fastbuilds sync endpoint.
