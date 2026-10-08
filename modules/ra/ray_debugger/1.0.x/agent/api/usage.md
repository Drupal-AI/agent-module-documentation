<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Ray Debugger

## Install (dev only)
```
composer require --dev drupal/ray_debugger
drush en ray_debugger -y            # + only the submodules you need
```
Keep it out of production: `--require-dev` and/or `$settings['config_exclude_modules'][] = 'ray_debugger';`. Leftover `ray()` calls will fatal if the library is absent, so guard debug code accordingly.

## ray.php (project root)
```php
<?php
return [
  'enable' => true,
  'host' => 'host.docker.internal',
  'port' => 23517,
  'remote_path' => '/app/web',
  'local_path' => '/home/you/project/web',
  'always_send_raw_values' => false,
];
```
Set `enable => false` (or omit the file) to make every `ray()` call a no-op.

## PHP
```php
function mytheme_preprocess_html(&$variables) {
  ray($variables)->purple()->label('HTML variables');
}
```

## Twig (ray_debugger_twig)
`ray(value, method?, argument?)`:
```twig
{{ ray(view_mode, 'label', 'The current View Mode') }}
```
The extension calls `ray($params)`, or `ray()->$name()` / `ray($params)->$name($arguments)` when a method name is supplied.

## JavaScript (ray_debugger_js)
The submodule loads node-ray from a CDN and an init file on every page; then in a behavior:
```js
Drupal.behaviors.myModule = { attach: (context, settings) => ray(settings) };
```

## AlpineJS (ray_debugger_alpinejs)
```twig
<button x-on:click="$ray(message)" x-data="{ message: 'Debugging Alpine' }">Click me!</button>
```

## Caution
Enabling `ray_debugger_js`/`ray_debugger_alpinejs` injects client scripts (JS submodule from an external CDN) on **all** pages. Only enable the submodules you actually use, and only in development.
