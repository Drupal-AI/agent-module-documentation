# scanner — configure

**Settings form:** `/admin/config/content/scanner` — route `scanner.admin_config`
(info.yml `configure:` points here), form `\Drupal\scanner\Form\ScannerAdminForm`, gated by
permission `administer scanner settings`. **The search/replace tool itself** is a separate
route: `scanner.admin_content` at `/admin/content/scanner`.

**Config object:** `scanner.admin_settings` (schema `config/schema/scanner.schema.yml`). Read
with `\Drupal::config('scanner.admin_settings')`; the settings page and the search form both
read it. Install defaults are shown below.

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `scanner_mode` | bool | `true` | Default **case-sensitive** search on the tool form |
| `scanner_wholeword` | bool | `true` | Default **match whole word** |
| `scanner_regex` | bool | `false` | Default: treat the search term as a **regular expression** |
| `scanner_published` | bool | `false` | Default: search **published nodes only** |
| `scanner_pathauto` | bool | `false` | Default: maintain custom aliases (pathauto integration) |
| `scanner_language` | string | `all` | Default content language (`all` or a langcode) |
| `word_boundaries` | string | `auto` | Regex word-boundary mode: `auto`, `spencer` (`[[:<:]]`/`[[:>:]]`, MariaDB + MySQL ≤8.0.3), or `icu` (`\b`, MySQL ≥8.0.4) |
| `enabled_content_types` | sequence | `{}` | Which entity type + bundle are scannable; keys/values like `node:article` |
| `fields_of_selected_content_type` | sequence | `{}` | Which **fields** are scannable; keys/values like `node:article:body` |

**Enabling a field for scanning** (required before the search tool will scan it — the tool
iterates `fields_of_selected_content_type`): tick the entity type/bundle under *Content types
to be searched*, then tick its field(s). Stored as `array_filter`ed checkbox arrays, so the
value equals the key. Only **text**, **string**, and **link** field types are offered.

Set it from Drush/PHP without the UI:

```php
\Drupal::configFactory()->getEditable('scanner.admin_settings')
  ->set('enabled_content_types', ['node:article' => 'node:article'])
  ->set('fields_of_selected_content_type', ['node:article:body' => 'node:article:body'])
  ->save();
```

Field-name format everywhere in this module is `entity_type:bundle:field_name`
(e.g. `node:article:body`); `enabled_content_types` keys drop the field: `entity_type:bundle`.
