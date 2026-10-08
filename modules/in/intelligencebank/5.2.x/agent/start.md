<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IntelligenceBank DAM (intelligencebank / machine name `ib_dam`) — agent index

Bridges the **IntelligenceBank** Digital Asset Management platform into Drupal. Editors browse the
IB library in an embedded iframe app, then either **download** a copy of the selected asset into
Drupal's file/media storage or **embed** its public IB CDN link. The parent module `ib_dam` supplies
the DAM API HTTP client, the asset/download pipeline, the iframe browser form element, the login/mode
configuration, and a `link`-field formatter. Two submodules add the entry points.

Version **5.2.3**. Core `^10.3 || ^11`. Project machine name `intelligencebank`; the parent module
machine name is **`ib_dam`**. No non-core hard dependencies at the parent level (the submodules add
`media`/`media_library`/`filter`).

- **Global settings (login URL, staging/beta, debug, allow embedding)** → [configure/settings.md](configure/settings.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)
- **Services: DAM API client, downloader, the asset model & save pipeline** → [api/services.md](api/services.md)
- **The `IbDamAssetValidation` plugin type + built-in validators** → [plugins/asset-validation.md](plugins/asset-validation.md)
- **The `ib_dam_embed` field formatter, the `ib_dam_app` render element, theme + libraries** → [fields/embed-formatter.md](fields/embed-formatter.md)

Submodules (documented separately):
- **`ib_dam_media`** → `../../modules/ib_dam_media/5.2.x/agent/start.md` — media source, the asset browser form/route, media-type mapping.
- **`ib_dam_wysiwyg`** → `../../modules/ib_dam_wysiwyg/5.2.x/agent/start.md` — legacy CKEditor filter (deprecated no-op).

Key facts:
- Config object `ib_dam.settings` (schema `config/schema/ib_dam.schema.yml`): `debug`, `staging`,
  `allow_embedding`, `login_url`, `login_enable_browser_login`, `login_enable_custom_url`.
- Route `ib_dam.settings_form` → `/admin/config/services/ib_dam`; permission
  `administer intelligencebank configuration`.
- Services: `ib_dam.api` (`Drupal\ib_dam\IbDamApi`), `ib_dam.downloader` (`Drupal\ib_dam\Downloader`),
  `plugin.manager.ib_dam.asset_validation`, `logger.channel.ib_dam` (log channel `ib_dam`).
- Field formatter plugin id `ib_dam_embed` (for core `link` fields, extends core `LinkFormatter`).
- Render element `#type => ib_dam_app` (`Drupal\ib_dam\Element\IbIframeApp`); theme hook
  `ib_dam_embed_playable_resource`; libraries `ib_dam/browser`, `ib_dam/ckeditor`, `ib_dam/resizer.iframe`.
- Plugin type: `IbDamAssetValidation` annotation, namespace `Plugin/IbDam/AssetValidation`, base
  `AssetValidationBase`; built-in plugins `file`, `resource`, `api`.
- Settings overrides (settings.php): `intelligencebank_api_timeout` (default 120s),
  `intelligencebank_is_test_mode` (default FALSE).
