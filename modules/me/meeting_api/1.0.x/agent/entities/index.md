<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity types: server, meeting type, meeting

Three entity types form the model. Two are config entities, one is content.

## `meeting_api_server` (config entity)

`src/Entity/Server.php` — `@ConfigEntityType(id="meeting_api_server")`, extends `ConfigEntityBase`,
implements `ServerInterface`.

- `config_prefix: meeting_api_server`, `admin_permission: "administer meeting_api_server"`.
- `config_export`: `id`, `label`, `description`, `backend`, `backend_config`.
- A server is a named endpoint bound to **one** backend plugin. `backend` is the plugin id;
  `backend_config` is that plugin's configuration (schema type
  `plugin.meeting_api_backend.[%parent.backend]`; validated by a `PluginExists` constraint).
- Holds a `DefaultSingleLazyPluginCollection` over `BackendPluginManager` so the backend plugin's
  config is managed as an embedded plugin (`getPluginCollections()` returns `backend_config`).
- Collection/add/edit/delete routes under `/admin/config/services/meeting-api-server`, all gated by
  `administer meeting_api_server` (`meeting_api.routing.yml`).
- Form: `Drupal\meeting_api\Form\ServerForm`. It renders the chosen backend's `configure` plugin
  form (AJAX "Change backend" button). **The backend is locked after first save** — the `backend`
  select is disabled on edit; changing it requires delete+recreate or an update hook (see README).
  If no backend plugins exist at all, the form shows a warning and hides Save.

## `meeting_api_meeting_type` (config bundle entity)

`src/Entity/MeetingType.php` — `@ConfigEntityType(id="meeting_api_meeting_type")`, extends
`ConfigEntityBundleBase`, `bundle_of: meeting_api_meeting`.

- `config_prefix: meeting_api_meeting_type`, `admin_permission: "administer meeting_api_meeting types"`.
- `config_export`: `id`, `label`, `description`, `server_id`, `uuid`.
- Each type points at exactly one server via `server_id` (schema `ConfigExists` constraint on
  `meeting_api.meeting_api_server.`). `calculateDependencies()` adds a hard config dependency on the
  referenced server, so a server cannot be deleted while a type uses it.
- Routes under `/admin/structure/meeting_api_meeting_types`. Form `MeetingTypeForm`; the `server_id`
  is likewise locked after creation.

## `meeting_api_meeting` (content entity)

`src/Entity/Meeting.php` — `@ContentEntityType(id="meeting_api_meeting")`, extends
`RevisionableContentEntityBase`, implements `MeetingEntityInterface`. Revisionable + owned
(`EntityOwnerTrait`) + changed-tracked. `admin_permission: "administer meeting_api_meeting entities"`,
`bundle_entity_type: meeting_api_meeting_type`, `field_ui_base_route` on the type edit form.

Base fields:

| field | type | notes |
|-------|------|-------|
| `label` | string | required, revisionable, translatable |
| `status` | boolean | default TRUE (Enabled/Disabled) |
| `uid` | entity_reference→user | owner; `preSave()` defaults to **uid 0 (anonymous)** if unset |
| `created` / `changed` | created / changed | timestamps |
| `datetime` | `daterange_timezone` | **required**; start+end with an explicit timezone (from `datetime_range_timezone`) |
| `max_attendees` | integer (unsigned) | required; default `0` = unlimited (`MeetingInterface::ATTENDEES_UNLIMITED`) |
| `backend_settings` | `map` | required; opaque per-backend blob (URL/room/passcode). Rendered by widget `meeting_api_backend_settings_widget`; **not** on the view display |

Key methods:

- `getServerId(): string` — reads the bundle's `server_id` (throws `\LogicException` if the bundle
  entity is missing).
- `getSettings(): array` — returns the `backend_settings` value (the per-meeting backend blob).
- `getIdentifier(): string` — returns the entity UUID.

Routing: `MeetingHtmlRouteProvider::getCanonicalRoute()` returns the **edit-form** route, so the
"canonical" meeting URL is the edit form (admin-gated) — there is no separate public view page.
List builder `MeetingListBuilder`; collection at `/admin/content/meeting`. Full revision UI is
enabled (`show_revision_ui = TRUE`).

## The `backend_settings` widget

`src/Plugin/Field/FieldWidget/BackendSettingsWidget.php` (`meeting_api_backend_settings_widget`,
for `map` fields). On a meeting form it resolves the bundle → server → backend plugin and, if that
backend declares a `meeting` plugin form (`BackendInterface::PLUGIN_FORM_MEETING`), embeds it as a
subform. If the backend has no meeting form, the field is a hidden element carrying the default
value. This is how a backend collects its per-meeting data (e.g. the Manual backend's URL field).

## Config schema & bundled actions

- Schema: `config/schema/meeting_api.schema.yml` (server, meeting type, and the
  `plugin.meeting_api_backend.*` mapping). Both config entities are `FullyValidatable`.
- `config/install/`: two `system.action` configs — `meeting_api_meeting_save_action` and
  `meeting_api_meeting_delete_action` (bulk save/delete meetings from the content list).
