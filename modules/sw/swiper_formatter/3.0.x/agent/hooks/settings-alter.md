<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_swiper_formatter_settings_alter()

The only hook the module invites (`swiper_formatter.api.php`). Called from
`Swiper::renderSwiper()` for every rendered Swiper instance, so you can adjust the resolved
`swiper_options` for that specific instance before the JS gets them.

```php
/**
 * Implements hook_swiper_formatter_settings_alter().
 *
 * @param string $id        Swiper instance id (the DOM/config id).
 * @param array &$settings  Resolved swiper_options (modify by reference).
 * @param array $output     The slide render arrays (read-only) — e.g. count($output).
 */
function mymodule_swiper_formatter_settings_alter(string $id, array &$settings, array $output): void {
  // Force auto slides-per-view everywhere.
  $settings['slidesPerView'] = 'auto';

  // Compute a grid from the number of slides for one template.
  if ($settings['template'] == 'my_template_id') {
    $columns = 2;
    $settings['grid'] = ['rows' => round(count($output) / $columns), 'fill' => 'row'];
    $settings['spaceBetween'] = 20;
    $settings['slidesPerView'] = $columns;
  }
}
```

Use it for logic that can't be expressed as static template config: per-instance grids,
conditional autoplay, dynamic breakpoints, etc. `$settings` keys are the same
`swiper_options` documented in `configure/swiper-templates.md`.
