<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# robotstxt_utils — form alter, config, and deletion behavior

## Install / enable

`drush en robotstxt_utils -y`. Requires the contrib **`robotstxt`** module (declared in
`robotstxt_utils.info.yml` `dependencies`). Package `Search`.

There is **no dedicated settings route**. The `.info.yml` lists
`configure: robotstxt_utils.admin_settings_form`, but the submodule ships no `routing.yml`, so that
configure link resolves to nothing. All configuration happens on the Robotstxt module's own
settings form (form id `robotstxt_admin_settings`, under that module's permission).

## Form alter — `robotstxt_utils_form_robotstxt_admin_settings_alter(&$form, $form_state, $form_id)`

Adds one element to the Robotstxt admin form:

```php
$form['eliminar_robots_txt'] = [
  '#type' => 'checkbox',
  '#title' => t('Delete physical robots.txt'),
  '#default_value' => \Drupal::config('robotstxt_utils.settings')->get('eliminar_robots_txt'),
  '#weight' => 90,
];
$form['#submit'][] = 'robotstxt_utils_admin_settings_submit';
```

## Submit handler — `robotstxt_utils_admin_settings_submit()`

Saves the checkbox to the editable `robotstxt_utils.settings` config. When it is true, it deletes
the physical file:

```php
$robots_txt_destination = DRUPAL_ROOT . '/robots.txt';
if (file_exists($robots_txt_destination) && is_writable($robots_txt_destination)) {
  \Drupal::service('file_system')->unlink($robots_txt_destination);
  // messenger: "robots.txt file deleted from @path."
}
// else: informational message (no file found) or error (could not delete — check permissions).
```

The path is the fixed docroot `robots.txt`; nothing about it is request- or config-derived.

## Cron — `robotstxt_utils_cron()`

```php
if ($config->get('eliminar_robots_txt') && $module_handler->moduleExists('robotstxt')) {
  $robots_txt_destination = DRUPAL_ROOT . '/robots.txt';
  if (file_exists($robots_txt_destination) && is_writable($robots_txt_destination)) {
    $file_system->unlink($robots_txt_destination);
  }
}
```

So a redeploy that restores `robots.txt` is cleaned up again on the next cron run, provided the
Robotstxt module is enabled.

## Config object `robotstxt_utils.settings`

- Install default (`config/install/robotstxt_utils.settings.yml`): `eliminar_robots_txt: false`.
- Schema (`config/schema/robotstxt_utils.schema.yml`, `type: config_object`): single boolean
  `eliminar_robots_txt`.

## Operating notes

- Enable Robotstxt first, then this submodule; the checkbox appears on the Robotstxt settings form.
- To stop deleting the file, uncheck the box (config → false); cron then leaves any physical
  `robots.txt` in place.
- The parent `htaccess` module historically handled robots.txt deletion; that logic was moved here
  (see the comment in `htaccess_cron()`).
