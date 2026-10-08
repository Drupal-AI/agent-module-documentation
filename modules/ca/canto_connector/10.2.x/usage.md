<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canto Connector

## What it is / when to use

- Connects Drupal to the Canto DAM ("Canto Flight") so editors can browse and insert Canto assets into rich-text (CKEditor) fields.
- Internal module machine name is `connector_canto` (project/directory is `canto_connector`).
- Use when your organisation stores images/assets in Canto and wants them available in the WYSIWYG.

---

## Install & configure

- Depends on core `editor`; ships a CKEditor 5 plugin and JS.
- Configure the Canto environment at `/admin/config/search/connector_canto` (route `connector_canto.admin_settings_form`, permission `administer site configuration`).
- Select the Canto region/domain (canto.com, canto.global, canto.de, ca/au variants).
- OAuth access tokens obtained in-browser are stored per user in the `canto_oauth_domain` table.
- Permission `administer connector_canto` is declared for module administration.

---

## Usage & API notes

- The CKEditor dialog route `/connector_canto/dialog/image` (`CantoConnectorDialog`) lets an editor pick assets; the selected asset URLs come back in a `cantofid` form value.
- On submit, the server fetches each chosen URL with `system_retrieve_file()` into `public://<filename>` and creates a File + Media entity.
- Token save/delete controllers (`/connector_canto/save_access_token`, `/connector_canto/delete_access_token`) use `access content` and write/delete rows for the current user's uid.
- `OAuthConnector::obtainUserInfo()` calls the Canto API over cURL; TLS verification is left at cURL defaults (the disable-verify options are commented out) — TLS is NOT disabled.
- Access tokens are validated by calling the Canto `/api/v1/user` endpoint; invalid tokens are purged.
- Database access uses parameterised query builders (insert/select/delete) — no raw SQL.
- Retrieved assets are stored as public files and optionally promoted to Media entities.
- The environment defaults to `canto.com` when unset.
- Supported image extensions come from the core image factory.
- Config object is `connector_canto.settings` (`env`).
- The `.install` creates the `canto_oauth_domain` schema.
- Editors need a valid Canto login/token for the picker to populate.
- Asset size is client-side limited to 128 MB per the dialog notice.
- Frontend build tooling (webpack/package.json) is included for the CKEditor plugin.
