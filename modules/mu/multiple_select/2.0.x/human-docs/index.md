# Multiple Select — manual setup guide

**Multiple Select** (`multiple_select`) adds a **"Select All / Uncheck All"** master
checkbox above a multi-value checkboxes field on entity edit forms, so editors can
tick or clear every option at once instead of clicking each box. It is a small
usability helper for content teams who regularly fill in long checkbox lists — think
category lists, tag references, or membership/permission-style option sets where
"all of the above" (or "none, then a few") is common.

The module has no field type or widget of its own. Instead you tell it, on a central
admin page, which existing fields should get the helper. It only works on
multi-value fields rendered with core's **"Check boxes"** widget (the
`options_buttons` widget on a `list_string` or `entity_reference` field) — a field
listed but shown with a different widget (select list, autocomplete) gets nothing.
When a matching field renders, the module injects the master checkbox just above it
and adds JavaScript that toggles all the child boxes together, and re-syncs the
master when you tick boxes individually. On an existing entity where every option is
already selected, the master starts pre-checked. It also cooperates with the Field
Group module, moving the master checkbox inside a field-group container when the
field lives in one.

The helper is applied on **node, media, taxonomy term, and site settings entity**
edit forms only. Your field choices are stored in a single configuration object
(`multiple_select.settings`, key `table`) as a JSON map, so they are exportable for
deployment. The module defines one permission that gates its config page and has no
dependencies beyond Drupal core.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing which fields get the
   Select-All helper.

## Where it lives in the admin menu

The configuration page is at **Configuration → Content authoring → Multiple Select
Helper** (`/admin/config/content/multiple-config`), gated by the *Access multiple
select config page* permission.

## How to use it

Enable the module, then on the config page pick the bundle and the checkbox
field(s) that should get the master toggle. Make sure those fields are multi-value
and are displayed with the **Check boxes** widget on *Manage form display*, or the
toggle will not appear. See [Configuration](configuration/index.md) for the full
walkthrough.
