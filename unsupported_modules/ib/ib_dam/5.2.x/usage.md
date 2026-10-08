IntelligenceBank DAM (machine name `ib_dam`, project `intelligencebank`) bridges Drupal to the IntelligenceBank digital-asset-management platform, letting editors import assets into Drupal or embed public CDN links to them from the Media Library and CKEditor.

---

The base `ib_dam` module provides the shared plumbing: a global settings form (`ib_dam.settings`) at `/admin/config/services/ib_dam` for debug/staging flags, an "allow embedding" toggle, and default login/Platform-URL values (including browser/SSO login); an `IbDamApi` service that fetches remote resources from the IntelligenceBank API using a session id (`sid`) header; a `Downloader` service; an internal asset object model (`Asset`, `EmbedAsset`, `LocalAsset`, `IbDamResourceModel`) with pluggable `AssetFormatter`, `AssetStorage`, and an **AssetValidation plugin type** (`Plugin/IbDam/AssetValidation`, annotation `@IbDamAssetValidation`, manager `plugin.manager.ib_dam.asset_validation`); a `link`-based field formatter (`ib_dam_embed`), a render element/iframe app for the browser UI, and a theme hook for playable embeds. It ships no default config and defines one permission, `administer intelligencebank configuration`. On its own `ib_dam` does little user-visible work — you enable a submodule for the actual integration surface: **`ib_dam_media`** (Media + Media Library: an `ib_dam_embed` media source/type and an in-modal IntelligenceBank asset browser) or the deprecated **`ib_dam_wysiwyg`** (legacy CKEditor filter). Talking to IntelligenceBank requires real platform credentials/SSO configured against your IB account.

---

- Connect a Drupal site to an IntelligenceBank DAM account as the asset source of truth.
- Import IntelligenceBank assets into Drupal's local media storage.
- Embed a public IntelligenceBank CDN link to an asset instead of copying the file.
- Let editors browse and pick IB assets inside the core Media Library modal (via ib_dam_media).
- Configure a default IntelligenceBank Platform URL for all editors.
- Enable browser-based (SSO) login to IntelligenceBank for editors.
- Allow a custom per-site Platform URL / sub-domain for login.
- Turn asset embedding on or off site-wide with the "allow embedding" setting.
- Turn on debug logging to troubleshoot IB API calls.
- Switch to the staging/beta connector browsing interface.
- Validate imported assets by file extension before saving them locally.
- Restrict which IB source/resource types are allowed via asset validation plugins.
- Add a custom asset validation plugin by implementing `@IbDamAssetValidation`.
- Format an embedded IB asset field with the `ib_dam_embed` link formatter.
- Render playable IB audio/video embeds via the module's theme hook.
- Download an IB resource server-side through the `IbDamApi`/`Downloader` services.
- Map IntelligenceBank source types to local media types (with ib_dam_media).
- Restrict IB configuration to trusted admins via the `administer intelligencebank configuration` permission.
- Store the IB session id and fetch protected resources with the `sid` header.
- Provide a central DAM so multiple Drupal sites reuse the same brand assets.
- Keep large binary assets off Drupal by embedding CDN links.
- Migrate legacy inline IB JSON markup to `<drupal-media>` tags (ib_dam_wysiwyg update path).
- Extend asset formatting for new resource types via the AssetFormatter manager.
- Tune the IB API HTTP timeout via the `intelligencebank_api_timeout` setting.
