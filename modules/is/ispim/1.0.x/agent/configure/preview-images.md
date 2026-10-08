<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ISPIM preview images

## Where
- Collection / management: `/admin/config/media/ispim-preview-image` (menu: Config › Media › *Image Style Preview Images*).
- Per-entity settings form: `entity.ispim_preview_image.settings_form` at `/admin/config/media/ispim-preview-image/settings`.

## Permissions
Grant the entity admin permission and `ispim.ispim_preview_image.settings.admin` ("Access to manage ispim ispim_preview_image.settings") only to trusted roles — both are `restrict access: true`. Per-operation permissions (create/update/delete/view) come from `Drupal\ispim\PreviewImage\PermissionProvider`.

## What it does
`ispim_preview_image` is a revisionable, translatable content entity with its own `Storage`, `StorageSchema`, `RouteProvider`, `AccessControlHandler`, `ListBuilder`, and `ViewBuilder`. Configured entries are exposed to the image-style admin pages; `js/ispim.preview-image.js` reads `drupalSettings.ispim.previewImages` / `previewImageSelectors` and live-swaps the previewed image (original vs. a given `imageStyleId`).

Config translation is enabled via `ispim.config_translation.yml`; install config seeds a default view/form display and `ispim.ispim_preview_image.settings`.
