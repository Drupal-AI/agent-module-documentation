# Global settings

Form `JsonapiExtrasSettingsForm` at route `jsonapi_extras.settings`
(`/admin/config/services/jsonapi/extras`; permission `administer site configuration`). Config
object `jsonapi_extras.settings`:

| Key | Default | Meaning |
|---|---|---|
| `path_prefix` | `jsonapi` | Base path for the whole API (change to e.g. `api`). Rebuilds routes on save. |
| `include_count` | `false` | Add `meta.count` (total records) to collection responses. |
| `default_disabled` | `false` | When TRUE, every resource without an **enabled** resource config is disabled — a whitelist model for locking down the API. |
| `validate_configuration_integrity` | `true` | On config import, validate that resource-field overrides still match entity fields (`FieldConfigIntegrityValidation`); prevents importing broken overrides. |

Changing `path_prefix` triggers `ConfigSubscriber` to rebuild the router. Per-resource
configuration (renames, disables, enhancers) lives in resource configs —
[resource-overrides.md](resource-overrides.md).
