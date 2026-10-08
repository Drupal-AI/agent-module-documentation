# Enable & configure Token Filter

## Enable per text format
1. Go to `/admin/config/content/formats` and edit a text format (e.g. Full HTML).
2. Check **"Replaces global and entity tokens with their values"** (filter plugin id `token_filter`).
3. Order it sensibly in "Filter processing order" — usually near the end, after HTML filters,
   so tokens are resolved on the final markup. Save.

Now any token typed into a field using that format is expanded when rendered.

## Filter plugin
- Class: `Drupal\token_filter\Plugin\Filter\TokenFilter` (id `token_filter`).
- Replaces global tokens always; entity tokens when the filtered text is a field on a content entity.
- Entity context: `token_filter_preprocess_field()` stashes the rendered `ContentEntityInterface`
  in a static so the filter can pass it to the token service as the matching entity-type context.

## CKEditor 5 token browser
- Provided by `token_filter.ckeditor5.yml` → plugin `Drupal\token_filter\Plugin\CKEditor5Plugin\TokenBrowser`.
- Requires the `token` module (for the token tree UI).
- Add the **Token browser** toolbar item to the editor's toolbar at
  `/admin/config/content/formats` (drag it into the active toolbar). Editors click it to pick
  a token from the standard token tree.

## Config schema
`config/schema/token_filter.schema.yml`. No standalone config object beyond the per-format
filter settings; no permissions of its own.

## Migration
`token_filter_migration_plugins_alter()` maps Drupal 7 `filter_tokens` to `token_filter` in the
`d7_filter_format` migration, so legacy token filters carry over automatically.
