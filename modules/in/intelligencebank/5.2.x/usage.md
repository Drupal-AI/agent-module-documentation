<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IntelligenceBank DAM (project `intelligencebank`, module machine name `ib_dam`) connects Drupal to the IntelligenceBank Digital Asset Management platform, letting editors browse the IB library in an embedded app and either download a copy of an asset into Drupal media/files or embed its public IB CDN link.

---

The parent `ib_dam` module supplies the plumbing: a settings form (`/admin/config/services/ib_dam`, config object `ib_dam.settings`) for the IB login URL, staging/beta mode, debug mode and whether public-CDN embedding is allowed; a Guzzle-based DAM HTTP client (`ib_dam.api`) and a downloader (`ib_dam.downloader`) that stream a selected asset and its thumbnail into an unmanaged local file; an asset model pipeline (`IbDamResourceModel` → `EmbedAsset`/`LocalAsset` → a pluggable storage handler) driven by the JSON the IB iframe app posts back; a `#type => ib_dam_app` render element that embeds the browser iframe; an `IbDamAssetValidation` plugin type (validators `file`, `resource`, `api`) that checks extensions, directories and embed permission before saving; and an `ib_dam_embed` field formatter for core `link` fields that renders an embedded asset (image/video/audio/link) inline. The two submodules provide the actual entry points: `ib_dam_media` wires the browser into the core Media Library as a media source and downloads/embeds into media entities, while `ib_dam_wysiwyg` is a now-deprecated CKEditor text-filter shim. One permission, `administer intelligencebank configuration`, guards configuration.

---

- Connect a Drupal site to an enterprise IntelligenceBank DAM account.
- Let editors browse the IntelligenceBank asset library from inside Drupal.
- Download a chosen DAM asset into Drupal's managed media/file storage.
- Embed a DAM asset by its public IntelligenceBank CDN link instead of copying it.
- Reuse governed, approved brand assets without re-uploading them to Drupal.
- Restrict who can configure the DAM bridge with a single admin permission.
- Point the connector at a custom IntelligenceBank platform URL or sub-domain.
- Enable SSO / browser login against the IntelligenceBank platform.
- Switch to the IntelligenceBank staging/beta browsing app for testing.
- Toggle whether public-CDN embedding is offered in addition to download.
- Render embedded DAM images with alt/title/width/height in a link field.
- Render embedded DAM video as a streaming iframe or a direct-link HTML5 player.
- Render embedded DAM audio inline.
- Map remote asset types to local media types (via `ib_dam_media`).
- Add the "Open IntelligenceBank Browser" button to the Media Library add form.
- Tune the DAM API request timeout with `intelligencebank_api_timeout` in settings.php.
- Log DAM operations to the dedicated `ib_dam` log channel for troubleshooting.
- Extend asset validation with a custom `IbDamAssetValidation` plugin.
- Fall back to a bundled logo thumbnail when an asset thumbnail cannot be fetched.
- Centralise digital-asset governance while still publishing through Drupal.
