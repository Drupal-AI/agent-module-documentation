<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import settings — `bibcite_import.settings`

Config object with a nested `settings` mapping:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `settings.contributor_deduplication` | boolean | `true` | Match imported authors/editors to existing `bibcite_contributor` entities instead of creating duplicates. |
| `settings.keyword_deduplication` | boolean | `true` | Match imported keywords to existing `bibcite_keyword` entities instead of duplicating. |

Settings form: `Drupal\bibcite_import\Form\SettingsForm`, route **`bibcite_import.settings`** at
`/admin/config/bibcite/settings/import` (permission `administer bibcite`).

```bash
drush cget bibcite_import.settings
# Turn off contributor deduplication:
drush cset bibcite_import.settings settings.contributor_deduplication 0 -y
```

```php
\Drupal::configFactory()->getEditable('bibcite_import.settings')
  ->set('settings.contributor_deduplication', FALSE)
  ->set('settings.keyword_deduplication', TRUE)
  ->save();

// Read:
\Drupal::config('bibcite_import.settings')->get('settings.contributor_deduplication');
```

With deduplication **on**, importing a file whose references share authors/keywords reuses the
existing Contributor/Keyword entities (cleaner data). With it **off**, each imported record's
authors/keywords become new entities (faster, but produces duplicates).
