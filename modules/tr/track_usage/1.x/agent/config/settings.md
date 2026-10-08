<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permission

## Install / enable

`drush en track_usage`. No hard module dependencies. Track plugins for optional modules
(Linkit, Entity Embed, Media Embed, Dynamic Entity Reference, Block Field, Redirect,
Entity Browser Block) only take effect when those modules are present; the plugins are still
discovered but yield nothing without their target modules. After enabling, create at least one
`track_usage_config` at `/admin/config/system/usage-track`.

## Permission & routes

One permission: **`administer track usage`** (`track_usage.permissions.yml`). It gates everything:

- `entity.track_usage_config.collection` → `/admin/config/system/usage-track` (list, add link,
  local tasks) — from `AdminHtmlRouteProvider` + `admin_permission` on the entity type.
- `.add_form` `/…/usage-track/add`, `.edit_form` `/…/usage-track/manage/{id}`,
  `.delete_form` `/…/usage-track/manage/{id}/delete`.
- `track_usage.settings_form` → `/admin/config/system/track-usage/settings` (`_permission:
  administer track usage`, `track_usage.routing.yml`). Note the collection path segment is
  `usage-track` while the settings route uses `track-usage`.

`configure` in `.info.yml` points at `entity.track_usage_config.collection`. There are **no**
anonymous/public routes and no tracking endpoint — recording is driven entirely by entity
lifecycle hooks and bulk rebuilds, never by an inbound HTTP request carrying usage data.

## The config entity: `track_usage_config`

Class `src/Entity/TrackConfig.php` (`#[ConfigEntityType(id: 'track_usage_config',
config_prefix: 'config')]`). Config names look like `track_usage.config.<id>`. Schema in
`config/schema/track_usage.schema.yml` (`track_usage.config.*`). Exported/config properties:

- `id` (machine name, **max 32 chars**), `label` (required).
- `trackPlugins`: `list<string>` of Track plugin IDs to use; **empty = all plugins**. Each entry
  is constrained by `PluginExists` against `TrackPluginManagerInterface`.
- `activeRevision` (bool, default TRUE): track only the active/default revision of source
  entities.
- `realTimeRecording` (bool, default FALSE): record on entity insert/update/delete. If FALSE,
  records are only (re)built by a manual bulk update.
- `source`, `traversable`, `target`: each a `track_usage.list` = map of *entity type ID* →
  *list of bundles* (empty bundle list = all bundles). `source` and `target` are **required**
  (validated in `TrackConfigForm::validateForm` — at least one entity type each). `source` and
  `traversable` entity types are restricted to fieldable types; `target` may be any type.

`TrackConfig` role checks: `isSource()`, `isTraversable()`, `isTarget()` all delegate to
`checkEntityRole()` — a type is in a role if its entity-type ID is a key of that role's list and
either the bundle list is empty or the entity's bundle is in it.

### Form behavior (`src/Form/TrackConfigForm.php`)

- Checkboxes for track plugins (labels from the plugin manager; none checked = all).
- A `details` element per role (Source/Traversable/Target) with an "All bundles" pseudo-option
  (`__all_bundles__`) that, when checked, stores an empty bundle list.
- `validateForm()` normalizes the checkbox trees into the config shape and enforces the
  source/target requirement; on save it always redirects to the collection.
- `submitForm()` compares the JSON of the original vs. saved config and, if anything changed,
  shows a warning linking to the settings page: tracking data may need a full rebuild.

## The settings object: `track_usage.settings`

Config object with a single key **`bulk_update`** (schema `track_usage.settings`, install default
`batch`; `config/install/track_usage.settings.yml`). Allowed values (a `Choice` constraint and the
`BulkUpdateMethod` enum): `batch`, `queue`, `instant`.

Settings form `src/Form/TrackUsageSettingsForm.php` (`ConfigFormBase`, route above):

- A radios element bound to `track_usage.settings:bulk_update`.
- A **"Bulk update now"** submit button that saves the setting and then, in
  `bulkUpdateSubmit()`, loads every enabled `track_usage_config` and calls
  `Updater::update(BulkUpdateMethod::from($method), $config)` — i.e. rebuilds all usage data
  using the chosen method. This is a standard POST form submit (CSRF-protected by Form API), not
  a state-changing GET.
