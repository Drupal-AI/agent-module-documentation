<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# custom_uuid — agent orientation

Adds an optional `custom_uuid` textfield to block_content and media **add** forms so editors can pin a specific UUID (for config-by-UUID references).

- Validation: parameterised `select()` uniqueness check (no SQLi) + `Uuid::isValid()` format check.
- Gated by existing create permissions; no own permissions/routes.
- Security: UUIDs are NOT used for access control here; requires trusted create permission. Sound.
- Read: `custom_uuid.module` (`custom_uuid_validate_uuid_exits_block_content` / `_media`).
