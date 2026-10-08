# Enable the /document/{id} redirect

There is no module settings form. The feature is a per-media-type toggle plus a fixed route.

## Turn it on for a media type (UI)
*Structure → Media types → (a file-source type) → Edit* → check
**"Expose access to file via path /document/[id]"** → Save. The checkbox only appears when the media
type's source is a core **File** source (`media_entity_file_redirect.module`,
`hook_form_media_type_edit_form_alter`).

## Where it is stored
Third-party setting on the media type config entity:
```
media.type.<type>.third_party.media_entity_file_redirect.enabled: true
```
Schema: `config/schema/media_entity_file_redirect.schema.yml`
(`media.type.*.third_party.media_entity_file_redirect`). Set via drush:
```
drush cset media.type.document third_party_settings.media_entity_file_redirect.enabled true
```

## The route
`media_entity_file_redirect.routing.yml`:
```
path: /document/{media}          # {media} = \d+
_controller: MediaEntityFileRedirectController::redirectToFile
_entity_access: media.view       # access == view access on the media entity
```

## Controller behavior (`src/Controller/MediaEntityFileRedirectController.php`)
1. Load the media type; require its source `instanceof \Drupal\media\Plugin\media\Source\File`.
2. Require the type's `enabled` third-party setting to be TRUE.
3. Read the file id from `getSource()->getSourceFieldValue($media)`, load the file.
4. Return a `CacheableRedirectResponse` to `file_url_generator->generateAbsoluteString($fileUri)`
   (built inside a `RenderContext` to capture bubbleable cache metadata), varying by `url.site` and
   depending on the media type, media, and file cache tags.
5. Any failed check throws `NotFoundHttpException` (404).

Notes:
- The redirect URL is derived from the file's own URI, not from any request input.
- Access is only `media.view`; for private-scheme files the eventual file download still passes
  through core's file access system.
