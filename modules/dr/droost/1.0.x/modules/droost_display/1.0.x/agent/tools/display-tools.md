<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost Display — MCP tools

## Install & enable
```bash
drush en droost_display -y   # pulls ui_patterns + ui_patterns_field_formatters
```
If Drupal Canvas is also installed, apply the SDC-manager coexistence patch first (drupal.org #3561618) —
`droost_display.install`'s `hook_requirements` warns about this at install time. All tools require the
mcp_server `access mcp server` permission and return the `{success, message, data}` envelope.

## `droost_display_sources` (read-only) — `src/Plugin/Tool/DisplaySources.php`
"What can feed this prop or slot?" Inputs: `prop_type` (omit for the whole prop-type registry), plus
`entity_type` (default `node`) + `bundle` + `field` to unlock that field's dynamic sources, and `per_item`
(default true). Uses `PropTypePluginManager` for the registry and `SourcePluginManager::getDefinitionsForPropType()`
/ `getPropTypeDefault()` filtered by the contexts from `DisplayContextBuilder`. Each source row: `{id, label,
description, prop_types, tags, context_requirements, is_default}`.

## `droost_display_get` (read-only) — `src/Plugin/Tool/DisplayGet.php`
Inputs: `bundle` (required), `entity_type` (default `node`), `view_mode` (default `default`). Returns `display`
metadata (`persisted`, `status`), `components` (each `{field, formatter, label, weight, region, component, settings}`;
`component` is non-NULL only for `ui_patterns_component` / `ui_patterns_component_per_item` formatters, unwrapped to
`{component_id, variant, per_item, props, slots}`), `hidden` field list, and `fields` (viewable field definitions).
Read shape — the component is nested per field, not a drop-in compose payload.

## `droost_display_compose` (DESTRUCTIVE — config write) — `src/Plugin/Tool/DisplayCompose.php`
Inputs: `bundle` + `items` (required), `entity_type`, `view_mode`, `hide_others` (default true), `dry_run`
(default false). Each item: `{field, component, variant?, props?, slots?, label?, weight?, per_item?}` where
`props` maps prop name -> `{source_id, source?}` and `slots` maps slot name -> ordered list of `{source_id, source?}`.

Gating (`execute()`): when not a dry run it first calls `requireCliTransport()` then `gate('allow_config_write')`
(inherited from `DestructiveToolBase`); either returning non-NULL blocks the write. `dry_run: true` bypasses the gate
and returns the computed `{content, hidden, core_managed, persisted:false}` without saving.

Validation is all-or-nothing (`validateItem()`): unknown/undisplayable fields, unknown components, unknown
prop/slot names, unbound required props, invalid variant/label, inapplicable sources
(`checkSourceApplicability()`), the silent-empty `entity_link`-needs-`template` case, and the date-only-datetime
`field_formatter` trap (`silentEmptyFormatterError()`) are all rejected before any write. On success it
`setComponent()`s each field, optionally `removeComponent()`s the rest (base fields that aren't view-configurable are
reported as `core_managed`, not hidden), `save()`s, and returns `dependencies`.
