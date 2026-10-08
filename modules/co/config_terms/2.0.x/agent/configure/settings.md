# Settings (`config_terms.settings`)

There is **no settings form / configure route** (`configure` is null). The module ships one simple
config object, edited only through configuration import/export, `drush`, or PHP.

Config object: `config_terms.settings` (schema type `config_object`). Install defaults
(`config/install/config_terms.settings.yml`):

| Key | Type | Default | Effect |
|---|---|---|---|
| `maintain_index_table` | boolean | `true` | Declared in schema/install but **not read anywhere** in 2.0.0 source — no runtime effect. |
| `override_selector` | boolean | `false` | When `true`, `TermForm` skips building the parent-terms `<select>` (whole-vocab load), letting contrib provide a scalable parent widget via `hook_form_alter`. |
| `terms_per_page_admin` | integer | `100` | Terms per page on the vocab overview (`Form\OverviewTerms`). |

## Set via drush

```bash
drush config:set config_terms.settings terms_per_page_admin 50
drush config:set config_terms.settings override_selector true
```

## Set via PHP

```php
\Drupal::configFactory()->getEditable('config_terms.settings')
  ->set('terms_per_page_admin', 50)
  ->set('override_selector', TRUE)
  ->save();
```

Read at runtime with `\Drupal::config('config_terms.settings')->get('terms_per_page_admin')`.
