# Rendering, plugin manager & extension points

## Render an icon (three ways)

- **Twig function** (`TwigExtension`): `ex_icon(id, attributes = {}, title = '')` → returns an `ex_icon`
  render array. E.g. `{{ ex_icon('arrow', { height: 20, class: 'foo' }, 'Show more'|t) }}`.
- **Render element**: `['#theme' => 'ex_icon', '#id' => 'arrow', '#title' => t('Show more'),
  '#attributes' => ['width' => 25]]`.
- **Form picker element**: `['#type' => 'ex_icon_select', '#title' => …, '#default_value' => 'arrow']`
  (`Element/ExIconSelect`, extends `Radios`) — options come from `ex_icons.manager->getIconOptions()`;
  each radio renders the icon; a "No icon" empty option is added when not required.

### Theme hook `ex_icon` (`template_preprocess_ex_icon`, `templates/ex-icon.html.twig`)
Template: `{% if title %}<span{{ title_attributes }}>{{ title }}</span>{% endif %}
<svg{{ attributes }}><use href="{{ url }}"/></svg>`. Preprocess loads the icon instance, defaults
`aria-hidden=true`, makes the title `visually-hidden`, and if exactly one of width/height is set (and
numeric) derives the other from `getAspectRatio()`. `title` is auto-escaped by Twig.

## Plugin manager `ex_icons.manager` (`ExIconsManager`)

Service args: `@module_handler`, `@theme_handler`, `@cache.discovery`, `@string_translation`.
Implements `FallbackPluginManagerInterface` (fallback id `ex_icon_null`). Discovery
(`Plugin/Discovery/SvgSymbolDiscovery` → `Discovery/SvgSymbolDiscovery`) scans module + theme directories
for `dist/icons.svg`, parses with `Serialization/SvgSpriteSheet::decode()` (DOMDocument), and marks the
`label` property translatable. Useful methods:

| Method | Returns |
|---|---|
| `getDefinitions()` | all icon defs keyed by id (`+ provider`, `url`, `id`) |
| `getInstance(['id' => $id])` | an `ExIcon` instance (or fallback) |
| `getIconOptions()` | `[id => label]` map for form options (skips `ex_icon_null`) |

`ExIcon` (`ExIconInterface`): `getLabel()`, `getProvider()`, `getWidth()`, `getHeight()`,
`getAspectRatio()`, `getUrl()`.

Caching: `setCacheBackend(cache.discovery, 'ex_icons', ['ex_icons'])`. `ex_icons.module` clears the cache
on module/theme install + uninstall. `hook_page_attachments` publishes one base sprite URL per provider
to `drupalSettings.exIcons.paths`.

## Drush

`drush cache-clear ex-icons` (`Commands/ExIconsCommands`, hooked into `cache-clear`) →
`clearCachedDefinitions()`.

## Hook

```php
/** Alter discovered icon plugin definitions. */
function hook_ex_icons_alter(array &$definitions) {
  $definitions['example-icon']['label'] = t('Foobar');
}
```
The module's own implementation registers the `ex_icon_null` fallback definition.

## Sprite file format

`dist/icons.svg` with `<symbol id="…" viewBox="minx miny w h">…<title>Label</title>…</symbol>` elements
(anywhere in the file). Symbols without an `id`, or with a non-4-numeric `viewBox`, are skipped.
