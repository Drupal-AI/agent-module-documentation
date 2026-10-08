# Permissions

Defined in `pluginreference.permissions.yml`.

| Permission | Title | Notes |
|---|---|---|
| `pluginreference autocomplete view results` | Access to Plugin Reference Autocomplete Results | `restrict access: true`. Required to reach the autocomplete route `pluginreference.plugin_autocomplete`, which enumerates the plugins available for a `target_type`. Grant only to roles that edit `plugin_reference` fields via the autocomplete widget. |

The autocomplete endpoint also verifies an HMAC of the selection settings before returning
results, so the permission is the primary access gate for browsing plugin lists.
