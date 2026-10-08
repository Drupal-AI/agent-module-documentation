# GatherContent — manual setup guide

**GatherContent** (`gathercontent`) connects Drupal to the GatherContent
(now "Content Workflow") SaaS platform and imports its content items into Drupal
nodes, taxonomy terms, and menu links. It's built for editorial teams who draft
and review content in GatherContent and then publish it in Drupal — replacing the
old copy‑and‑paste routine with repeatable, mapped imports.

Under the hood the module authenticates to GatherContent with an account email
and API key, fetches your projects, templates, and items, and builds **Migrate**
definitions that create or update Drupal entities. It maps GatherContent template
fields to Drupal fields — including files, images, and meta tags — and can keep
translations aligned. Optional submodules add the mapping UI and the ability to
push Drupal content back up to GatherContent.

> **Heads up — this package is no longer supported.** The upstream project has
> moved to *Content Workflow by Bynder*. If you are starting fresh, check whether
> you should adopt the successor rather than this module. This guide documents the
> module as it stands.

Because it talks to a third‑party API, the account email and API key are
credentials: keep them out of committed configuration and version control, and
store the key in an environment variable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in its
   Migrate dependencies, and enable the submodules you need.
2. [Configuration](configuration/index.md) — connect your GatherContent account
   and map templates to Drupal content.

## Where it lives in the admin menu

Once enabled (with the UI submodule), you'll find it under **Configuration →
Web services → GatherContent** (`/admin/config/services/gathercontent`).
Authentication is set on the `.../config` sub‑page and import mappings on the
`.../import-config` sub‑page. Access requires the **Administer GatherContent**
permission.
