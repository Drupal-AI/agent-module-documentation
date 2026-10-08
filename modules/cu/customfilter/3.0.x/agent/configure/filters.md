<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Custom Filter — filters, rules, subrules

Admin UI at `/admin/config/content/customfilter` (`configure` = `entity.customfilter.list`,
permission `administer customfilter`). Two-level model: a **filter** (config entity) is a
container; **rules** inside it do the actual regex transforms; **subrules** re-process the
captured groups of a parent rule.

## Filter (config entity)

- Type id `customfilter`, `config_prefix: filters` → config object `customfilter.filters.<id>`.
- Fields: `id`, `name` (label), `uuid`, `cache` (bool — per-filter render caching),
  `description`, `shorttip`, `longtip` (filter tips shown to editors), and `rules` (array).
- Add/edit/delete via `/admin/config/content/customfilter/{add,filter/<id>/edit,filter/<id>/delete}`.
- On save, `CustomFilter::postSave()` clears the filter plugin definitions so the new filter
  appears on the text-format configuration pages.
- Each filter surfaces as filter plugin id `customfilter_<id>` on **every** text format
  (`admin/config/content/formats`), off by default — a format admin must enable it there for
  it to run.

## Rule fields (stored in the entity's `rules` array, schema `customfilter.rules`)

Edit rules at `/admin/config/content/customfilter/filter/<id>` → add/edit rule forms.

| Field | Meaning |
|---|---|
| `rid` | machine name of the rule (unique within the filter) |
| `prid` | parent rule id (`''` for a top-level rule; set → this is a subrule) |
| `fid` | owning filter id |
| `name` / `description` | label / notes |
| `enabled` | 1 to apply the rule |
| `matches` | (subrules only) which parent capture group index this subrule reprocesses |
| `pattern` | PCRE regex incl. delimiters, e.g. `/foo.*bar/` |
| `replacement` | replacement text, OR PHP code when `code` = 1 |
| `code` | 0 = literal/backreference replacement; 1 = PHP replacement (see below) |
| `weight` | ordering (rules applied ascending by weight) |

## How a rule is applied (`CustomFilterBaseFilter::process` / `applyRules`)

- Top-level rules run in weight order: `preg_replace_callback($pattern, applyRules, $text)`.
- **`code = 0`, no subrules** → plain `preg_replace($pattern, $replacement)`. Backreferences
  `$1`..`$99` and `${1}`..`${99}` are supported (`$0` = whole match).
- **`code = 1`** → the `replacement` string is executed as **PHP** via `@eval()` inside
  `replaceCallback()`. The code must assign `$result` (its value becomes the replacement);
  the regex captures are available as `$matches[0..n]`; a persistent `$vars` (stdClass, reset
  once per filter run) carries state between rules of the same filter. Do **not** wrap the code
  in `<?php ?>`.
- **Subrules** (`prid` set): after a parent matches, each enabled subrule runs
  `preg_replace_callback` against `$matches[<subrule.matches>]`, i.e. only the chosen capture
  group of the parent, before the parent's own replacement/code produces the final string.

## Example rules

Wrap bare URLs (no code):
```
pattern:     #(https?://[^\s<]+)#
replacement: <a href="$1">$1</a>
code:        0
```

Uppercase every match (PHP code):
```
pattern:     /\bhello\b/i
replacement: $result = strtoupper($matches[0]);
code:        1
```

## Create a filter + rule with Drush

```php
// drush php:eval
$f = \Drupal::entityTypeManager()->getStorage('customfilter')->create([
  'id' => 'links', 'name' => 'Autolink URLs', 'cache' => TRUE,
  'description' => 'Wrap bare URLs', 'shorttip' => '', 'longtip' => '',
]);
$f->addRule([
  'rid' => 'url', 'prid' => '', 'fid' => 'links', 'name' => 'URL', 'description' => '',
  'enabled' => 1, 'matches' => '', 'pattern' => '#(https?://[^\s<]+)#',
  'replacement' => '<a href="$1">$1</a>', 'code' => 0, 'weight' => 0,
])->save();
// Then enable filter plugin "customfilter_links" on a text format.
```

## Migration

`src/Plugin/migrate/source/CustomFilterMigrationSource.php` + `migrations/customfilter_migrate.yml`
provide a source for importing legacy Drupal 6/7 Custom Filter rules; run it through the core
Migrate pipeline.

## Security note

Non-code rules insert `replacement` into content **verbatim** (raw HTML), and `code = 1` rules
run arbitrary PHP. Both are gated by `administer customfilter` — treat that permission as
code-execution / raw-HTML trust. See [../permissions/permissions.md](../permissions/permissions.md).
