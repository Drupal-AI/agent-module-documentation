# Config entity reference selection — manual setup guide

**Config entity reference selection** (`config_entity_reference_selection`) fills a
gap in Drupal's entity reference fields. Fields that point at *content* entities
have a rich selection story — views-based selection, bundle filters, per-bundle
sort. Fields that point at *configuration* entities do not: a field referencing
image styles, text formats, view modes, workflows, or roles normally offers **every
one that exists** — and every one any module adds later. The result is a long,
unfocused options list, and editors picking things the site never intended to
offer.

This module closes that gap. It derives an **Entity Reference Selection plugin for
every configuration entity type** on your site, so a field's settings can name the
exact allowed set. A "layout style" field can then list three image styles instead
of forty, and a new style added by a contrib module later does **not** silently
appear as an option. The classic example: a content type has an entity reference
field for a Webform, editors are meant to choose from three of them — but the site
has over 200 webforms. With this module, only the three you allow are offered.

It's developer- and site-builder-facing infrastructure with **no UI of its own**
beyond the field settings, and no dependencies. One property worth knowing: because
the allowed list is stored as *field configuration*, it exports and deploys with
everything else — the constraint travels between environments instead of living in
one developer's head. The core requirement (`^10.1 || ^11 || ^12`) reaches into a
major that doesn't exist yet, so it's ready for future upgrades.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from an entity reference field's settings, described below.

## Where it lives in the admin menu

The module adds no admin page. Its selection method shows up in the **Reference
method** dropdown on an entity reference field that targets a configuration entity
type, under **Structure → *(bundle)* → Manage fields → *(the field)* → field
settings**.

## How to use it

1. Add or edit an entity reference field whose target is a **configuration** entity
   type (for example a field referencing Image styles, Text formats, or Webforms).
2. On the field's settings form, set the **Reference type / Reference method** to
   the selection handler this module provides for that target type.
3. In the handler's settings, choose the **specific allowed items** — the subset of
   config entities editors should be able to pick from.
4. Save the field. Content editors now see only your curated list, and it stays
   stable as other modules add more config entities of that type. Because the list
   is field configuration, remember to export it (`drush config:export`) so the
   constraint deploys with your other config.
