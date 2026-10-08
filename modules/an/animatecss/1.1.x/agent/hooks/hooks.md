<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AnimateCSS hooks

Declared in `animatecss.api.php`. Two hooks let a module extend the animation catalog and register scroll-reveal integrations.

## `hook_animatecss_animation_names(array $animation_name = [])`

Add custom animation names to the list returned by `animatecss_animation_names()` (so they appear in animation selects). Return a render array of names in the same grouped shape used by the core catalog.

```php
function mymodule_animatecss_animation_names(array $animation_name = []) {
  return [
    'custom' => [
      'both' => [
        'Custom effects' => [
          'myCustomFx' => t('myCustomFx'),
        ],
      ],
    ],
  ];
}
```

Invoked via `invokeAll('animatecss_animation_names', ...)` then `array_reverse`d, so later-added names precede the built-ins.

## `hook_animatecss_scroll_options(array $option)`

Register a scroll-reveal library (e.g. ScrollReveal-style) and the form fields it exposes, surfaced through `animatecss_scroll_options()`. Return `[$machine_name => ['name' => ..., 'description' => ..., 'fields' => [ ...form elements... ]]]`. The machine name must be lowercase letters only, and `name`/`description` must be non-empty or the entry is skipped.

```php
function mymodule_animatecss_scroll_options(array $option) {
  return [
    'myscroll' => [
      'name' => 'My Scroll',
      'description' => 'Reveal animations as you scroll.',
      'fields' => [
        'myscroll_offset' => [
          '#type' => 'number',
          '#title' => t('Offset'),
          '#field_suffix' => 'px',
        ],
      ],
    ],
  ];
}
```

Note: `animatecss.module`'s `animatecss_scroll_options()` invokes the hook name `animatecss_scroll_library_options` (a slight mismatch with the documented `hook_animatecss_scroll_options` in `.api.php`); match the invoked name if wiring a real integration.
