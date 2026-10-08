# Courier — configuration & admin routes

Courier is an API module; a dependent module usually sets things up. Direct config is minimal.

## `courier.settings` (config object; defaults in `config/install/courier.settings.yml`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `skip_queue` | bool | `false` | When true, `CourierManager::sendMessage()` sends in the same request instead of queueing. "Can impact performance significantly." |
| `channel_preferences` | sequence (identity type → ordered list of channel entity types) | `{ user: [courier_email] }` | The preferred channel order per identity type. |

Schema: `config/schema/courier.schema.yml` (also defines `courier.context.*`,
`courier.template_collection.*`, and the `courier.template.courier_email` template shape:
`{subject, body}`).

## Admin routes (`courier.routing.yml`)

| Route | Path | Requirement |
|---|---|---|
| `courier.admin.settings` | `/admin/config/communication/courier` | `administer courier` |
| `courier.admin.maintenance` | `/admin/config/communication/courier/maintenance` | `administer courier` |
| `courier.admin_config_communication` | `/admin/config/communication` | `access administration pages` |
| `entity.courier_email.canonical` / `.edit_form` / `.delete_form` | `/courier/email/{courier_email}...` | `_entity_access: courier_email.*` |
| `entity.courier_template_collection.channel` / `.tokens` | `/courier/collection/{…}/template/{courier_channel}`, `/tokens` | `_entity_access: courier_template_collection.templates` |

- **Settings form** (`Form\Settings`) edits `skip_queue` and the channel preferences.
- **Maintenance form** (`Form\CourierMaintenanceForm`) provides housekeeping operations.
- `courier_email` entity operations are gated by its `admin_permission = "administer courier_email"`
  (that permission is **not** granted by `courier.permissions.yml`, so by default only user 1 / a role
  explicitly given every permission can reach the email edit/delete/view routes).

## Optional integration

Install the contrib **Token** module for an improved token-selection UI on message edit forms
(`CourierTokenElementTrait` / `TokenTrait`). Not required.
