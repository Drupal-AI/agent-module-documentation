# Theming / targeting the language links

The generated links are ordinary menu items, so they render through your active theme's
`menu.html.twig`. Identify them by plugin id prefix and read the language object from the link options.

## Detect a language link in Twig

Each item id starts with `language_switcher_menu.language_switcher_link:`:

```twig
{% if id starts with 'language_switcher_menu.language_switcher_link:' %}
  {% set language = item.original_link.getOptions()['language'] %}
  <a href="{{ item.url }}" lang="{{ language.getId() }}" class="language-switcher-link">
    <abbr title="{{ item.title }}">{{ language.getId() }}</abbr>
  </a>
{% else %}
  {{ link(item.title, item.url, { 'class': ['menu__link'] }) }}
{% endif %}
```

Other useful discriminators on `item.original_link`: `item.original_link.class` (the
`LanguageSwitcherLink` plugin class) and `item.original_link.provider` (`language_switcher_menu`). The
`language` value is a `\Drupal\Core\Language\LanguageInterface` (`getId()`, `getName()`).

## Altering the links programmatically

The links reuse core's language-switch link resolution, so implement core's
`hook_language_switch_links_alter(&$links, $type, $path)` in a custom module (or use any contrib module
that implements it) to add/remove/alter them. There is no module-specific alter hook.

## Notes

- Links are uncacheable (`getCacheMaxAge()` = 0) because the switch URL depends on the current route.
- `set_active_class` is enabled, so the active language link gets the standard `is-active` handling.
- On the front page or a routeless context (e.g. 404 with big_pipe) the link falls back to `<front>`.
