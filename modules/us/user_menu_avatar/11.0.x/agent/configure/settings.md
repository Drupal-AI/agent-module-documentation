<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings form & config object

- Route: `user_menu_avatar.config` → `/admin/config/people/user-menu-avatar`
- Access: core permission `administer site configuration`
- Form: `Drupal\user_menu_avatar\Form\UserMenuAvatarConfigurationForm` (`getFormId()` =
  `user_menu_avatar_form`), a `ConfigFormBase`
- Config object: `user_menu_avatar.settings`
- Admin menu link `user_menu_avatar.config` sits under `user.admin_index`; a "Settings" local
  task is defined too.

The form has two fieldsets: **Authenticated User Settings** and **Anonymous User Settings**.
All keys are written on submit (`submitForm()`); `config/install` only ships
`custom_anonymous_text: 'Log in'` and `avatar_custom_display_text: ''`, so the other keys take
their form defaults (the `?? ...` fallbacks below) until the form is first saved.

## Config keys

| Key | Type / values | Default | Effect |
|-----|---------------|---------|--------|
| `display_menu_avatar` | `yes` / `no` | `no` | Authenticated: render the avatar image on the `user.page` link. |
| `avatar_shape` | `circle` / `square` | `circle` | Adds class `shape-circle` / `shape-square` (circle = `border-radius:50%`). |
| `avatar_size` | number (px) | `50` | Inline `width`/`height` on the image span (value + `px`). |
| `avatar_image_style` | image style machine name | `medium` | Style applied to the avatar (skipped for `image/svg+xml`). |
| `avatar_image_field` | user field machine name | `user_picture` | Field read for the image; may be an `image` field or an `entity_reference` (media) field. |
| `display_user_name` | `yes` / `no` | `no` | Authenticated: also render the name text (name is always in the DOM for screen readers). |
| `avatar_custom_name_field` | user field machine name (optional) | `''` | If set and non-empty on the user, its `->value` replaces `getDisplayName()`. |
| `avatar_custom_display_text` | text (optional) | `''` | If non-empty, this literal string overrides the name entirely. |
| `display_anonymous_avatar` | `yes` / `no` | `no` | Anonymous: render the uploaded anonymous avatar on the `user.login` link. |
| `anonymous_user_avatar` | managed_file (fid) | none | Uploaded image for anonymous users; stored at `public://user-menu-avatar/anonymous-avatar`; formats `gif png jpg jpeg svg`. |
| `display_anonymous_text` | `yes` / `no` | `no` | Anonymous: render the anonymous text visually. |
| `custom_anonymous_text` | text | `Log in` | The anonymous label (always available to screen readers). |

Name precedence (authenticated): `avatar_custom_display_text` (if non-empty) > value of
`avatar_custom_name_field` (if the field exists and is non-empty) > `getDisplayName()`.

## Config schema

`config/schema/user_menu_avatar.schema.yml` types `user_menu_avatar.settings` as a
`config_object` but only maps two keys — `custom_anonymous_text` and
`avatar_custom_display_text` (both `text`). The remaining keys are stored without a schema entry.

## Set via Drush / PHP

```bash
drush config:set user_menu_avatar.settings display_menu_avatar yes -y
drush config:set user_menu_avatar.settings avatar_image_field field_avatar_media -y
drush config:set user_menu_avatar.settings avatar_image_style thumbnail -y
```

```php
\Drupal::configFactory()->getEditable('user_menu_avatar.settings')
  ->set('display_menu_avatar', 'yes')
  ->set('display_user_name', 'yes')
  ->set('avatar_shape', 'circle')
  ->set('avatar_size', '40')
  ->set('avatar_image_style', 'thumbnail')
  ->set('avatar_image_field', 'user_picture')
  ->save();
```

Read-only helper used by the module: `\Drupal::config('user_menu_avatar.settings')` (wrapped
by `uma_c_fv()` in the `.module` file).
