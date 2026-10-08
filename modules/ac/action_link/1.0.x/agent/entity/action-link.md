<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# action_link config entity

`src/Entity/ActionLink.php` (`ConfigEntityType id="action_link"`, interface `ActionLinkInterface`).
An action link stores configuration; its behaviour is delegated to plugins.

## Stored config (`config_export`)

- `id`, `label` — machine name and human name.
- `plugin_id` — the State Action plugin ID (the logic).
- `plugin_config` — that plugin's configuration (schema keyed by `plugin_id`, see below).
- `link_style` — the Link Style plugin ID (the UX; `ajax`, `reload`, `post_link`,
  `post_link_ajax`, `confirm_form_page`).
- `output` — sequence of Action Link Output plugin configs, keyed by output plugin ID
  (`entity_links`, `computed_field`, etc. from submodules). `usesOutputPlugin($id)` tests membership.

Plugins are held in `DefaultSingleLazyPluginCollection`s (`getStateActionPluginCollection()`,
`getLinkStylePluginCollection()`); `set('plugin_id', …)` clears the state-action collection so it is
rebuilt. `setOverrideLinkStyle()` temporarily swaps the link style (used by the controller for
graceful degradation and by theming) without saving.

## Routing & cache

`getRouteName()` = `action_link.action_link.<id>`. `postSave()` / `postDelete()` call
`router.builder`'s `setRebuildNeeded()` because each entity contributes a dynamic action route
(see `agent/plugins/link-styles.md`).

## Access & permissions

`action_link.permissions.yml` declares `administer action_link entities` (`restrict access: TRUE`,
the entity `admin_permission`) and a `permission_callbacks` entry
`ActionLinkPermissions::permissions`, which emits per-entity permissions via
`ActionLink::getPermissions()`:
- `use <id> action links` — general permission to use that action link in all directions/states.
- plus any state/direction permissions the state action plugin adds (`getStateActionPermissions()`;
  core field plugins add none).

Runtime authorization for a click is computed by two entity methods:
- `checkGeneralAccess($account, …$params)` = `use <id> action links` **AND**
  `stateActionPlugin->checkOperandGeneralAccess()`. Used when building links to decide whether to
  show anything.
- `checkStateAccess($direction, $state, $account, …$params)` = (`use <id> action links` **OR**
  `checkPermissionStateAccess()`) **AND** (`checkOperandGeneralAccess()` **OR**
  `checkOperandStateAccess()`). This is the check enforced by the controller before a state change.

`checkReachable($direction, $state, …)` confirms the requested target state equals the plugin's
computed next state for the direction (guards against stale links).

## Forms & UI

Handlers (in the entity annotation): default `ActionLinkForm` (add/edit — picks state action +
link style, embeds the plugin config form via the `action_plugin` / `link_style_plugin` custom form
elements in `src/Element/`), `ActionLinkOutputForm` (the Output tab), `EntityDeleteForm`,
`ActionLinkDemoForm` (the Demo tab — renders a live link set). List builder
`ActionLinkListBuilder`; storage `ActionLinkStorage` (adds `loadByUsingOutput($output_plugin_id)`
used by the output submodules). Admin UI lives at
`/admin/structure/action_link` (menu link `entity.action_link.collection`), with Edit / Output /
Demo local tasks (`action_link.links.task.yml`).

## Config schema (`config/schema/action_link.schema.yml`)

`action_link.action_link.*` maps the stored config. `plugin_config` uses the dynamic type
`action_link.action_link_plugin.[%parent.plugin_id]`; core field plugins define
`action_link.action_link_plugin.{boolean_field,numeric_field,options_field,date_field}` with
`entity_type_id`, `field`, optional `step`, and a `texts` mapping. Label/message texts use the
geometry schemas `action_link.action_link_geometry.toggle` (per state) and
`…geometry.inc_dec` (per direction). Output plugin config: `action_link.action_link_output_plugin.*`.
