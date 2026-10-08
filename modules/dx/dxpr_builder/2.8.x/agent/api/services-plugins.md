<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
# Services & plugins

## Services (`dxpr_builder.services.yml`)
- `dxpr_builder.service` (`Service\DxprBuilderService`) — core rendering/build service that
  produces the editor markup; uses the block & view handlers below.
- `dxpr_builder.license_service` (`Service\DxprBuilderLicenseService`, an event subscriber) —
  validates the DXPR license/JWT, decides `isBillableUser()`, syncs users with DXPR central
  storage, and backs the `_dxpr_builder_billable_user` access check.
- `dxpr_builder.key_service` (`Service\DxprBuilderKeyService`) — resolves the API key from
  config or a Key entity (`@?key.repository`, optional).
- `dxpr_builder.jwt_decoder` (`Service\DxprBuilderJWTDecoder`) — decodes the JWT.
- `dxpr_builder.content_lock` (`Service\ContentLock`) — DB-backed lock so two users don't edit
  the same content simultaneously.
- `dxpr_builder.handler.block` / `dxpr_builder.handler.view` / `dxpr_builder.profile_handler` —
  embed Drupal blocks/Views and resolve profile context inside builder content.
- `dxpr_builder.template_image_validator` — validates template preview images.
- Access checks: `access_check.dxpr_builder_profile.add`, `access_check.dxpr_builder_billable_user`.

## Plugins (implementations of core types — no new plugin type defined)
- Field formatter: `dxpr_builder_text` (see [../configure/builder-and-entities.md](../configure/builder-and-entities.md)).
- Blocks (`src/Plugin/Block/`): `DxprLicenseInfoBlock` (license/user info),
  `DxprBuilderUserRegisterBlock` (front-end register form), `WebformBlock` (+ `WebformBlockDeriver`,
  embed a Webform).
- Actions (`src/Plugin/Action/`): `AvowUser` / `DisavowUser` — include/exclude a user from DXPR
  billing (shipped as `system.action.dxpr_builder_avow_user` / `_disavow_user`).
- Views field (`src/Plugin/views/field/DxprBuilderUserField.php`) — expose DXPR user data in Views.
- Entity subclasses `Entity\Node` / `Entity\BlockContent` and a `Menu\MenuActiveTrailOverride`.

## No Drush
The module ships no Drush commands. Manage everything via config (`drush cget`/`cset`,
`drush config:*`) and the DXPR Studio UI.
