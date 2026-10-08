<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Nine permissions from `media_gallery.permissions.yml`:

| Permission | Gates | Restricted |
|---|---|---|
| `administer media gallery` | The settings route `entity.media_gallery.settings` (`/admin/structure/media-gallery`) and Field UI | yes (`restrict access: true`) |
| `access media gallery overview` | The gallery collection / overview; this is the entity's `admin_permission` | no |
| `add media gallery entities` | Creating new galleries | no |
| `edit own media gallery entities` | Editing galleries you own | no |
| `edit any media gallery entities` | Editing any gallery | no |
| `delete own media gallery entities` | Deleting galleries you own | no |
| `delete any media gallery entities` | Deleting any gallery | no |
| `view published media gallery entities` | Viewing published galleries | no |
| `view unpublished media gallery entities` | Viewing unpublished galleries | no |

Entity access is decided by `MediaGalleryEntityAccessControlHandler` (the entity's `access`
handler) against these permissions. The create/edit/delete/view split follows Drupal's standard
own-vs-any pattern. Note the shipped **`/galleries`** View uses core's `access content` permission,
not these — it is a Views page, so its access is controlled in the View, not the entity handler.
