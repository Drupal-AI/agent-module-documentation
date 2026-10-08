# Media source, asset browser & storage

## Media source plugin `ib_dam_embed`

`Drupal\ib_dam_media\Plugin\media\Source\IbDamEmbedField` (`@MediaSource id = "ib_dam_embed"`,
`allowed_field_types = {"link"}`). Exposes metadata attributes `resource_type`, `resource_title`,
`resource_url`; the source field is created labelled "Embed Resource Url". Its `media_library_add`
form is `MediaLibraryIbDamRemoteAssetAddForm`, which just renders the "Open IntelligenceBank DAM
browser" button (a modal link to the browser route carrying the current `MediaLibraryState`).

Shipped config: media type **`ib_dam_embed`** with source field `field_media_ib_dam_embed`
(`config/install/`), plus optional entity form/view displays (`config/optional/`).

## Entry point (`ib_dam_media.module`)

`ib_dam_media_form_media_library_add_form_upload_alter()` adds the "Open IntelligenceBank Browser"
button (AJAX modal, 75% width) to the Media Library upload tab, passing the current
`media_library_state`. `ib_dam_media_preprocess_links__media_library_menu()` hides the embed menu item
when the parent's `allow_embedding` is off.

## Asset browser form

Route `id_dam_media.asset_browser_form` → **`/ib-dam-browser`**, form
`Drupal\ib_dam_media\Form\MediaLibraryIbDamBrowserForm` (form id `ib_dam_browser_form`).

- `buildForm()` first calls `MediaLibraryState::fromRequest($request)` — this **requires the core
  Media Library signed state** (opener, allowed types, and a valid `hash`) on the request, so the form
  only builds inside a legitimately-opened media library session. It then renders the parent's
  `#type => ib_dam_app` iframe element, seeding `#file_extensions` (from the field's allowed media
  types via `MediaTypeMatcher::getAllowedFileExtensions()`) and `#allow_embed`.
- Two-step flow: **process** (user picks assets in the iframe; the JSON is posted back in the element's
  hidden `response_items`) → **configure** (for embed assets, a settings form from the matching
  `AssetFormatter`; downloadable assets skip straight through).
- `validateForm()` builds assets from the response items (`buildAsset()` → `IbDamResourceModel` →
  `Asset::createFromSource`), runs the `file` + `resource` validators
  (`validateFileExtensions` against the configured extensions, `validateFileDirectory` against the
  upload location, `validateIsAllowedResourceType`), then `validateAndSaveAssets()`.
- `validateAndSaveAssets()` calls each asset's `saveAttachments($downloader, $uploadLocation)` — which
  triggers the parent Downloader to fetch the file/thumbnail — applies embed display overrides
  (`remote_url`, width/height/alt/title) from the settings step, saves the asset (creating the `media`
  entity via `MediaStorage`), attaches the thumbnail, and returns the new media to the Media Library
  selection via AJAX (`UpdateSelectionCommand` + re-open modal). Debug logging of the model runs only
  when `debug` is on **and** the current user holds `administer intelligencebank configuration`.

## MediaStorage (`AssetStorage/MediaStorage.php`)

Storage handler keyed `MediaStorage:<source_type>:<media_type_id>`. `createStorage()` builds a `Media`
entity of the mapped bundle, pre-filling the source field via a per-type driver:
`imageDriver` (target_id/alt/title), `fileDriver` (target_id/description), or `embedDriver`
(link `uri` + `options.attributes.ib_dam` = `asset_type`, `filemimetype`, `extra` display settings).
The IB `IbDamResourceModel` is stashed on `original_item` for the source plugin's metadata.

## MediaTypeMatcher (`ib_dam_media.media_type_matcher`)

Maps between IB source types and local media types using `ib_dam_media.settings` `media_types` plus a
MIME-guesser. Key methods: `matchType()`, `getSupportedSourceTypes()`, `getSupportedMediaTypes()`,
`getAllowedFileExtensions()` (the extension allowlist enforced on downloads).

Exceptions: `MediaStorageUnableSaveMediaItem`, `MediaTypeMatcherBadMediaType{Match,s}`.
