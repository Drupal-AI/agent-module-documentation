<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styleguide plugin: ExIconsStyleguide

Single class: `Drupal\ex_icons_styleguide\Plugin\Styleguide\ExIconsStyleguide`
(`src/Plugin/Styleguide/ExIconsStyleguide.php`). This is the module's entire behaviour.

## Plugin definition
Annotation `@Plugin`:
- `id = "ex_icons_styleguide"`
- `label = @Translation("External-use Icons")`

Extends `Drupal\styleguide\Plugin\StyleguidePluginBase`; the Styleguide module discovers it and includes its items when rendering a theme's styleguide.

## Construction / DI
- `create()` injects two services: `styleguide.generator` (`GeneratorInterface`, stored as `$this->generator`) and `ex_icons.manager` (`ExIconsManagerInterface`, stored as `$this->exIconsManager`).
- Note: `$this->generator` is assigned but not used in 1.1.0; the `$moduleHandler` property is declared but never populated. Only `exIconsManager` is functionally used.

## Output (`items()` → `exIcons()`)
`items()` merges and returns `exIcons()`. `exIcons()`:
1. `$available_icons = $this->exIconsManager->getIconOptions();` — an array keyed by icon plugin id (the `ex_icon_null` fallback is excluded upstream by `ExIconsManager::getIconOptions()`).
2. If non-empty, builds one item `$items['ex_icons']`:
   - `title` / `group` = `t('External-use icons')`.
   - `content` = a `#type => container` with inline `style` making a responsive grid: `display:grid;grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));gap: 15px;`.
3. For each `$icon` (the array key/id) it appends a cell `content[$icon]`:
   - a bordered, centred `container` (inline flex styles, `aspect-ratio:1`);
   - `icon` = `['#theme' => 'ex_icon', '#id' => $icon, '#attributes' => ['height' => 40, 'width' => 40]]` — delegates actual SVG rendering to ex_icons' `ex_icon` theme hook / `template_preprocess_ex_icon()`;
   - `title` = an `html_tag` `<small>` whose `#value` is the icon id (rendered as an escaped text node by the html_tag element).

If `getIconOptions()` is empty, `items()` returns `[]` and nothing is added to the styleguide.

## Where it appears
No route is defined here. The output surfaces on the Styleguide module's pages:
`/admin/appearance/styleguide/THEME_NAME` (route `styleguide.page` + per-theme routes from `styleguide.routes::routes`), gated by styleguide's `view style guides` permission.

## Operate / verify
- Install: `drush en ex_icons_styleguide -y` (pulls in `ex_icons` and `styleguide`).
- Visit `/admin/appearance/styleguide/THEME_NAME` for any enabled theme; the "External-use icons" group shows the grid.
- Empty grid usually means ex_icons discovered no icons — check the theme/module `*.ex_icons.yml` sprite definitions and clear caches (`drush cr`); `getIconOptions()` reads cached plugin definitions.
- No configuration exists; behaviour is entirely driven by what ex_icons discovers.
