# Permissions

Defined in `services_api_key_auth.permissions.yml`.

| Permission | Title | Gates |
|---|---|---|
| `administer services_api_key_auth` | Administer Services Api Key Auth | The key collection route (`entity.api_key.collection`), the settings form (`services_api_key_auth.api_key_auth_settings`), and all `api_key` entity CRUD — it is the entity's `admin_permission`, so add/edit/delete access resolves through it. |

This is an administrative permission (grants full control over API-key credentials); restrict it to
trusted roles. There are no separate per-operation or per-key permissions. The permission does not
affect who can *authenticate* with a key — that is governed by the user each `api_key` entity is
bound to (see [../api/authentication.md](../api/authentication.md)).
