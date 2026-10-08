<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, username override, Views & Feeds

## Config object `displayname.settings`

Shipped defaults (`config/install/displayname.settings.yml`): `component_required_marker: '*'`,
`user_display_name: ''`. Schema (`config/schema/displayname.schema.yml`) also allows `sep1`/`sep2`/`sep3` separators.
`user_display_name` holds the machine name of the `display_name` field on `user`/`user` that should replace the
rendered username; empty means no override.

This key is managed automatically:
- `displayname_field_config_create()` sets it to a newly created user `name`-type field when it is still empty.
- `displayname_field_config_delete()` clears it when that field is deleted.
- `DisplayNameItem::validateUserDisplayName()` (field-settings form) writes it when an admin toggles the override,
  and invalidates all `user:<uid>` cache tags.

## Rendered-username override

When `user_display_name` names a real field, the module rewrites Drupal's formatted username:
- `hook_user_load()` (`displayname_user_load()`) parses each user's stored components into a name via
  `displayname.format_parser` and caches it on `$account->realname` (static cache `displayname_user_realname_cache`).
- `hook_user_format_name_alter()` (`displayname_user_format_name_alter()`) replaces `$name` with `$account->realname`
  for non-anonymous accounts, preloading the field if needed (`..._preload()` guards against recursion).
- `displayname_user_save()` clears the cached name on save.

So author links, comments, and `$account->getDisplayName()` output the formatted name site-wide once the override is
set. Removing the override is just clearing `user_display_name`.

## Permission

`displayname.permissions.yml` defines `change own display name` (title "Change own display name"). Use it to gate a
custom edit path; the module does not itself attach it to a route.

## Format config entities

`config/schema/displayname.schema.yml` defines `display_name.display_name_format.*` (id, label, locked, status,
`pattern`) and `display_name.display_name_list_format.*` (delimiter, `and`, `delimiter_precedes_last`, `el_al_min`,
`el_al_first`). In this alpha the formatter resolves format strings from the hardcoded maps in
`displayname_get_format_by_machine_name()` / `displayname_get_custom_format_options()` rather than from stored
entities, so these schemas are forward-looking. Schemas for sample-data generation
(`display_name.generate.*`) also exist but the generator class is not shipped in this release.

## Views fulltext filter `display_name_fulltext`

`src/Plugin/views/filter/Fulltext.php`. Operators: `contains`, `word` (any word), `allwords` (all words). `query()`
builds `LOWER(CONCAT(' ', COALESCE(<field>_title,''), ' ', ... , <field>_alias, ''))` from the field's own column
aliases (not user input) and matches with `LIKE` using bound placeholders; the "word" operators additionally call
`Connection::escapeLike()` on each word. Add it to a View filtering an entity that has a `display_name` field to
search across all name parts at once.

## Feeds target `display_name`

`src/Feeds/Target/DisplayNameTarget.php` (`@FeedsTarget id = "display_name"`). Maps import source columns onto the
individual name components so display names can be imported from CSV/RSS/etc. via the Feeds module. Feeds is an
optional integration, not a hard dependency.

## Autocomplete route

`displayname.autocomplete` (`displayname.routing.yml`) → `DisplayNameAutocompleteController::autocomplete()`,
requirement `_permission: 'access content'`. The controller additionally verifies the named field exists, is of type
`display_name`, and that the caller passes the field's `fieldAccess('edit', ...)` check before returning matches; the
suggestions come from the field's configured option sources via `DisplayNameOptionsProvider`.
