<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Kontainer

## 1. Configure the connection
At **Admin → Configuration → Media → Kontainer** (`/admin/config/media/kontainer`):
- Enter the **Kontainer URL** (no trailing slash).
- Choose the **media source**: a non-CDN Kontainer media type (file field) or the **CDN** media type (URL field).
- For the CDN source, also enter the **CDN asset host** — CDN media cannot be saved until this is set (the status report warns while missing).
- Enter the **integration id** and **integration secret** issued by Kontainer.

## 2. Wire the usage callback
In Kontainer, register the integration URL `https://<site>/kontainer/api/file-usages`. Kontainer authenticates to it with an `Authorization: Bearer base64(id:secret)` header; `KontainerAuth` compares it to the configured id/secret with `hash_equals()` and grants a synthetic `kontainer_auth_role`. If either config value is empty the provider returns NULL (no anonymous bypass).

## 3. CDN image conversions (CDN source only)
Manage conversion entities at `/admin/structure/cdn-image-conversion`. Each stores a `template_id` and `format`; `generateCdnFormattedUrl()` builds `<base>.<format>?d=<template_id>`. Deleting a conversion resets any view display using it to the original image.

## 4. Entity usage tracking
At `/admin/config/entity-usage/settings` enable the **Kontainer Entity Reference** tracking plugin. Usage is tracked for assets referenced directly on nodes (paragraph nesting is followed); results are stored in state and served by `KontainerController::sendUsage()`.

## Import flow (reference)
The Media Library JS POSTs asset JSON to `/kontainer/create-media` with a CSRF token. `KontainerService::createEntities()` validates the type, calls `checkAccess()` (requires `create <media_type> media`), then either downloads the file server-side via `createFile()` into `public://Kontainer` or stores the CDN URL. Run `drush cex` afterwards to export the created media-type config.
