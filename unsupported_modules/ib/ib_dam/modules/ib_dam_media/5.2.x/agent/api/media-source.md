# ib_dam_media: media source, matcher, storage

## Media source `ib_dam_embed` (`IbDamEmbedField`)

`src/Plugin/media/Source/IbDamEmbedField.php`, a core `@MediaSource`:

- id `ib_dam_embed`, `allowed_field_types = {"link"}`, `media_library_add` form
  `MediaLibraryIbDamRemoteAssetAddForm`.
- `getMetadataAttributes()`: `resource_type`, `resource_title`, `resource_url`.
- `getMetadata()`: pulls from a transient `$media->original_item` (an `IbDamResourceModel`) when
  present, else from the source `link` field value; thumbnail defaults to the media icon base
  uri + the source's default thumbnail filename.
- `createSourceField()` labels the field "Embed Resource Url".

It is a normal core Media source plugin — reference it as `source: ib_dam_embed` on a media type.

## MediaTypeMatcher (`ib_dam_media.media_type_matcher`)

`src/MediaTypeMatcher.php` (args: `config.factory`, `file.mime_type.guesser`,
`entity_type.manager`). Resolves which local media type an IB asset maps to:

- `getSupportedSourceTypes()` — IB source asset types offered in the mapping form.
- `getSupportedMediaTypes($source_type)` — candidate local media types for a source type.
- `matchType($asset_type)` — returns the mapped media type id for an asset (per
  `ib_dam_media.settings:media_types`).

## MediaStorage (`AssetStorage`)

`src/AssetStorage/MediaStorage.php` implements the base module's `AssetStorageInterface`. It is
the concrete storage handler that turns a saved `Asset`/`EmbedAsset` into a `media` entity of
the matched type (used by the browser add flow and the ib_dam_wysiwyg migration). Storage-type
ids are built as `MediaStorage::class . ':' . <source_type> . ':' . <media_type_id>`.

## Exceptions

`src/Exceptions/` — `MediaStorageUnableSaveMediaItem`, `MediaTypeMatcherBadMediaTypeMatch`,
`MediaTypeMatcherBadMediaTypes`.
