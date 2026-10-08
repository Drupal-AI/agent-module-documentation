# Permissions

Defined in `search_api_autocomplete.permissions.yml` (plus a dynamic callback).

- `administer search_api_autocomplete` — configure autocomplete settings and enable/edit
  autocomplete searches on every index (the Autocomplete tab and search entity forms).
- Per-search permissions — generated dynamically by `Permissions::bySearch`
  (`permission_callbacks`), one gate per autocomplete-enabled search
  (`use search_api_autocomplete for {search_id}`), controlling whether a user's requests to
  that search's autocomplete endpoint are allowed.

The endpoint access check (`AutocompleteHelper::access`) requires the per-search permission
OR `administer search_api_autocomplete`, plus the search being enabled with a valid, enabled
index. The Live results suggester additionally access-checks each result item
(`$item->getAccessResult()->isAllowed()`), so users never see suggestions for items they
cannot view.
