# Required API — manual setup guide

**Required API** (`required_api`) replaces a field's simple "Required field"
checkbox with a pluggable **required strategy**. Instead of a field being flatly
required or not, other modules can supply strategies that decide *dynamically* —
per entity, per context, per role — whether a given field is required at the moment
the form is built. Required API also cleans up after itself: when a strategy makes
a field optional, it strips core's spurious "field is required" error so the form
saves cleanly.

On its own, the module ships the framework plus two built-in strategies: **Core**
(the `default` — simply defers to the field's own required flag) and a **Broken**
fallback that treats a field as always required if its configured strategy's module
has gone missing. The real power comes from add-on strategies (for example "required
only for role X" or "required if another field is filled"), which developers
implement as plugins. You pick a strategy per field on that field's settings form,
and set a site-wide default strategy on a small settings page.

It has no module dependencies, requires **PHP 8.1+**, and provides a plugin type so
other modules can extend it. This is very much a **content-editing / developer**
tool: enabling it changes how the field-settings form looks (the core Required
checkbox is hidden in favour of the strategy radios), but it won't change any
field's behaviour until you either choose a non-default strategy on a field or a
contrib module adds one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to write your
own strategy plugin — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the site-default strategy page and
   choosing a strategy per field.

## Where it lives in the admin menu

- **Site default strategy:** **Configuration → User interface → Required**
  (`/admin/config/user-interface/required`), gated by the **Administer required
  settings** permission.
- **Per-field strategy:** on each field's settings form (*Manage fields → edit* a
  field), where the strategy radios replace the core Required checkbox.
