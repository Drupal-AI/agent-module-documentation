<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action Link Field (action_link_field) — agent index

Submodule of **action_link**. Outputs an action link as a **computed field** on the entity type it
targets. Depends on `action_link` and `computed_field`. Provides config schema; no permissions.

## What it provides

- **Output plugin** `computed_field` (`src/Plugin/ActionLinkOutput/ComputedField.php`,
  `#[ActionLinkOutput(id: "computed_field")]`). `appliesToActionLink()` requires the state action to
  implement `EntityActionLinkInterface` and have dynamic parameters exactly `['entity']`.
- **Computed field plugin** `action_link` (`src/Plugin/ComputedField/ActionLink.php`,
  `@ComputedField(id="action_link", field_type="action_linkset", no_ui=TRUE,
  deriver=ActionLinkDeriver)`, extends `ComputedFieldBase` + `SingleValueTrait`). Its
  `singleComputeValue()` returns a `#type => action_linkset` element (`#action_link` = derivative id,
  `#dynamic_parameters` = [host entity id]). Cacheability: `user` context, max-age 0.
- **Deriver** `src/Plugin/Derivative/ActionLinkDeriver.php` — one derivative per action link found via
  `storage->loadByUsingOutput('computed_field')`; sets `attach.field_name = action_link_<id>` and
  `attach.controlled_field` = the field the action link changes.
- **Field type** `action_linkset` (`src/Plugin/Field/FieldType/ActionLinkFieldItem.php`, extends
  `ComputedRenderArrayItem`, `no_ui`) — exists only to limit formatters.
- **Formatters** (`src/Plugin/Field/FieldFormatter/`): `action_linkset_default` (Default),
  `action_linkset_ajax` (forces `#link_style = 'ajax'`), `action_linkset_nojs` (forces `'nojs'`).

## Attachment & cache

`ActionLink::attachAsBaseField()` / `attachAsBundleField()` attach the computed field only if the
controlled field (`pluginDefinition['attach']['controlled_field']`) is present, matching its scope.
`action_link_field.module` implements action_link insert/update/delete hooks that clear the
`plugin.manager.computed_field` and `entity_field.manager` caches and invalidate `entity_field_info`
so the derived field appears/disappears as the `computed_field` output setting changes.

## Operate

Enable `computed_field`; on an action link's Output tab check **Computed field** and save; configure
the new `action_link_<id>` field's display per bundle in Manage Display. Click authorization/CSRF is
handled by the core controller.

## Solution docs

- `agent/output/computed-field.md` — output plugin, deriver, computed-field attachment, formatters.
