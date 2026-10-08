<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings (`gin_lb.settings`)

Route `gin_lb.gin_lb_settings_form` → **`/admin/config/gin_lb/settings`**, requires
`administer site configuration`, `_admin_route: TRUE`. Menu link sits under
*Configuration → User interface* (`system.admin_config_ui`, weight 99). Form class
`Drupal\gin_lb\Form\SettingsForm` (a plain `ConfigFormBase`).

## Shipped defaults (`config/install/gin_lb.settings.yml`)

```yaml
toastify_loading: 'cdn'
enable_preview_regions: false
hide_discard_button: true
hide_revert_button: true
save_behavior: 'stay'
```

## Keys

| Key | Type | Values | Effect |
|---|---|---|---|
| `toastify_loading` | string | `cdn` \| `composer` \| `custom` | Which Toastify library `hook_library_info_alter()` adds as a dependency of `gin_lb/gin_lb_toastify` (`gin_lb/toastify_cdn` or `gin_lb/toastify_composer`). `custom` = "Do not load", and `PageAttachments` then skips attaching `gin_lb/gin_lb_toastify` altogether. |
| `enable_preview_regions` | boolean | | Whether Layout Builder's *Regions* preview starts on. |
| `hide_discard_button` | boolean | | `TRUE` sets `$form['actions']['discard_changes']['#access'] = FALSE` on styled Layout Builder forms. |
| `hide_revert_button` | boolean | | `TRUE` sets `$form['actions']['revert']['#access'] = FALSE`. |
| `save_behavior` | string | `stay` \| `default` | `stay` adds `FormAlter::redirectSubmit` which redirects to `<current>` after saving a layout; `default` leaves core's redirect. |

Both button settings only apply to forms `ContextValidator::isLayoutBuilderFormId()` accepts —
i.e. they do nothing when the active theme is Gin.

## Reading / writing it

```bash
drush cget gin_lb.settings
drush cget gin_lb.settings save_behavior
drush cset gin_lb.settings save_behavior default -y
drush cset gin_lb.settings hide_discard_button 0 -y
```

From PHP:

```php
$mode = \Drupal::config('gin_lb.settings')->get('toastify_loading');

\Drupal::configFactory()->getEditable('gin_lb.settings')
  ->set('enable_preview_regions', TRUE)
  ->save();
```

The form's `submitForm()` also calls
`Cache::invalidateTags(\Drupal::config('gin_lb.settings')->getCacheTags())`; when you change
the config from code, run `drush cr` (the library alter is cached in `library_info`).

## Config schema

`config/schema/gin_lb.schema.yml` types `gin_lb.settings` as a `config_object` with exactly the
five mapped keys above — no other key is valid.

## Update-hook history (why old keys may linger)

`gin_lb.install` renamed keys over time: `toastify_cdn` → `toastify_loading` (8002),
`safe_behavior` → `save_behavior` (8003), and the single `hide_discard_revert_buttons` was split
into `hide_discard_button` + `hide_revert_button` (8004); 8005 clears the stale `toastify_cdn`
and `safe_behavior`. If you meet those names in an old export, they are dead.

## No other configuration

There is no `configure` UI beyond this form: no permissions file, no config entities, no Drush
commands, no plugin types.
