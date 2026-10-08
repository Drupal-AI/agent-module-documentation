<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Install / enable

`drush en cache_tags_cdn_optimizer -y`. No dependencies beyond core (`^10 || ^11 || ^12`).
Nothing happens until you enable at least one replacement toggle and select fields — with all
toggles off the module is inert (the subscriber returns early, the hooks do nothing).

## Route & access

- Route `cache_tags_cdn_optimizer.settings` → `/admin/config/services/cache-tags-cdn-optimizer`,
  `_form: SettingsForm`, requirement `_permission: 'administer site configuration'`
  (`cache_tags_cdn_optimizer.routing.yml`). Menu link under *system.admin_config_services*
  (`.links.menu.yml`, weight 100). This is the module's ONLY route; there is no inbound purge or
  callback endpoint.
- Form id: `dseven_conditional_cachetags_settings_form` (`SettingsForm::getFormId`), extends
  `ConfigFormBase`; editable config = `cache_tags_cdn_optimizer.settings`.

## Config object `cache_tags_cdn_optimizer.settings`

Schema: `config/schema/cache_tags_cdn_optimizer.schema.yml`. Keys:

| Key | Type | Default | Effect |
|-----|------|---------|--------|
| `path_cache_tag` | bool | false | Adds a `url…` path tag to responses (helps purge cached 404s) and invalidates it on `path_alias` insert / entity update. |
| `replace_cache_tags_node` | bool | false | Enables `node:123` → `node:reference:123` rewriting + node invalidation hooks. |
| `replace_cache_tags_taxonomy_term` | bool | false | Same for `taxonomy_term`. |
| `blocklist` | sequence(string) | [] | Cache tags to strip from the response. Exact match, or trailing `*` for prefix match. |
| `entity_fields` | mapping | {} | Per bundle: which fields trigger invalidation. Shape `entity_fields.<node|taxonomy_term>.<bundle> = [field, …]`. |
| `debug_mode` | bool | false | Logs the old→new field comparison to the `cache_tags_cdn_optimizer` logger channel on entity update. |

Note: the shipped schema names the sub-mappings `nodes` / `taxonomy_term`, but the form and hooks
actually read/write `entity_fields.node.<bundle>` and `entity_fields.taxonomy_term.<voc>`
(`SettingsForm::submitForm`, `hook_entity_update`). Field defaults in the form fall back to
`['title','status']` for nodes and `['name','status']` for terms when a bundle is unconfigured.

## Settings form fields (`SettingsForm::buildForm`)

- **Cache Tag Invalidation** (details): a textfield + AJAX button. `invalidateCacheTagAjax` reads
  the entered value, splits on spaces, and runs `Cache::invalidateTags()` on the list — an admin
  convenience for manual purges, no config saved.
- **Add path cache tag** → `path_cache_tag`.
- **Enable cache tag replacement for nodes / taxonomy terms** → the two `replace_*` booleans.
- **Fields per content and taxonomy types** (details): checkbox lists built from
  `entity_field.manager` field definitions per node bundle and taxonomy vocabulary; saved under
  `entity_fields`. At least one field must be selected per type or that entity is never purged.
- **Blocklist** (textarea, one tag per line) → `blocklist`.
- **Enable debug mode logging** → `debug_mode`.

`submitForm` trims/filters the blocklist lines and `array_filter()`s the field checkboxes before
saving. There is no `validateForm` (commented out).
