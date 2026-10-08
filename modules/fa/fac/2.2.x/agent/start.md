# Fast Autocomplete (fac) — agent index

Serves IMDB-like typeahead suggestions to text inputs from pre-generated JSON files in
`public://fac-json/…`, backed by a pluggable search service. Config UI at
`/admin/config/search/fac` (`configure` = `entity.fac_config.collection`). One permission
(`administer fac settings`). Depends only on core; Search API is optional (used by one plugin).

- **Create/tune a Fast Autocomplete configuration (`fac_config` entity), every setting key, the
  two built-in search plugins, and the general settings** → [configure/config.md](configure/config.md)
- **Add your own search backend via the `fac_search` plugin type** → [plugins/search.md](plugins/search.md)
- **Alter hooks (`hook_fac_empty_result_alter`, `hook_fac_search_plugin_info_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)
- **Drush `fac:cache-clear` to purge cached JSON files** → [drush/drush.md](drush/drush.md)

Key facts:
- Runtime route `fac.json` (`FacController::generateJson`, permission `access content`) generates and
  caches the JSON on a miss; on a hit the webserver serves the static file directly.
- Security model: search runs **as anonymous by default** (`anonymousSearch`, on) so public cache never
  leaks restricted content; the file path embeds a rotating role-based HMAC (`HashService`, `fac_key` in
  state, rotated on `key_interval`, default 604800s). Requests fail **closed** — an invalid hash,
  disabled config, bad langcode, or over-length key yields a 404.
- `emptyResult` is raw HTML entered by an admin (`administer fac settings`) and printed into the
  suggestions box / `drupalSettings`; treat it as trusted-admin markup (the usual admin XSS
  responsibility — do not populate it from untrusted sources).
- No global config entity ships in `config/install`; only `fac.settings` (`key_interval`,
  `highlighting_script_use_cdn`). You add `fac_config` entities yourself.
