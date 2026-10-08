<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Image Rotate — permissions

Defined in `simple_image_rotate.permissions.yml`:

| Permission | Gates |
|---|---|
| `rotate images` | Whether the "Rotate image clockwise" button appears in image widgets. Even if a field has `enable_rotate` on, the button is only added for users who have this permission (checked in `hook_field_widget_complete_form_alter()`). |

Grant it to roles (e.g. editors, photographers) that should be able to rotate uploaded images.
It is an ordinary permission (no `restrict access` flag). Enabling rotation therefore takes two
things: the per-field `enable_rotate` setting (see
[../configure/enable-rotate.md](../configure/enable-rotate.md)) **and** this permission.
