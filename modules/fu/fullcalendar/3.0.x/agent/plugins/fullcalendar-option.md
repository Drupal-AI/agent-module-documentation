<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullCalendar "option" plugin type

FullCalendar defines its own plugin type so modules can contribute handlers that add options
to the calendar's settings form and inject settings into the rendered calendar.

## The plugin type

- Manager service: `plugin.manager.fullcalendar` (`FullcalendarManager`, extends
  `DefaultPluginManager`, `parent: default_plugin_manager`).
- Discovery directory: `Plugin/fullcalendar/type` (in any module).
- Annotation: `@FullcalendarOption` (`Drupal\fullcalendar\Annotation\FullcalendarOption`) with
  properties `id`, `js` (bool), `css` (bool), `weight` (int).
- Interface: `FullcalendarInterface`; base class: `FullcalendarBase`.
- Alter hook: `fullcalendar_type_info`; cache key `fullcalendar_type_plugins`.

The Views style plugin collects all `FullcalendarOption` plugins into a
`FullcalendarPluginCollection` and calls each one's lifecycle methods.

## Interface (`FullcalendarInterface`) methods

- `setStyle(StylePluginBase $style): self` — receives the owning Views style.
- `defineOptions(): array` — default option values contributed by this plugin.
- `buildOptionsForm(array &$form, FormStateInterface $form_state): void` — add fields to the
  FullCalendar settings form.
- `submitOptionsForm(array &$form, FormStateInterface $form_state): void`.
- `process(array &$settings): void` — mutate the settings passed to the JS calendar.
- `preView(array &$settings): void` — run just before rendering.

## The module's own plugin

`Plugin/fullcalendar/type/FullCalendar.php`:

```php
@FullcalendarOption(
  id = "fullcalendar",
  module = "fullcalendar",
  js = TRUE,
  weight = "-20"
)
```

It builds the main option form (using `OptionsFormHelperTrait`) and processes the bulk of the
settings. Its low weight makes it run first.

## Implement your own option plugin

Create `your_module/src/Plugin/fullcalendar/type/MyOption.php`:

```php
namespace Drupal\your_module\Plugin\fullcalendar\type;

use Drupal\fullcalendar\Plugin\FullcalendarBase;

/**
 * @FullcalendarOption(
 *   id = "my_option",
 *   module = "your_module",
 *   js = TRUE,
 *   weight = 0
 * )
 */
class MyOption extends FullcalendarBase {
  public function defineOptions(): array { return ['my_setting' => ['default' => '']]; }
  public function buildOptionsForm(array &$form, $form_state): void { /* add form fields */ }
  public function process(array &$settings): void { /* $settings['myKey'] = ...; */ }
}
```

The plugin is discovered automatically; no service registration needed. Use `js = TRUE` /
`css = TRUE` if your option requires attaching assets, and `weight` to order relative to the
built-in `fullcalendar` plugin (which is `-20`).
