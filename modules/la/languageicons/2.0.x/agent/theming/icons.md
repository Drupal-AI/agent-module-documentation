<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How icons attach (hook + theme)

## Injection point

`languageicons_language_switch_links_alter(&$links, $type, $path)` implements
`hook_language_switch_links_alter()`. If `show_block` OR `show_node` is truthy, it walks each
language switch link and calls `languageicons_link_add()`, which replaces the link's `title`
with a render array using the `languageicons_link_content` theme hook and sets
`$link['html'] = TRUE`. This is why icons appear in the **Language switcher block** and any
other links passing through that core alter hook.

## Theme hook & template

`languageicons_theme()` registers:

```php
'languageicons_link_content' => [
  'variables' => ['language' => NULL, 'separator' => ' ', 'text' => NULL, 'title' => NULL],
],
```

Template: **`templates/languageicons-link-content.html.twig`** — renders `icon`/`text` in the
order dictated by `placement`:

```twig
{% if placement == 'before' %}{{ icon }}{{ separator }}{{ text }}{% endif %}
{% if placement == 'after' %}{{ text }}{{ separator }}{{ icon }}{% endif %}
{% if placement == 'replace' %}{{ icon }}{% endif %}
```

Override it by copying the template into your theme.

## Preprocess: building the icon image

`template_preprocess_languageicons_link_content()` builds `variables['icon']` as an `image`
render element:

- `#uri` = `str_replace('*', $language->getId(), $path)` — the `path` setting's `*` is
  swapped for the langcode (e.g. `.../flags/de.png`).
- `#alt` / `#title` = the icon title (defaults to the language name).
- `#width` / `#height` from the `size` setting (`WxH`).
- `#attributes['class'] = ['language-icon']` — style hook for CSS.

If `path` is empty it throws `Path to language icons is not defined.` — the install hook sets
a default path, so only a manual blanking of `path` triggers this.

## Notes

- The bundled icons are ~60 PNG flags in `flags/` (12px tall). To use your own, change `path`
  (and `size`) — see [../configure/settings.md](../configure/settings.md).
- No plugins, services, or Drush; this is hook + theme + config only.
