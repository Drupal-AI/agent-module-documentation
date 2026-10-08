<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ib_dam_media is the Media-integration submodule of intelligencebank: it plugs the IntelligenceBank asset browser into Drupal's core Media Library so editors can turn a browsed DAM asset into a media entity, either by downloading a local copy or by storing the asset's public IntelligenceBank CDN link.

---

It adds an "Open IntelligenceBank Browser" button to the Media Library add form and provides a media source plugin (`ib_dam_embed`, for core `link` fields) plus a shipped "IntelligenceBank Embed" media type. A configuration form at `/admin/config/services/ib_dam/media` (config object `ib_dam_media.settings`) sets the download upload location (default `public://intelligencebank`) and maps each remote asset source type (image, video, audio, file, embed) to a local media type. When an editor selects assets in the embedded IB app, the browser form (`/ib-dam-browser`, gated by the core Media Library signed request state) validates them — file-extension allowlist for downloads, embed-allowed check for CDN links — downloads the file and thumbnail through the parent module's DAM API/downloader, and creates the mapped `media` entity via its `MediaStorage` handler, handing the new media back to the Media Library selection. It relies on the parent `ib_dam` for the API client, downloader, asset model and validators, and on the parent's `administer intelligencebank configuration` permission for its config forms.

---

- Add IntelligenceBank DAM assets through the core Media Library UI.
- Download a DAM asset into a local Drupal media entity.
- Store a DAM asset as a public IntelligenceBank CDN embed instead of copying it.
- Provide an "IntelligenceBank Embed" media type out of the box.
- Add a media source (`ib_dam_embed`) for embedding IB public links in link fields.
- Map remote asset types to specific local media types.
- Set where downloaded copies are stored (upload location).
- Restrict imports to configured, allowed file extensions per media type.
- Only offer embedding when the parent's "allow embedding" setting is on.
- Add the IntelligenceBank browser button to the media add form.
- Return newly created media straight into the Media Library selection.
- Generate media thumbnails from the DAM asset (with a bundled fallback).
- Keep DAM asset metadata (type, MIME, display settings) on the embed field.
- Reuse governed DAM assets as first-class Drupal media.
- Bulk-select several DAM assets in one browse session.
- Wire DAM assets into any entity reference / media field.
- Show a helpful error when no target media types or extensions are configured.
- Drive embed display (alt/title/width/height) from the configure step.
- Migrate legacy embed field data via the module's update hooks.
- Centralise digital-asset management while publishing through Drupal media.
