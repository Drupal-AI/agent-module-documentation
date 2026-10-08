<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style, global settings & the configuration-URL mechanism

## The configuration URL → attributes mechanism

Everything the module renders is driven by one **service**,
`swiffy_slider.configuration` = `Drupal\swiffy_slider\Configuration` (implements
`ConfigurationInterface`, constructed with `@config.factory`; `swiffy_slider.services.yml`).

`ConfigurationInterface::CONFIGURATOR_URL` = `https://swiffyslider.com/configuration/`.

`toAttributes(?string $configurationURL)` (`src/Configuration.php`) does the work:

1. If `$configurationURL` is `NULL`, read the global default from config object
   `swiffy_slider.settings` key `configuration_url`. If still not a string, fall back to the
   configurator base URL.
2. `UrlHelper::parse($configurationURL)` splits the permalink into path/query/fragment. **The URL
   is only parsed — never fetched**, so there is no server-side request.
3. From the query array it builds a Drupal `Attribute`:
   - query keys starting with **`slider-`** → CSS **classes** (plus the always-present
     `swiffy-slider` class);
   - query keys starting with **`--swiffy-slider`** → a `style` attribute of CSS custom
     properties (built via a nested `Attribute` cast to string, then assigned to `style`);
   - query keys starting with **`data`** → merged in as **data-attributes**.
4. Returns the combined `Attribute`, rendered in Twig as `{{ swiffy_slider_attributes }}` on the
   slider container. (Values pass through Drupal's `Attribute` escaping.)

So an editor configures the slider visually at swiffyslider.com, copies the **permalink**, and the
query string of that permalink literally *is* the slider's classes/data/style.

`configurationUrlElement(?string $default)` returns the shared form element (`#type => url`,
`#maxlength => 1000`, description linking to the configurator).

## Global default settings form

- Route `swiffy_slider.settings` → `/admin/config/content/swiffy_slider`
  (`swiffy_slider.routing.yml`), form `Drupal\swiffy_slider\Form\SettingsForm`, permission
  **`administer site configuration`**. Menu link under *Configuration → Content authoring*
  (`swiffy_slider.links.menu.yml`, parent `system.admin_config_content`). Declared as
  `configure:` in the `.info.yml`.
- `buildForm()` renders the single `configuration_url` element (appending "This configuration is
  used as default configuration."). `submitForm()` saves the value, or `NULL` when empty, into
  config object `swiffy_slider.settings`.
- Schema: `swiffy_slider.settings` is a `config_object` with one nullable `uri` key
  `configuration_url`, `FullyValidatable`.

This value is the fallback used by every formatter and the Views style when they leave their own
URL blank (see `toAttributes()` step 1).

## Views style

`Drupal\swiffy_slider\Plugin\views\style\SwiffySlider` (`@ViewsStyle` id **`swiffy_slider`**,
theme `views_style_swiffy_slider`, `display_types = {"normal"}`):

- `$usesRowPlugin = TRUE`, `$usesGrouping = FALSE`.
- `defineOptions()` adds `configuration_url` (default `NULL`).
- `buildOptionsForm()` adds the shared `configurationUrlElement()` field.
- `validateOptionsForm()` normalises an empty `configuration_url` to `NULL`.
- Schema `views.style.swiffy_slider`: mapping with nullable `uri` `configuration_url`.

Rendering happens in `template_preprocess_views_style_swiffy_slider()` (`swiffy_slider.module`):
it reads the style option `configuration_url`, calls
`swiffy_slider.configuration->toAttributes($current_value)` into
`swiffy_slider_attributes`, attaches `swiffy_slider/swiffy_slider-lib`, and calls
`RenderHelper::attachCacheTags()`. Template
`templates/views-style-swiffy-slider.html.twig` wraps `rows` in
`<div{{ swiffy_slider_attributes }}><ul class="slider-container">…</ul>` with `slider-nav`
buttons and `slider-indicators`.

To use it: on a View display set the **Format** to *Swiffy Slider*, pick a row style (fields or an
entity view mode), and paste a permalink in the style settings.

## Cache tags

`RenderHelper::attachCacheTags(array &$build, ?string $current_value)` (`src/RenderHelper.php`)
only acts when `$current_value` is `NULL` (i.e. the render relies on the **global default**): it
then adds the `swiffy_slider.settings` config object as a cacheable dependency, so changing the
global URL invalidates the rendered sliders. When a per-instance URL is set, no extra tag is added
(the display config already carries it).

## Library override

`hook_library_info_alter()` (`swiffy_slider.module`) rewrites the `swiffy_slider-lib` JS/CSS paths
from the bundled `assets/vendor/dynamicweb/swiffy-slider` to `/libraries/<found>` when
`library.libraries_directory_file_finder->find('swiffy-slider')` returns a match — letting you ship
a self-installed newer library version instead of the bundled one (declared `v1.6.0` in
`swiffy_slider.libraries.yml`).

## Post-updates

`swiffy_slider.post_update.php` has three functions (`_1`/`_2`/`_3`) that convert any legacy
empty-string `configuration_url` (in `swiffy_slider.settings`, in `swiffy_slider` view-style
options, and in formatter `swiffy_slider_permalink` settings) to `NULL`, keeping the "empty means
use the default" contract consistent. Run with `drush updatedb`.
