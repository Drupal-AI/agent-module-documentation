# Pluggable — manual setup guide

**Pluggable** (`pluggable`) is a small developer framework for building
"plugin‑backed fields" — fields whose selectable values come from Drupal's plugin
system rather than a static allowed‑values list. Where an ordinary list field
forces you to hard‑code its options in field configuration, a Pluggable field
draws its options from registered plugins, so other modules can contribute new
choices simply by adding a plugin.

Under the hood it provides a `pluggable_item` field type whose *derivatives* are
each backed by a plugin type, two widgets — **Pluggable select**
(`pluggable_select`) and **Pluggable radios** (`pluggable_radios`) — and a default
formatter (`pluggable_default`). Because Drupal core does not automatically expose
derivative field types to widgets and formatters, the module's `.module` file
wires them up with `hook_field_widget_info_alter()` and
`hook_field_formatter_info_alter()`. It adds no routes and no permissions — access
follows the host entity's normal field access.

> **Heads up: this module is obsolete.** Its own project page states plainly that
> it is no longer supported ("This module is obsolete... sorry..."), its
> maintenance status is *Unsupported*, and it is **not covered by Drupal's
> security advisory policy**. Treat it as a reference or a legacy dependency
> rather than something to adopt on a new build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
is a set of field and plugin building blocks used in code and on a field's
settings, described in "How to use it" below.

## How to use it

Pluggable is aimed at developers who want a field whose options are defined and
extended through the plugin system:

1. Define a plugin‑backed `pluggable_item` derivative for your plugin type in
   code.
2. Add that field to a content type at **Structure → Content types → *(type)* →
   Manage fields**.
3. On **Manage form display**, choose the **Pluggable select** or **Pluggable
   radios** widget for the field.
4. Any plugin registered for the backing plugin type then appears as an option —
   including options contributed by other modules — keeping the choice list in
   sync with the code rather than with static configuration.
