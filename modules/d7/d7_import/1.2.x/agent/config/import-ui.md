<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import form (UI)

`src/Form/ImportForm.php` (`FormBase`, id `d7_import_form`). Route `d7_import.form` at
**`/admin/content/d7-import`**, requirement `_permission: 'administer site configuration'`
(`d7_import.routing.yml`). Menu link `d7_import.form` under `system.admin_config_etype`
(`d7_import.links.menu.yml`). There is no settings config object — this is an action form, not a
config form.

## Install / enable

```bash
ddev drush en d7_import -y
```
No install hook, no config to set up. Visit the route as user 1 (or any role with
`administer site configuration`).

## Form fields (`buildForm`)

Seven `#type: file` uploads, one per XML export:

| Form key | Upload | Consumed by |
|----------|--------|-------------|
| `vocabularies_file` | vocabularies.xml (terms carry the vocab) | `VocabularyImporter` |
| `taxonomy_file` | taxonomy.xml | `TermImporter` |
| `content_types_file` | content_types.xml / nodes.xml | `ContentTypeImporter` |
| `files_xml` | files.xml | `FileImporter` |
| `nodes_file` | nodes.xml | `NodeImporter` |
| `aliases_file` | aliases.xml | `AliasImporter` |
| `menus_file` | menus.xml | `MenuImporter` |

Plus:
- `source_files_path` (textfield) — a **local filesystem path** to the D7 files dir (e.g.
  `/var/www/d7site/sites/default/files`). Empty = create managed-file rows without copying bytes.
- `import_options` (checkboxes) — which stages to run: `vocabularies`, `terms`, `types`, `files`,
  `nodes`, `aliases`, `menus`. Only checked stages run.
- `clean_first` (checkbox) — if set, purges existing data for each selected stage **before**
  importing (calls each importer's `purgeAll()`), in reverse-dependency order (menus → aliases →
  nodes → files → terms → vocabularies). Destructive; each purge adds a warning message.

## Submit flow (`submitForm`)

1. `array_filter` the checkboxes; read `clean_first` and `source_files_path`.
2. Load each uploaded file into a `\DOMDocument` via `loadUploadedXml()` — reads
   `getRequest()->files->get('files')[$formField]`, checks `isValid()`, then `$doc->load(realPath)`.
   Returns `NULL` on missing/invalid/parse failure (that stage silently skips).
3. If `clean_first`, purge selected stages (reverse order).
4. Import selected stages **in dependency order**: vocabularies → terms → types → files → nodes →
   aliases → menus. Each importer returns `['imported','skipped','errors', ...]`; counts are shown
   as status messages and any `errors[]` become warning messages.

Import order matters: terms need vocabularies, nodes need content types + files, aliases/menus
reference nodes/terms. The form enforces this order regardless of checkbox order.

## Notes

- The UI runs synchronously in one request (no Batch API). For large sites use the Drush
  commands (`commands/drush.md`), which the README recommends running inside tmux/screen/nohup.
- `loadUploadedXml()` parses the upload with `\DOMDocument::load()` directly (the Drush path adds a
  control-character sanitiser; the form path does not).
