# QueryHelper service (API)

Service `l10n_tools.query_helper` → `Drupal\l10n_tools\QueryHelper` (`src/QueryHelper.php`, no
constructor arguments; it pulls `\Drupal::database()`, `\Drupal::state()`, `\Drupal::logger()`
statically). This is the whole business layer — both the admin form and the Drush commands call it.
Every method wraps its work in try/catch; on any `\Exception` it logs to channel `l10n_tools` and
returns `FALSE`.

> **MySQL/MariaDB only.** Several methods use `CONVERT(… USING utf8)` and multi-table
> `DELETE ls FROM …` syntax that is not portable; on PostgreSQL/SQLite they throw, get logged, and
> return `FALSE`.

```php
$helper = \Drupal::service('l10n_tools.query_helper');
// or, as the Drush commands do it, directly: $helper = new QueryHelper();
```

## Methods

| Method | Tables | Returns |
|---|---|---|
| `getEqualTranslations($filterCustomized = NULL)` | `locales_source` ⋈ `locales_target` | array of stdClass `{lid, source, context, translation}`, or `FALSE` |
| `deleteEqualTranslations($filterCustomized = NULL)` | `locales_target` | int rows deleted, or `FALSE` |
| `getOrphanTranslations()` | `locales_source` ⟕ `locales_target` | array of stdClass `{lid, source, context}`, or `FALSE` |
| `deleteOrphanTranslations()` | `locales_source` | int rows deleted, or `FALSE` |
| `deleteCurrentTranslationStatus()` | `key_value` (collection `locale.translation_status`) | int rows deleted, or `FALSE` |
| `resetDateTimestamp()` | `locale_file` + state | `void`, or `FALSE` on exception |
| `resetTranslationStatus()` | calls the two above | int (from `deleteCurrentTranslationStatus`), or `FALSE` |

### `getEqualTranslations($filterCustomized = NULL)` / `deleteEqualTranslations(...)`
`$filterCustomized`: `NULL` = do not filter, `0` = only non-customized (imported), `1` = only
customized. `getEqualTranslations()` **validates** the argument
(`in_array($filterCustomized, [NULL, 0, 1])`) and throws `InvalidParameterException` otherwise;
`deleteEqualTranslations()` does **not** validate but binds the value as the parameter
`:onlyCustomized`, so it cannot be used for SQL injection. The match test is
`CONVERT(ls.source USING utf8) = CONVERT(lt.translation USING utf8)` over an inner join on `lid`;
when a filter is given, `AND lt.customized = :onlyCustomized`. The delete removes the `locales_target`
rows whose `lid` is in that set (source rows are untouched).

### `getOrphanTranslations()` / `deleteOrphanTranslations()`
Selects `locales_source` rows with a `leftJoin` to `locales_target` where `lt.lid IS NULL` — source
strings with no translation. `deleteOrphanTranslations()` runs the raw query
`DELETE ls FROM {locales_source} ls LEFT JOIN {locales_target} lt ON ls.lid=lt.lid WHERE lt.lid IS NULL`
(sets `allowRowCount`, reads `rowCount()`, then `execute()`), removing those `locales_source` rows.

### `resetTranslationStatus()` (and its parts)
`deleteCurrentTranslationStatus()` deletes `key_value` rows where `collection = 'locale.translation_status'`.
`resetDateTimestamp()` updates `locale_file` setting `timestamp = 0` and `last_checked = 0` for all
rows, then sets state `locale.translation_last_checked` to `0`. `resetTranslationStatus()` calls both
and returns the delete count. Net effect: core forgets what translation updates it has checked and
will re-query localize.drupal.org on the next check (`locale.translate_status`).

No inputs to any method come from the request except `filterCustomized` (a bound integer). None of
these methods fetch anything over the network; the "refresh from localize.drupal.org" happens later
through core's own translation-update flow once the status is reset.
