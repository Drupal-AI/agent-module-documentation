# Overview Field — manual setup guide

**Overview Field** (`overview_field`) is a small, developer‑oriented field type.
It gives you a field whose allowed values are supplied by **code** rather than by
configuration: the widget is a select list whose options come from a hook, so an
editor picks a named "overview" and a module decides what that name renders.

It solves a recurring structural problem. Suppose a content type needs a slot
where an editor chooses *which* dynamic listing appears — recent news, upcoming
events, the staff in this department — but the set of available listings is a
developer concern that changes with code, not with content. A plain text field
invites typos; a config‑defined allowed‑values list means a config change every
time a developer adds an option. Overview Field puts the option list behind an
alter hook instead: modules register what they can render, the editor picks from
the resulting select, and the formatter dispatches on the stored key.

It is deliberately thin. The field stores a 255‑character string, the widget is a
select with a "No overview" empty option, and the formatter renders whatever the
chosen key maps to. Two hooks do the work — `hook_overview_field_options_alter()`
registers the option labels, and `hook_overview_field_output_alter()` returns the
render output for a chosen key. The `overview_field_example` submodule shows a
complete, working implementation you can copy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and (optionally) the
   example submodule.

There is **no configuration page** for this module. You add it like any field on
a content type and supply the options from code, as described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). You
   need to be comfortable writing a small custom module — this is a developer
   extension point.
2. Add an **Overview** field to a content type (or any fieldable entity) via
   **Structure → Content types → *(type)* → Manage fields**, then set its display
   under **Manage display**.
3. In a custom module, implement `hook_overview_field_options_alter()` to add the
   named options an editor can pick (for example `recent_content` → "Show recent
   content"), and `hook_overview_field_output_alter()` to return what each key
   renders (a View, a block, or any custom markup).
4. Editors then choose an overview per node from the select widget, and your code
   decides what appears. Look at `overview_field_example` for a full example.
