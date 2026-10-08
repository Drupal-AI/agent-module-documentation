# Preprocess hooks & class derivation

All behavior lives in `menu_css_names.module`. There are no services, controllers or plugins — the
module only preprocesses render variables.

## The three preprocess hooks

- `menu_css_names_preprocess_menu(&$variables)` — always runs. Passes `$variables['items']` through
  `menu_css_names__build_menu_classes()`, which walks the menu tree and sets, on every item,
  `$item['attributes']['class'] = menu_css_names__make_class_name($item['title'])`. It recurses into
  `$item['below']` so nested/child items are classed too. Note it **assigns** a single string to
  `attributes.class` for each item (it does not append to an existing class list).
- `menu_css_names_preprocess_menu_local_task(&$variables)` — runs only if
  `menu_css_names.settings:tasks` is truthy. Appends
  `menu_css_names__make_class_name($variables['element']['#link']['title'])` to
  `$variables['attributes']['class'][]`.
- `menu_css_names_preprocess_menu_local_action(&$variables)` — runs only if
  `menu_css_names.settings:local_actions` is truthy. Same as local task but for action buttons.

`hook_help()` (`help.page.menu_css_names`) returns the About text on the module's help page.

## `menu_css_names__make_class_name($text)` — the algorithm

Given the link title, in order:

1. `\Drupal::transliteration()->transliterate($text, 'en')` — non-ASCII characters are transliterated
   to ASCII (e.g. accented letters lose their accents).
2. `strip_tags(trim($text))` — remove any HTML tags and surrounding whitespace.
3. `preg_replace('/(\s?&amp;\s?|[^-_\w\d])/i', '-', …)` — collapse an optional-space-wrapped `&amp;`
   and **every character that is not `A-Z a-z 0-9 _ -`** to a single hyphen.
4. `mb_strtolower(…)` — lowercase.
5. `preg_replace('/(^-+|-+$)/', '', …)` — trim leading/trailing hyphens.
6. `preg_replace('/--+/', '-', …)` — collapse runs of hyphens to one.

The returned string therefore contains only `[a-z0-9_-]`. Examples: `"Product Information"` →
`product-information`; `"Blog & News"` → `blog-news`; `"Über Us!"` → `uber-us`. Two different titles
can collapse to the same class (e.g. `"A / B"` and `"A - B"` both → `a-b`); the class is derived from
the current title, so it changes if an editor renames the link — keep that in mind when your CSS
depends on a specific class.

## Overriding / altering

There is no alter hook. To change the output, implement your own `hook_preprocess_menu` /
`hook_preprocess_menu_local_task` / `hook_preprocess_menu_local_action` that runs after this module
(later module weight or a theme preprocess) and rewrite `attributes.class`, or re-implement the
transformation with your own helper.
