<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

One static permission (`responsive_video_style.permissions.yml`):

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer responsive video styles` | **true** | Create, edit, and delete responsive video styles. |

`restrict access: true` marks it security-sensitive (Drupal warns when granting it), so it is meant
only for trusted administrator roles.

## What it gates

It is the `admin_permission` of the `responsive_video_style` config entity and the `_permission`
requirement on **every** route in `responsive_video_style.routing.yml`:

- `entity.responsive_video_style.collection` — `/admin/config/media/video-styles/responsive`
- `entity.responsive_video_style.add_form` — `…/responsive/add`
- `entity.responsive_video_style.edit_form` — `…/responsive/{responsive_video_style}`
- `entity.responsive_video_style.delete_form` — `…/responsive/{responsive_video_style}/delete`

There are no anonymous or lower-privilege routes. Front-end rendering of a responsive video via the
formatter requires no special permission beyond the normal entity/field view access handled upstream
by Drupal; this permission only governs the admin configuration UI. The optional
`responsive_video_style_api` submodule governs its own exposure separately (out of scope here).
