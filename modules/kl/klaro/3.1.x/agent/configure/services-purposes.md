# Services & Purposes (consent entities)

Consent is modeled as two config-entity types (both `admin_permission: administer klaro`).

## Purposes — `klaro_purpose`
A consent category (analytics, advertising, external content, security, …). Manage at
`/admin/config/user-interface/klaro/purposes` (collection route
`entity.klaro_purpose.collection`; add/edit/delete forms provided). Services are grouped
under purposes in the banner so a visitor can accept a whole category at once.

## Services — `klaro_app`
A single third-party script/integration. Manage at
`/admin/config/user-interface/klaro/services` (`entity.klaro_app.collection`). Key exported
properties (entity_keys / `config_export`, see `src/Entity/KlaroApp.php` and
`config/schema/klaro.schema.yml`):

| Key | Meaning |
|---|---|
| `id`, `label`, `description` | machine name + banner label/description |
| `purposes` | which purpose(s) this service belongs to |
| `default` | toggled on by default in the banner |
| `required` | cannot be declined (essential services) |
| `opt_out` | loads unless the user opts out |
| `only_once` | consent asked only once |
| `contextual_consent_only` | only shown as a per-embed (contextual) prompt |
| `contextual_consent_text` | text for the click-to-load placeholder |
| `info_url` | privacy-policy / more-info link |
| `cookies` | cookie name patterns (regex) this service sets, for cleanup |

## Define one in config
Create `klaro.klaro_app.myservice.yml` (mirror a bundled `config/install/klaro.klaro_app.*.yml`),
assign it to a `purposes` value, and list the JS library or script identifiers it controls;
matching assets are then held back until the service is consented. Import with
`drush config:import`. What a service actually gates is enforced by the JS/library rewriting
described in [../api/decorate-external.md](../api/decorate-external.md).
