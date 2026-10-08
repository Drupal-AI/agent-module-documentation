<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Castorcito — entities, routes, permissions, config schema

## Install & enable

```bash
composer require drupal/castorcito
drush en castorcito -y
```

Pulls in `json_field`, `rest`, `twig_tweak`, `file`, `image`, `help`, plus the PHP lib
`enshrined/svg-sanitize`. Admin landing page: `/admin/castorcito` (menu *Castorcito*, route
`castorcito.admin`). Primary config route (`configure` key): `entity.castorcito_component.collection`.

## Config entities

Both defined in `src/Entity/`:

- **`castorcito_component`** (`Castorcitocomponent`, config_prefix `component`). Config-exported
  keys: `id`, `label`, `description`, `model` (JSON string — the component's field skeleton),
  `field_configuration` (a plugin collection of cfields), `inside_container` (bool),
  `category`, `form_settings` (`enable_edit_name`, `collapse_component`), `display_settings`,
  `sdc` (`fixed_sdc`, `provider`, `id`). Implements `EntityWithPluginCollectionInterface`; its
  `field_configuration` is a `CastorcitoComponentFieldPluginCollection`. Form handlers: add/edit
  (`CastorcitoComponentAddForm`/`EditForm`), delete (core `EntityDeleteForm`), clone
  (`CastorcitoComponentCloneForm`).
- **`castorcito_category`** (`CastorcitoCategory`, config_prefix `castorcito_category`): `id`,
  `label`, `description`.

## Permissions (`castorcito.permissions.yml`)

- `administer castorcito component` — **restrict access: true**; gates every admin route and is
  the `admin_permission` of both entity types.
- `use castorcito button paste`, `use castorcito button copy` — allow the widget's copy/paste
  buttons (surfaced to JS via `CastorcitoManager::getUserPermissions()`).

(An older `use castorcito` permission is revoked by update hook `castorcito_update_10104`.)

## Routes (`castorcito.routing.yml`) — all require `administer castorcito component`

| Route | Path | Handler |
|---|---|---|
| `castorcito.admin` | `/admin/castorcito` | `CastorcitoController::castorcitoAdminMenuBlockPage` |
| `entity.castorcito_component.collection` | `/admin/castorcito/component` | list builder |
| `entity.castorcito_component.add_form` / `.edit_form` / `.delete_form` / `.clone_form` | `/admin/castorcito/component[/add|/{id}|/{id}/delete|/{id}/clone]` | entity forms |
| `entity.castorcito_component.inuse_modal` / `.inuse_page` | `…/{id}/in-use` | `CastorcitoController::inUseModal` / `CastorcitoComponentInUsePageForm` |
| `castorcito.component_display_settings` / `_delete` | `…/{id}/display-settings[...]` | display-settings forms |
| `castorcito.component_field_add_form` / `_edit_form` / `_delete_form` | `…/{id}/(add|edit|delete)/{field_type}` | cfield forms |
| `castorcito.view_model` | `…/view-model/{id}` | `CastorcitoController::viewJson` (renders `model` JSON) |
| `entity.castorcito_category.*` | `/admin/castorcito/component/category[...]` | category entity forms |
| `castorcito.list_override_component_config` / `.override_config_form` | `/admin/castorcito/(list-override-component-config|override-config-form)/…` | `CastorcitoComponentOverrideConfigController` / `…OverrideConfigForm` |
| `castorcito.list_override_component_display` / `.override_display_form` | `/admin/castorcito/(list-override-component-display|override-display-form)/…` | `CastorcitoComponentOverrideDisplayController` / `…OverrideDisplayForm` |
| `castorcito.field_list_text_allowed_value_form` | `/admin/castorcito/{component_id}/field-allowed-value/{field_name}` | `CastorcitoFieldListTypeAllowedValueForm` |

Menu/action/task links: `castorcito.links.menu.yml` (toolbar item), `.links.action.yml`
(Add component / Add category), `.links.task.yml` (Components/Categories tabs; Edit/Model tabs).

## Config schema (`config/schema/castorcito.schema.yml`)

Defines `castorcito.component.*`, `castorcito.castorcito_category.*`, the widget settings
(`field.widget.settings.castorcito_component_widget` → `components` sequence,
`components_settings` ignore) and the formatter settings
(`field.formatter.settings.castorcito_component_formatter` → `components_display_settings`
ignore). Each cfield's settings map is keyed dynamically as
`settings: type: castorcito.field.[%parent.id]`, with a concrete schema per cfield
(`castorcito.field.image`, `…container`, `…advanced_container`, `…iframe`, `…list_text`,
`…block_reference`, `…entity_reference`, `…formatted_text`, `…link`, `…boolean`, `…number`,
`…plain_text`; the `date` schema ships in castorcito_date).

## Update hooks (`castorcito.install`)

`10101` re-imports the `taylored` category config; `10102` moves existing JSON fields onto the
`castorcito_component_widget` across a set of content entity types; `10103` migrates
collapse/enable-edit-name into `form_settings`; `10104` revokes the legacy `use castorcito`
permission; `10105` removes the obsolete `api_link` block_reference setting.

## Libraries (`castorcito.libraries.yml`)

`castorcito.widget` (Vue 3 from unpkg + `castorcito_app.js`), `castorcito.admin`
(uses `json_field/jquery.jsonview`), `castorcito.form_validation`, `castorcito.field.list_text`.
