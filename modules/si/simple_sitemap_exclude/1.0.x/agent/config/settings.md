<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — exclude patterns

## Where
- **UI:** `/admin/config/search/simplesitemap/exclude` (local task "Exclusions", under the Simple
  Sitemap settings, parent `simple_sitemap.inclusion`).
- **Permission:** `administer sitemap settings` (provided by `simple_sitemap`; this module adds no
  permission of its own).
- **Config object:** `simple_sitemap_exclude.settings`, key `patterns` — a sequence of strings.
  Default is empty.

## The form (`SettingsForm`)
Extends `\Drupal\simple_sitemap\Form\SimpleSitemapFormBase` (so it inherits Simple Sitemap's form
chrome). It renders:
- `patterns` — a `textarea`. On load, the stored array is joined with `"\n"` for display. On save,
  the value is `explode("\n", …)`, each line `trim()`med, empties filtered out, and the resulting
  array saved to `simple_sitemap_exclude.settings:patterns`.
- The Simple Sitemap **"regenerate now"** block (`$this->formHelper->regenerateNowForm($form)`),
  letting you rebuild the sitemap without leaving the page.

## Pattern semantics
Each line is the **body** of a PHP `preg_match()` regular expression. At sitemap generation the
module runs, for each pattern and each pending link:

```php
$path = str_replace($host, '', $link['url']);      // URL minus scheme+host, e.g. "/node/12"
if (preg_match('/' . $pattern . '/', $path)) {
  unset($links[$key]);                              // drop this link from the sitemap
}
```

Consequences:
- **Delimiters:** the pattern is wrapped in `/ /`. Do not add your own delimiters. A literal `/` in
  the path is matched by `\/` (as the module's examples show) or just `/` — either works since the
  delimiter is fixed by the module.
- **Unanchored by default:** without `^`/`$` the regex matches anywhere in the path. Anchor to be
  precise.
- **Match target is the path**, not the full URL — write `^\/node\/.*`, not `https://…/node/…`.
- **Case-sensitive** (no `i` modifier is added).

### Examples
| Goal | Pattern |
|------|---------|
| Exact `/home` only | `^\/home$` |
| All node canonical paths | `^\/node\/.*` |
| Anything under `/staging/` | `\/staging\/` |
| A single alias `/thank-you` | `^\/thank-you$` |
| Any path containing `page=` | `page=` |

## Applying changes
Editing patterns changes future generation only. Trigger a rebuild via the form's "regenerate now",
`drush simple-sitemap:generate`, or the configured cron run. Always re-open the generated sitemap
and confirm the intended (and only the intended) URLs disappeared — an over-broad pattern removes a
whole section silently.

## Drush / config export
There are no Drush commands or extra plugin types. To manage patterns in code, edit the
`simple_sitemap_exclude.settings` config (`patterns` sequence) and export/import via configuration
management as usual.
