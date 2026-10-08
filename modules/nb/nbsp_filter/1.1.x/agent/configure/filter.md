<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the NBSP Filter

The module ships one filter plugin. There is no dedicated settings page — you enable and
configure it per text format like any core filter.

- Plugin: `Drupal\nbsp_filter\Plugin\Filter\NbspFilter`, id `nbsp_filter`.
- Type: `FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE` (transforms the text; not reversible).
- UI: `/admin/config/content/formats` → pick a format → enable **NBSP Filter**, expand its
  settings, save. (`configure` route in info.yml is `filter.admin_overview`, the format list.)

## Settings

Config object `filter.format.<format_id>`, key `filters.nbsp_filter.settings`.
Schema type `filter_settings.nbsp_filter` (config/schema/nbsp_filter.schema.yml).

| Key | Type | Default | Effect (from `NbspFilter::process()`) |
| --- | --- | --- | --- |
| `clean_all` | boolean | `TRUE` | First pass: replace every existing non-breaking space with a normal space — the literal `&nbsp;` entity, the UTF-8 nbsp `\xc2\xa0`, and (via `preg_replace('/[\x{00A0}\x{202F}\x{2009}\x{200A}\x{200B}]/u', ' ', ...)`) U+00A0, U+202F narrow nbsp, U+2009 thin space, U+200A hair space, U+200B zero-width space. |
| `insert_before` | string | `?!;:` | Regex `/ ([chars])/i`: a normal ASCII space immediately **before** any listed character becomes `&nbsp;` + that character. |
| `insert_after` | string | `¿¡` | Regex `/([chars]) /i`: a normal ASCII space immediately **after** any listed character becomes that character + `&nbsp;`. |
| `insert_narrow_before` | string | `»` | Regex `/\s(?=[chars])/`: any whitespace **before** a listed character becomes a narrow no-break space U+202F (`&#8239;`, bytes `\xe2\x80\xaf`). |
| `insert_narrow_after` | string | `«` | Regex `/(?<=[chars])\s/`: any whitespace **after** a listed character becomes U+202F. |

An empty string in any `insert_*` key skips that pass. `clean_all` runs first, so the insert
passes act on already-normalised text.

Notes on the patterns:
- Each string is dropped verbatim into a regex character class (`[$chars]`). List plain
  characters only; a regex metacharacter (`]`, `\`, `-`, `^`) would change the class or break
  the pattern. A broken pattern makes `preg_replace` return NULL and blanks the field, so keep
  entries literal.
- `insert_before`/`insert_after` match only a literal ASCII space and are case-insensitive
  (`i`); the narrow-space passes match any whitespace (`\s`).
- The default punctuation set targets French/Spanish typography: nbsp before `? ! ; :`,
  nbsp after inverted `¿ ¡`, narrow nbsp inside the guillemets `» «`.

## Set it programmatically

```php
use Drupal\filter\Entity\FilterFormat;

$format = FilterFormat::load('basic_html');
$format->setFilterConfig('nbsp_filter', [
  'status' => TRUE,
  'weight' => 20,
  'settings' => [
    'clean_all' => TRUE,
    'insert_before' => '?!;:',
    'insert_after' => '¿¡',
    'insert_narrow_before' => '»',
    'insert_narrow_after' => '«',
  ],
]);
$format->save();
```

Run it with `ddev drush php:eval '...'`, or export/import `filter.format.<id>.yml` via config
management (the `filters.nbsp_filter` block).

## Filter order

The filter's `weight` (its position in the format's filter list) decides when it runs relative
to other filters. It only substitutes spaces with `&nbsp;` entities / narrow-nbsp bytes and
normalises existing non-breaking spaces to plain spaces — it emits no tags — so order affects
*results*, not markup safety: place it after tag-restricting and line-break filters so its
inserted entities survive in the final output. If a "convert URLs" or similar filter runs after
it, an inserted `&nbsp;` inside a URL-like run could shift matching, so put NBSP Filter late.
