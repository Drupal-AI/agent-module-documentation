# Permissions

Defined in `search_api_autocomplete.permissions.yml` (plus a dynamic callback).

- `administer search_api_autocomplete` — configure autocomplete settings and enable/edit
  autocomplete searches on every index (the Autocomplete tab and search entity forms).
- Per-search permissions — generated dynamically by `Permissions::bySearch`
  (`permission_callbacks`), one gate per autocomplete-enabled search, controlling whether a
  user's requests to that search's autocomplete endpoint are allowed.
