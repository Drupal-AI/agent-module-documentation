# Facets Link Field Processors — manual setup guide

**Facets Link Field Processors** (`facets_link_field_processors`) provides
[Facets](https://www.drupal.org/project/facets) processors built specifically for
Drupal's core **Link** field. When you facet on a link field, the raw facet values
are the stored URIs, which read poorly in a facet list. This module's processor
transforms those links — where they point at an entity — into that entity's
**translated label**, so a link‑field facet shows human‑readable names instead of
URLs.

The key plugin is **TranslateEntityInLinkProcessor**, which resolves entity links
in the facet results back to their labels. It is a display/readability
enhancement that relabels the facet values produced for the current facet, using
the referenced entity's translated label in the visitor's current language.

The module has **no central settings form** — you enable the processor on each
facet where you want it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no configuration page** for this module — you add the processor on each
facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Link Field Processors adds no admin page of its own. You configure it from
the **Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing a facet built on a link field.

## How to use it

1. Create a facet on a **Link** field as usual at **Configuration → Search and
   metadata → Facets**.
2. Edit the facet and, in its **processors**, enable
   **TranslateEntityInLinkProcessor** (the "translate entity in link" processor)
   provided by this module.
3. Save, then load the page with the facet and confirm entity links now display as
   their labels rather than raw URIs.
