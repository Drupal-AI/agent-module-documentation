# Field Tools — manual setup guide

**Field Tools** (`field_tools`) is a collection of utilities layered on top of
Drupal's core **Field UI**. It saves you from recreating fields by hand: you can
**clone** a single field from one bundle to another, bulk-clone several fields at
once, copy whole form or view **displays** between bundles, copy just one field's
widget/formatter settings, and **export** a bundle's fields as either base-field PHP
code or config YAML. It also adds site-wide **reports** listing every field and every
reference relationship on the site.

The tools appear as extra tabs in the "Manage fields" area of every fieldable bundle
— content types, taxonomy vocabularies, media types, and any other entity type that
uses Field UI — so you drive them from the same place you already manage fields.
There is no settings form to fill in; the module's "configuration" is really the set
of actions and reports it adds. A single **Clone** operation link also shows up next
to each field in a bundle's field list for one-click copying.

A nice touch: when you clone a field to another bundle, Field Tools also copies its
form- and view-display settings to any displays on the destination whose view-mode
names match the source — so a field arrives already formatted for teaser and full
view, not just added. When cloning across *different* entity types, it reuses shared
field storage where the field types are compatible.

Under the hood the real work lives in four services (a field cloner, a display
cloner, a display-settings copier, and a references-info reader), which developers
can call directly from code instead of driving the forms. Field Tools requires core's
**Field UI** module, adds one permission for its reports, and — when the optional
**GraphAPI** module is present — can even draw a field-reference graph.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the four services and their
signatures — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per-bundle tabs, the site-wide
   reports, the single-field Clone link, and the permission that gates the reports.

## Where it lives in the admin menu

Field Tools does not add a settings page. Its actions live under the **Tools** tab
on each bundle's *Manage fields* page (for a content type, e.g.
`/admin/structure/types/manage/article/fields/tools/…`), and its reports live under
**Reports → Fields** (`/admin/reports/fields`). See
[Configuration](configuration/index.md) for a tour of both.
