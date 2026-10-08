Bynder integrates the Bynder cloud Digital Asset Management (DAM) system with Drupal core Media, letting editors search, upload, and reuse Bynder-hosted assets as media entities and keeping their metadata, derivatives, and usage in sync over the Bynder API.

---

The module provides a core `MediaSource` plugin (`bynder`) whose media entities store a Bynder asset ID
and a large JSON metadata blob, and two Entity Browser widgets — **Bynder search** (`bynder_search`) and
**Bynder upload** (`bynder_upload`) — for picking existing assets or uploading new ones to Bynder from the
media library. All API traffic goes through the `bynder_api` service, a thin wrapper over the official
`bynder/bynder-php-sdk` (`BynderClient`) that authenticates either with a **permanent token** (global,
server-to-server) or an **OAuth2** user token stored in the session; the `bynder` service adds higher-level
operations (metadata sync, usage). Configuration lives at *Configuration → Media → Bynder*
(`/admin/config/services/bynder`, `bynder.configuration_form`) where you enter the account domain, permanent
token, and optional OAuth client ID/secret, test the connection, choose the usage-restriction metaproperty,
and tune caching. Metaproperties, tags, and derivatives are cached (default 24h, refreshed on cron) to keep
the UI responsive. Field formatters render Bynder images (with derivative/transformation and responsive-image
support via the CompactView library), documents, and video; a metadata field type/widget/formatter surfaces
the remote metadata; and an `update_metadata` action plus a batch on the config form refresh local copies.
Optional submodules add Select2 tag widgets (`bynder_select2`), Amazon SNS push updates (`bynder_sns`), and
Entity-Usage-driven asset usage tracking back to Bynder (`bynder_usage`), plus demo and Lightning config
packages. Two permissions: `administer bynder configuration` (restricted) and `view bynder media usage`.

---

- Let editors browse and insert existing Bynder assets into content via an Entity Browser search widget.
- Upload new assets from Drupal straight into Bynder (with brand, tags, and metaproperties) via the upload widget.
- Create a "Bynder" media type that references remote DAM assets instead of storing files locally.
- Authenticate to Bynder with a global permanent token for server-side asset access.
- Authenticate individual users with OAuth2 so uploads are attributed to their Bynder account.
- Render a Bynder image with a chosen derivative (mini/webimage/thul or a custom one) as the thumbnail.
- Serve responsive images from Bynder using derivative-based `srcset` and the CompactView component.
- Apply user-selected Bynder transformations to displayed images when available.
- Display Bynder documents as download links and Bynder videos with a configurable HTML5 player.
- Show remote Bynder metadata (title, description, copyright, custom metaproperties) on a media entity.
- Keep local media metadata fresh via a scheduled cron sync at a configurable frequency.
- Batch-update local metadata for all Bynder media from the configuration form.
- Enforce usage restrictions (royalty-free / web / print) by mapping a Bynder metaproperty.
- Autocomplete Bynder tags in the search filter via the tag search endpoint.
- Cache metaproperties, derivatives, and tags to reduce API calls (configurable lifetime, cron refresh).
- Track where each Bynder asset is used on the site and report it back to Bynder (bynder_usage submodule).
- Receive near-real-time asset-change notifications from Bynder through Amazon SNS (bynder_sns submodule).
- Nicer multi-select tag/metaproperty widgets in the upload form using Select2 (bynder_select2 submodule).
- Link editors from a Bynder media edit form directly to the asset on Bynder for metadata edits.
- List all Bynder assets used on a given node via the "Bynder media usage" tab.
- Use remote image thumbnails (no local download) when Remote Stream Wrapper is installed.
- Alter the Bynder search query programmatically with `hook_bynder_search_query_alter()`.
- React to metadata refreshes with `hook_bynder_media_update_alter()` to derive extra fields.
- Test the Bynder API connection from the admin form before saving credentials.
