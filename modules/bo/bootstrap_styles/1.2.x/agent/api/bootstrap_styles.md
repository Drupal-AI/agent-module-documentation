# Programmatic API — StylesGroupManager

The engine consumer modules (bootstrap_layout_builder) use to expose styles on Layout Builder
sections/blocks and render them. Service: `plugin.manager.bootstrap_styles_group`
(`Drupal\bootstrap_styles\StylesGroup\StylesGroupManager`). It also is a plugin manager, so it
extends `DefaultPluginManager`.

```php
/** @var \Drupal\bootstrap_styles\StylesGroup\StylesGroupManager $sgm */
$sgm = \Drupal::service('plugin.manager.bootstrap_styles_group');
```

## Enumerate groups / styles

```php
$groups = $sgm->getStylesGroups();          // group defs, each with a 'styles' array, weight-sorted
$styles = $sgm->getStyles();                // flat weight-sorted list of style defs
$one    = $sgm->getGroupStyles('background'); // styles belonging to one group
$allow  = $sgm->getAllowedPlugins($filter_config_name); // [group => [plugin_id,…]] whitelist
```

## Build the style form (the 3-step lifecycle)

```php
// 1. Add the grouped style controls to a form ($storage = previously saved values).
$sgm->buildStylesFormElements($form, $form_state, $storage, $filter);

// 2. On submit, collect the chosen values into a plugins-storage array.
$storage = $sgm->submitStylesFormElements($form, $form_state, $tree, $storage, $filter);

// 3. On render, attach the resulting CSS classes/libraries to an element build.
$build = $sgm->buildStyles($build, $storage, $theme_wrapper);
```

`buildStyles()` runs each group's `build()` first, then each style's `build()`, so classes are
applied to `$build['#attributes']['class']` (or `$build['#theme_wrappers'][$theme_wrapper]`).
`$filter` is an optional config name restricting which groups/plugins are offered
(see configure/settings.md). The companion style-plugin manager is
`plugin.manager.bootstrap_styles` (`Style\StyleManager`).

## Alter plugin definitions

Both managers call `alterInfo('bootstrap_styles_info')`, so implement
`hook_bootstrap_styles_info_alter(array &$definitions)` to add/remove/modify Style or
StylesGroup plugin definitions. (There is no `bootstrap_styles.api.php` file in the module.)

## Notes

- `hook_page_attachments_alter()` attaches the builder UI libraries + theme (dark/light per
  `layout_builder_theme`) only on Layout Builder routes.
- Background media uses the `media_library_form_element` dependency; the `bs_video_background`
  render element / `Element\VideoBackground` serves local background video.
- Scroll effects use the AOS library — remote by default, or local if placed in
  `libraries/aos/dist/aos.js` (swapped in by `hook_library_info_alter()`).
