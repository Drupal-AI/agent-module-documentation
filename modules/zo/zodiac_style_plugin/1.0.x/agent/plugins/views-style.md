<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style plugin: Zodiac (carousel)

The module's whole surface is one Views style plugin. It does not define a plugin *type* for others
to extend; it *provides* a style plugin for the core Views style plugin type.

## Definition

- Class: `Drupal\zodiac_style_plugin\Plugin\views\style\Zodiac` extends
  `\Drupal\views\Plugin\views\style\StylePluginBase`, implements `ContainerFactoryPluginInterface`.
- Annotation `@ViewsStyle`: id `zodiac_style_plugin`, title `Zodiac`, `theme = "views_view_zodiac"`,
  `display_types = {"normal"}`.
- `$usesRowPlugin = TRUE` (requires a row style — the shipped test view uses `fields`),
  `$usesGrouping = FALSE`.
- Injects `breakpoint.manager` (`BreakpointManagerInterface`) via `create()`.

## Render pipeline (`Zodiac::render()`)

1. Calls `parent::render()` and `reset()`s to the single rendered output element.
2. Sets `#attributes['id']` to a unique id — `Html::getUniqueId('zodiac')` (base id const
   `Zodiac::BASE_HTML_ID = 'zodiac'`), memoised in `getHtmlId()` — and adds the `zodiac` class.
3. Attaches the asset library `zodiac_style_plugin/behavior`.
4. Writes settings to `drupalSettings['zodiac'][<htmlId>] = $this->getZodiacSettings()`.

`getZodiacSettings()` returns `base_options` merged with a `mediaQueryOptions` map (breakpoint media
query string → that breakpoint's override options), so each slider instance carries its own config
under its unique id.

## Theme + template

`zodiac_style_plugin_theme()` declares the `views_view_zodiac` hook with variables `attributes`,
`rows`, `view`. Template `templates/views-view-zodiac.html.twig` outputs:

- a left/prev `<button data-zodiac-direction="left">` (SVG chevron + visually-hidden "Previous"),
- `.zodiac-inner > .zodiac-track` containing one `.zodiac-item` per `row`,
- a right/next `<button data-zodiac-direction="right">` (visually-hidden "Next").

No preprocess function is defined; `rows` and `attributes` come from the base style render. The
template emits `{{ attributes }}` (an escaped Attribute object) and `{{ row }}` (rendered row
markup) only — no configuration value is printed into the markup.

## Asset library + JS init

`zodiac_style_plugin.libraries.yml` → library `behavior`:

- CSS: `node_modules/@librarymarket/zodiac/dist/css/zodiac.css`, `css/zodiac-style-plugin.css`
- JS: `node_modules/@librarymarket/zodiac/dist/zodiac.min.js`, `js/behavior.js`
- Dependencies: `core/drupal`, `core/drupalSettings`, `core/once`

`js/behavior.js` (`Drupal.behaviors.zodiac.attach`) iterates `drupalSettings.zodiac`, and for each
`[id, settings]` runs `once(id, '#'+id, context)` then `new Zodiac('#'+id, settings).mount()`. The
`Zodiac` global class comes from the bundled `zodiac.min.js`; `once()` prevents re-init after
AJAX/BigPipe.

## Adding to a view

Set the display's Format/Style to `zodiac_style_plugin` with a `fields` (or other) row style; see
[../configure/options.md](../configure/options.md) for the options. There is no route, permission,
service, hook (beyond `hook_theme`), or drush command to invoke — enabling the module and choosing
the style is the entire integration.
