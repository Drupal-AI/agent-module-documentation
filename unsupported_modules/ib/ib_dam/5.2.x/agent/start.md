# IntelligenceBank DAM (ib_dam) — agent index

Base bridge module for the IntelligenceBank DAM platform (project `intelligencebank`, module
machine name `ib_dam`). Provides shared services, an asset model, and an AssetValidation plugin
type; the user-facing integration lives in the **submodules**. Needs real IB platform
credentials/SSO to actually talk to IntelligenceBank.

- **Global settings (`ib_dam.settings`), the config form, and the permission** →
  [configure/settings.md](configure/settings.md)
- **The AssetValidation plugin type (`@IbDamAssetValidation`) and how to add one** →
  [plugins/asset-validation.md](plugins/asset-validation.md)
- **Services & asset model (`ib_dam.api`, `ib_dam.downloader`, Asset/EmbedAsset/LocalAsset, formatters)** →
  [api/architecture.md](api/architecture.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Submodules (documented separately, nested under this dir's `modules/`):
- **ib_dam_media** — Media + Media Library integration (`ib_dam_embed` media source/type, asset browser).
- **ib_dam_wysiwyg** — deprecated legacy CKEditor filter (no-op in 5.x, removed in 6.0).

Key facts:
- Config object `ib_dam.settings` (schema keys: `debug`, `staging`, `allow_embedding`,
  `login_url`, `login_enable_browser_login`, `login_enable_custom_url`). **No config ships by default.**
- Config UI `/admin/config/services/ib_dam` (route `ib_dam.settings_form`), permission
  `administer intelligencebank configuration`.
- Plugin type: `Plugin/IbDam/AssetValidation`, annotation `@IbDamAssetValidation`, manager
  `plugin.manager.ib_dam.asset_validation` (built-in ids: `file`, `resource`, `api`).
- Field formatter `ib_dam_embed` (extends core Link formatter); theme hook `ib_dam_embed_playable_resource`.
