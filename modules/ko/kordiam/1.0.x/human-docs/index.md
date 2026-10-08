# Kordiam — manual setup guide

**Kordiam** (`kordiam`) connects your Drupal site to
[Kordiam](https://www.kordiam.com/), a content‑strategy and editorial‑planning
tool for newsrooms and editorial teams. If your team plans stories and manages
your editorial department in Kordiam, this module links that planning to one or
more Drupal sites and keeps story lists and their metadata **in sync both ways**.

Two workflows are supported. In **planned content**, an article is planned and
enriched with metadata in Kordiam, and Kordiam automatically creates the
corresponding article in Drupal; later changes on either side sync instantly. In
**breaking news**, a story starts as an article in Drupal, and the module sends
the relevant data to Kordiam so the story lists stay complete. The metadata kept
in step includes the article description, publishing date/time, statuses,
categories, author emails, URLs on both systems, slug, headline, content type, and
a custom platform field.

The module talks to Kordiam over its API, and access is gated by the **`access to
Kordiam API`** permission. The API credentials are secrets — store them in an
environment variable rather than committed configuration (see
[Configuration](configuration/index.md)). You need a **Kordiam account** to use
the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Pathauto dependency, and enable it.
2. [Configuration](configuration/index.md) — enter your Kordiam API credentials
   securely and grant the API permission.

## Where it lives in the admin menu

Once enabled, the module exposes a settings form (under **Configuration**) where
you enter your Kordiam API credentials. Access to the Kordiam API is controlled by
the **`access to Kordiam API`** permission at **People → Permissions**.

## How to use it

Configure your Kordiam credentials and grant the API permission to the right
roles, then plan content in Kordiam (which creates/updates matching articles in
Drupal) or write breaking news in Drupal (which pushes data back to Kordiam).
Metadata stays synchronised between the two systems as editors work.
