<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — Language Switcher Extended

The module has no plugin types and no Drush. Its whole public surface is one hook
implementation delegating to one service.

## The alter hook

`language_switcher_extended.module` implements core's
`hook_language_switch_links_alter(array &$links, $type, Url $url)` and simply forwards the
links to the service:

```php
function language_switcher_extended_language_switch_links_alter(array &$links, $type, Url $url) {
  \Drupal::service('language_switcher_extended.link_processor')->process($links);
}
```

So any language switcher block core builds is post-processed by this module. If you build a
switcher yourself and invoke the alter hook (e.g. via `language_manager()->getLanguageSwitchLinks()`),
this processing applies too.

## The service

- Service id: `language_switcher_extended.link_processor`
- Class: `Drupal\language_switcher_extended\LanguageSwitcherLinkProcessor`
- Constructor args: `@config.factory`, `@current_route_match`, `@language_manager`
- Public method: `process(array &$links): void`

`$links` is core's language-switch links array keyed by langcode; each item has `url`
(a `\Drupal\Core\Url`), `title`, and `attributes`. `process()` reads
`language_switcher_extended.settings` and mutates `$links` in place:

- **mode `always_link_to_front`** → sets every item's `url` to that language's `<front>`.
- **mode `process_untranslated`** → finds the current content entity (first
  `ContentEntityInterface` in the route parameters) and, for each langcode the entity is
  **not** translated into, applies `untranslated_handler`: `hide_link` unsets the item,
  `link_to_front` sets `url` to `new Url('<front>')`, `no_link` sets `url` to
  `new Url('<nolink>')` and adds class `language-link--untranslated`. If `hide_single_link`
  is set and `count($links) < 2`, links become `[]` (or `NULL` when `hide_single_link_block`).
- **`translation_detection`** decides "not translated": `default` = no translation OR user
  lacks view access; `is_published` = no translation OR the translation is unpublished
  (`EntityPublishedInterface`).
- After the mode switch (when mode ≠ `default`), **`current_language_mode`** removes
  (`hide_link`) or de-links (`no_link`, adds class `is-active`) the current language, and
  **`show_langcode`** rewrites each `title` to its langcode.

### Calling it directly

```php
$links = \Drupal::languageManager()->getLanguageSwitchLinks(
  \Drupal\Core\Language\LanguageInterface::TYPE_CONTENT,
  \Drupal\Core\Url::fromRoute('<current>')
)->links ?? [];
\Drupal::service('language_switcher_extended.link_processor')->process($links);
```

To change behaviour, prefer editing `language_switcher_extended.settings` (see
[../configure/language_switcher_extended.md](../configure/language_switcher_extended.md))
rather than subclassing — the processor reads config on every call.
