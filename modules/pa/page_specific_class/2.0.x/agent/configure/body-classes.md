<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-page body classes

## The one setting: `page_specific_class.settings` → `url_with_class`

A single multi-line **string**. Each line maps a path to one or more classes:

```
/<path>|<class>
/<path>|<class1 class2 class3>
```

Rules (enforced/handled by the module):
- Each line: path, then `|`, then space-separated class(es).
- The path **must start with `/`** (the settings form validates this).
- Multiple classes → separate with spaces (all added to the body).
- One mapping per line (lines split on `PHP_EOL`).
- Classes are sanitised with `Html::cleanCssIdentifier()` before being added.

### Special targets

| Line | Effect |
|---|---|
| `/node/1\|special` | adds `special` on `/node/1` (alias-aware) |
| `/pricing\|a b c` | adds `a`, `b`, `c` on `/pricing` |
| `/<front>\|home-page` | adds `home-page` on the front page |
| `/*\|all-page` | adds `all-page` on **every** page |
| `/content/article*\|article-theme` | wildcard: adds `article-theme` on any path starting `/content/article` |

Matching resolves both the entered path and the current path through the path-alias manager,
so entering an alias works. Wildcards match when the current alias path *starts with* the prefix
before `*`.

## Admin form

Route `page_specific_class.settings` → `/admin/config/page-class/settings` (menu:
*Configuration → User interface → Page Specific Class*). Permission:
`administer site configuration`. The form is a single textarea bound to `url_with_class`.

## Set it with drush

```bash
# read current mappings
drush cget page_specific_class.settings url_with_class

# set mappings (newlines separate rules)
drush cset page_specific_class.settings url_with_class "/node/1|special-offer
/pricing|pricing dark
/*|has-js" -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('page_specific_class.settings')
  ->set('url_with_class', "/node/1|special-offer\n/*|has-js")
  ->save();
```

## Verify the effect

Visit a mapped page and inspect the `<body class="…">` — the configured class(es) appear
(alongside core's own body classes). There is no separate enable step; the
`hook_preprocess_html()` runs whenever `url_with_class` is non-empty.

## Config schema

`config/schema/page_specific_class.schema.yml` types `page_specific_class.settings` as a
`config_object` with a single string `url_with_class`.
