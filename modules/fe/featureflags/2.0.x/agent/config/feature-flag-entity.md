<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# featureflag config entity, admin UI, and state storage

Source: `src/Entity/FeatureFlag.php`, `src/Entity/FeatureFlagInterface.php`,
`src/Form/FeatureFlagForm.php`, `src/EntityHandlers/FeatureFlagListBuilder.php`,
`featureflags.permissions.yml`, `featureflags.links.menu.yml`,
`featureflags.links.action.yml`, `config/schema/featureflags.schema.yml`.

## The entity

`@ConfigEntityType(id = "featureflag")` with `config_prefix = "flag"`, so each flag is stored as
config `featureflags.flag.{id}`. `entity_keys`: `id = id`, `label = name`.
`admin_permission = "administer featureflag entities"`. `config_export` = `name`, `id`,
`description` — **only the definition is exported**, never the on/off state.

Schema (`config/schema`, `featureflags.flag.*` → `type: config_entity`): `name` (label), `id`
(string), `description` (text).

Handlers: `list_builder` = `FeatureFlagListBuilder`; `access` = core
`EntityAccessControlHandler`; forms `default` = `FeatureFlagForm`, `delete` = core
`EntityDeleteForm`; `route_provider.html` = core `AdminHtmlRouteProvider` (this is why there is no
`featureflags.routing.yml`).

Entity links / routes (all gated by `administer featureflag entities`):

- `collection` `/admin/structure/feature-flags`
- `add-form` `/admin/structure/feature-flags/add`
- `edit-form` `/admin/structure/feature-flags/manage/{featureflag}`
- `delete-form` `/admin/structure/feature-flags/manage/{featureflag}/delete`

Menu link `entity.featureflag.collection` sits under `system.admin_structure`; action link
`entity.featureflag.add_form` appears on the collection.

## Where the on/off state lives (important)

The config entity stores only name/id/description. The **active/inactive boolean is stored in the
State/key-value store**, collection `featureflags`, keyed by the flag id — see
[../api/flag-checks.md](../api/flag-checks.md). Consequences:

- State is **not** part of exported config; each environment keeps its own value. A `drush cex`
  will export new/changed flag *definitions* but not their on/off state.
- Deleting a flag also cleans up its state: `FeatureFlag::postDelete()` calls
  `featureflags.manager->deleteMultiple([...ids])`.

## The edit/add form (`FeatureFlagForm extends EntityForm`)

Fields built in `form()`:

- `name` — textfield, required, maxlength 255 (the entity label).
- `id` — `machine_name` (source `name`, `exists` = `FeatureFlag::load`), disabled once the entity
  is not new.
- `description` — textarea.
- `active` — checkbox, `#default_value => $flag->getState()`. **This is the toggle.**

`save()` calls `$flag->save()` (persists the definition) then
`$flag->setState((bool) $form_state->getValue('active'))` (persists the state via the manager),
shows a status message, and redirects to the collection. As a standard `EntityForm` POST, this is
protected by Drupal's Form API (CSRF token + `administer featureflag entities`).

## List builder (`FeatureFlagListBuilder`)

Columns *Name* (link to edit-form), *Description* (`$entity->getDescription()`), *Status*
(`getState()` → `Active`/`Inactive`). Values go through the render array / `#theme => 'table'`
path (auto-escaped); no raw markup is emitted.

## Static/instance API on the entity

See [../api/flag-checks.md](../api/flag-checks.md) for `isActive()`, `setActive()`,
`setInactive()`, `getState()`, `setState()`, `getDescription()`.

## Operate it

1. `drush en featureflags -y` (or install via the UI). No dependencies.
2. Grant `administer featureflag entities` to trusted roles only.
3. Add a flag at `/admin/structure/feature-flags/add`; give it a machine name and tick *Active*
   when you want it on.
4. Reference the flag id from code, cache metadata, or a block condition.
