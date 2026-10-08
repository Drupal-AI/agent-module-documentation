# Permissions

The module defines exactly one permission (`image_hotspots.permissions.yml`):

| Permission | Title | Grants |
|---|---|---|
| `edit image hotspots` | Create and edit edit image hotspots (label as-shipped, sic) | Create, update, delete and translate hotspots on any image displayed with the `image_with_hotspots` formatter. |

Behaviour tied to this permission:

- **Routes.** All four `/image-hotspots/…` controller routes require `_permission: 'edit image
  hotspots'`.
- **Edit UI.** In `ImageHotspotsFormatter::viewElements()` the "Add hotspot" button, the inline edit
  form and the Jcrop/edit JS libraries are only attached when
  `$this->currentUser->hasPermission('edit image hotspots')` is true; everyone else sees the labels
  read-only.

The permission is **site-wide**: it is not scoped to a bundle, field, or the images a user owns —
a holder can annotate every image the site renders with the formatter. Grant it on
*People → Permissions* (`/admin/people/permissions`).

There is no separate "administer" permission — this single permission governs the whole edit surface.
