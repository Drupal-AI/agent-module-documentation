<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatter: download count on a file field

`Drupal\download_count\Plugin\Field\FieldFormatter\FieldDownloadCount` extends core
`GenericFileFormatter`.

```php
/**
 * @FieldFormatter(
 *   id = "FieldDownloadCount",
 *   label = @Translation("Generic file with download count"),
 *   field_types = {"file"}
 * )
 */
```

- **Applies to** any `file` field. Select it as the display formatter for the field on the
  entity's "Manage display" tab (or set `type: FieldDownloadCount` in the view-mode config).
- **Behavior** (`viewElements()`): for each file it renders the normal file link, and — only if
  the current user has `view download counts` — runs a parameterized query
  `SELECT COUNT(fid) FROM {download_count} WHERE fid = :fid AND type = :type AND id = :id`
  and appends "Downloaded N times" / "Downloaded 1 time" / "Never downloaded".
- Without `view download counts` it falls back to core's `file_link` theme (no count shown).
- With the count it uses the `download_count_file_field_formatter` theme
  (`hook_theme()` in `download_count.module`), template
  `templates/download-count-file-field-formatter.html.twig`
  (variables: `file`, `url`, `classes`, `count`).
- Cache tags: the file entity's own cache tags (`$file->getCacheTags()`).

The count shown here is a live `COUNT()` over the raw `download_count` table for that exact
file + host entity — it does not depend on the cron cache. Mime-icon classes are added the same
way core does.
