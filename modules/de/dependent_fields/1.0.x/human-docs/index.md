# Dependent fields — manual setup guide

**Dependent fields** (`dependent_fields`) builds classic **cascading (chained)
dropdowns**: pick a value in one field and a second field's options are re-filtered
to match, refreshed over AJAX with no page reload. Choose a *Manufacturer* and the
*Model* field narrows to that manufacturer's models; choose a *Category* and the
*Sub-category* field shows only its children. It's the tidy, config-only way to
do country → state → city and similar parent-child selection.

It works by giving an entity-reference field a special **reference method** (an
entity-reference selection plugin) that filters its options through a **View**.
You tell the field which parent field it depends on and which View supplies the
options; the View takes the parent's value as its first contextual filter, so it
returns only the entities valid for that parent. When the parent changes on the
form, the module re-runs the View and swaps the child field's options in place.

A couple of things shape how you set it up. The child field's form widget must be a
**Select list** or **Check boxes / radio buttons** — the autocomplete widget isn't
supported. And you'll need **Views** enabled, with an Entity Reference display that
accepts the parent value as an argument. It supports single- and multi-value
fields and works inside Paragraphs subforms. There's no settings page, no
permissions, and no Drush — everything lives in the child field's configuration.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact handler-settings
keys and the AJAX mechanism — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Views required).
2. [Configuration](configuration/index.md) — build the options View and point a
   child field's reference method at its parent.

## Where it lives in the admin menu

There is no admin page of its own. You configure it on the **child** field's
settings form, under the **Manage fields** area of the bundle — for example
`/admin/structure/types/manage/article/fields/...`. See
[Configuration](configuration/index.md) for the full walkthrough.
