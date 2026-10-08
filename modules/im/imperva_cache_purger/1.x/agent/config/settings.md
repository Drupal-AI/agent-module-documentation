<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — imperva_cache_purger.settings

Config form: `Drupal\imperva_cache_purger\Form\ImpervaCachePurgerConfigForm`
(`src/Form/ImpervaCachePurgerConfigForm.php`), extending purge_ui's
`PurgerConfigFormBase`. Form id `imperva_cache_purger.config_form`; editable config name
`imperva_cache_purger.settings`. The module ships **no `*.routing.yml` and no
`*.links.menu.yml`** — the form is reached through the Purge admin UI, not its own route:
`/admin/config/development/performance/purge` → expand *Imperva cache Purger* → **Configure**
(a modal/dialog provided by `purge_ui`, gated by Purge's admin access — effectively
*administer site configuration*).

## Config object `imperva_cache_purger.settings`

There is **no `config/install/` default file and no `config/schema/`** in the module — the
object is created on first save of the form. Keys (all read via `$settings->get(...)`):

| Key | Form field | Meaning |
|-----|-----------|---------|
| `disabled` | *Enabled* checkbox (inverted) | When truthy, `invalidate()` marks invalidations SUCCEEDED without calling Imperva. Stored as `empty($form_state->getValue('enabled'))`. |
| `purger_type` | *Cache invalidation type* select | `path_cache_tag` (path + tag), `path`, or `cache_tag`. Controls which DELETE requests fire in `ImpervaCacheInvalidator::invalidate()`. Form default when unset: `path`. |
| `api_id` | *API ID* textfield | Imperva API ID; sent as the `x-api-id` request header. |
| `api_key` | *API key* textfield | Imperva API key; sent as the `x-api-key` request header. |
| `site_id` | *Site id* textfield | Numeric Imperva site id (e.g. `69763071`), used to build the endpoint path `.../sites/{site_id}/cache`. |
| `api_endpoint` | *API endpoint* textfield | Optional override of the base endpoint; default `ImpervaCacheInvalidator::IMPERVA_API_ENDPOINT` = `https://my.imperva.com/api/prov/v2/sites/`. Used to target a different API version. |

`buildForm()` pre-fills each field from the current config; `submitFormSuccess()` writes all
six keys back and calls `$settings->save()`.

## Notes

- `purger_type` gates behaviour: with `path` only path/wildcard invalidations are sent to
  Imperva; with `cache_tag` only tag invalidations; with `path_cache_tag` both. The README
  recommends *by cache tag* because Drupal emits cache tags natively.
- `disabled` is a no-op switch for environments (e.g. staging) that should swallow
  invalidations without hitting the real CDN.
- Because there is no config schema, the object is a plain untyped config; keys are exported
  by `drush cex` / config sync as written.
