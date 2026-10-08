<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# What drowl_media_video does

## Install & enable

```bash
drush en drowl_media_video -y
```

Requires the base `drowl_media` module (already present if DROWL Media is installed).

## The one hook

`drowl_media_video_form_media_video_form_alter(&$form, FormStateInterface $form_state, $form_id)`
in `drowl_media_video.module` targets the `media_video_form` (core video media add/edit form) and
attaches the module's admin library to the video-file widget:

```php
$form['field_media_video_file']['widget']['#attached']['library'][] = 'drowl_media_video/admin';
```

Per the in-file comments, the intended AJAX approach (a `change` callback copying the uploaded
video's URL into the video embed field) does not currently work due to core issue #3031542, so the
copy is done client-side by `dist/js/drowl_media.admin.video.js` instead.

## Library

`drowl_media_video/admin` (`drowl_media_video.libraries.yml`): `dist/js/drowl_media.admin.video.js`
(minified), dependencies `core/drupal`, `core/jquery`.

That is the entire module — no config, routes, permissions, services or PHP classes.
