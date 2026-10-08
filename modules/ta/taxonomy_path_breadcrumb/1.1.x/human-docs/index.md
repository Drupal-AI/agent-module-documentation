# Taxonomy Path Breadcrumb — manual setup guide

**Taxonomy Path Breadcrumb** (`taxonomy_path_breadcrumb`) lets you decide, one
vocabulary at a time, how breadcrumbs are built on taxonomy **term** pages. By
default Drupal builds a term‑page breadcrumb from the term's place in its
vocabulary hierarchy (parent terms). This module lets you switch a chosen
vocabulary over to core's **path/URL‑alias‑based** breadcrumb instead, so the
breadcrumb follows the term's URL structure rather than the term tree.

That is handy when your term pages live under a section landing path or have
Pathauto aliases that mirror your site's navigation — the path‑based breadcrumb
then matches what visitors actually see in the URL, which is usually better for
SEO and less confusing on flat (non‑hierarchical) vocabularies. You can mix
strategies freely: leave some vocabularies on the default hierarchy breadcrumb
and move others to path‑based, and roll the change out one vocabulary at a time.

The module works by delegating to core's own breadcrumb services, so there is no
custom breadcrumb rendering to maintain. It depends only on core's **Taxonomy**
module, adds no global settings page, no permissions, and no Drush commands.
Until you opt a vocabulary in, nothing changes — every vocabulary keeps Drupal's
default behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per‑vocabulary breadcrumb
   setting on the vocabulary edit form.

## Where it lives in the admin menu

There is no dedicated settings page. The one setting is added to each
vocabulary's edit form at **Structure → Taxonomy → *(your vocabulary)* → Edit**
(`/admin/structure/taxonomy/manage/<vocabulary>`), under a **Breadcrumb builder
settings** group.
