<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting custom CSS for a theme

## Via the UI

*Appearance → Settings* for the theme (`/admin/appearance/settings/<theme>`) → the
**Custom CSS** details element (open by default):

| Field | Config key | Meaning |
|---|---|---|
| Enable or disable custom CSS | `enabled` | Master switch; when FALSE nothing is attached. |
| (textarea, id `css-editor-textarea`) | `css` | The CSS source. |
| Use plain text editor | `plaintext_enabled` | Disable CodeMirror syntax highlighting. |
| Enable auto preview | `autopreview_enabled` | Live-update the preview iframe while typing. |
| Preview path | *(not saved)* | Only steers the preview iframe. |

Saving runs `_css_editor_theme_settings_form_submit()` **before** core's own submit handler
(`array_unshift($form['#submit'], …)`), writes the four values, calls
`css_editor.css_generator::generateCssFile($theme)` and then `drupal_flush_all_caches()`.
The values are then unset from the form state so they are not stored in the theme settings.

## Via config (drush)

```bash
drush cset css_editor.theme.olivero enabled true -y
drush cset css_editor.theme.olivero css '.site-branding__name { color: rebeccapurple; }' -y
drush cget css_editor.theme.olivero
```

Config schema `css_editor.theme.*` (a `config_object`):

```yaml
path: 'public://css_editor/olivero.css'   # written by the service, type: path
enabled: true
css: ".site-branding__name { color: rebeccapurple; }"
plaintext_enabled: false
autopreview_enabled: false
```

## Via PHP (and generating the file)

Writing the config alone is **not** enough for the CSS to be served — the file at `path` must
exist. Either call the service or flush caches:

```php
\Drupal::configFactory()->getEditable('css_editor.theme.olivero')
  ->set('enabled', TRUE)
  ->set('css', '.site-branding__name { color: rebeccapurple; }')
  ->save();

// Writes public://css_editor/olivero.css and stores its URI back into `path`.
\Drupal::service('css_editor.css_generator')->generateCssFile('olivero');
```

`hook_cache_flush()` also calls `regenerateAllCssFiles()`, so a plain `drush cr` after a config
import rebuilds every theme's file.

## Which themes have custom CSS?

```php
foreach (\Drupal::configFactory()->listAll('css_editor.theme.') as $name) {
  $theme = str_replace('css_editor.theme.', '', $name);
  $c = \Drupal::config($name);
  printf("%s enabled=%s path=%s\n", $theme, var_export($c->get('enabled'), TRUE), $c->get('path'));
}
```

```bash
drush php:eval 'print implode("\n", \Drupal::configFactory()->listAll("css_editor.theme."));'
```

## Gotchas

- `generateCssFile()` returns FALSE and writes nothing when `enabled` is FALSE **or** `css` is
  empty — so the old file can linger; the delivery hooks still guard on `enabled`.
- The config is per *theme machine name*; the CSS only loads while that theme is the active
  theme, so admin-theme rules go on `css_editor.theme.claro` (or whatever the admin theme is).
- CodeMirror is loaded from `//cdnjs.cloudflare.com/ajax/libs/codemirror/5.31.0/…`. With no
  outbound network the editor degrades to a plain textarea — tick *Use plain text editor*.
- The module defines **no permissions**; access is core's `administer themes` on the theme
  settings route.
