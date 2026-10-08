# Module settings (`elf.settings`)

Form `Drupal\elf\Form\SettingsForm` (`ConfigFormBase`), route `elf.admin_settings` at
`/admin/config/content/elf`, permission `administer site configuration`. Edits the
`elf.settings` config object. These are site-wide and combine with the per-format
`filter_elf` settings ([filter.md](filter.md)).

| Config key | Type | Default | Meaning |
|---|---|---|---|
| `elf_domains` | sequence of strings | `[]` | Extra domains treated as **internal** (not flagged). One per line in the form; must include the protocol (`http://example.com`); `*` is a wildcard. |
| `elf_icon_class` | string | `elf-icon` | CSS class added alongside `elf-external`/`elf-mailto` so the theme/`elf_css` library can style an icon. |
| `elf_window` | boolean | `false` | Add `target="_blank"` to external links. |
| `elf_accessible` | boolean | `false` | Append a `screen-reader-only` span labeling the link as external. |
| `elf_redirect` | boolean | `false` | Route external links' `href` through `/elf/redirect` (see [../api/redirect.md](../api/redirect.md)). |

## Validation / normalization (on save)
- `elf_domains`: split on whitespace; each entry is trimmed of surrounding `/`; every non-empty
  entry must satisfy `UrlHelper::isExternal()` or the form errors ("not a valid external
  domain"); the saved list is de-duplicated.
- `elf_icon_class`: passed through `Html::cleanCssIdentifier()` before saving.

## Set without the UI
Drush:
```bash
drush config:set elf.settings elf_window true -y
drush config:set elf.settings elf_icon_class my-external-icon -y
drush config:set elf.settings elf_redirect true -y
```
PHP (e.g. for `elf_domains`, which is a sequence):
```php
\Drupal::configFactory()->getEditable('elf.settings')
  ->set('elf_domains', ['http://example.com', 'https://*.example.org'])
  ->set('elf_accessible', TRUE)
  ->save();
```

Install defaults ship in `config/install/elf.settings.yml`. Update hooks `elf_update_8001`
(adds `elf_icon_class`) and `elf_update_8002` (adds `elf_accessible`) backfill these keys on
existing sites.
