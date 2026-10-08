<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The one hook

The module's entire logic:

```php
/**
 * Implements hook_language_switch_links_alter().
 */
function language_switcher_langcode_language_switch_links_alter(array &$links, string $type, Url $url): void {
  foreach ($links as $langcode => &$link) {
    $link['attributes']['title'] = $link['title'];
    $link['title'] = strtoupper($langcode);
  }
}
```

## Behavior

- Runs on **every** set of language-switch links Drupal builds (the core Language switcher block
  and anything else that calls `\Drupal::languageManager()->getLanguageSwitchLinks()` /
  invokes this alter).
- For each link, keyed by `$langcode`:
  1. The current visible text (`$link['title']`, i.e. the language **name** like "English") is
     copied into `$link['attributes']['title']`, so it renders as the anchor's `title=` tooltip.
  2. `$link['title']` is replaced with `strtoupper($langcode)` — e.g. `en` → `EN`, `pt-br` → `PT-BR`.
- It does not change link URLs, order, the `hreflang`/other attributes, or which languages appear;
  it only rewrites the display text and adds a title tooltip.

## Interaction with other modules

- `$type` and `$url` are received but unused; behavior is identical for all link types.
- If another module also implements `hook_language_switch_links_alter()`, ordering follows the
  normal module weight / `hook_module_implements_alter()` rules. Whichever runs **last** on
  `$link['title']` wins the visible text. If you want the name back, run an alter after this one
  and reset `$link['title']`.

## Reproduce / override without this module

To get the same effect in your own module (or to undo it), implement the same hook:

```php
function MYMODULE_language_switch_links_alter(array &$links, $type, $url): void {
  foreach ($links as $langcode => &$link) {
    // e.g. keep full name, or use a custom label map instead of the langcode.
    $link['title'] = strtoupper($langcode);
  }
}
```

## Verifying on a live site

There is no config to read. Confirm the module is doing its job by rendering the links:

```bash
drush php:eval '
  $links = \Drupal::languageManager()->getLanguageSwitchLinks(
    \Drupal\Core\Language\LanguageInterface::TYPE_INTERFACE,
    \Drupal\Core\Url::fromRoute("<front>")
  );
  foreach ($links->links as $code => $l) { print $code . " => " . $l["title"] . "\n"; }
'
```

With the module enabled the printed titles are uppercased langcodes (EN, FR, …); without it they
are the language names. (Requires at least two configured languages.)
