# Set up a Lottie media type

There is **no module settings form**. You configure everything with core Media config entities.

## 1. Create a media type using the Lottie source

- UI: *Structure → Media types → Add media type*, set **Media source = "Lottie file"**.
- The resulting config entity `media.type.<id>` has `source: lottie_file`.
- When you save, the source's `createSourceField()` creates a `file` source field limited to the
  `json` extension (`settings.file_extensions = 'json'`).

Config shape (`media.type.lottie`):

```yaml
source: lottie_file
source_configuration:
  source_field: field_media_lottie_file   # a file field, json only
```

The source field name matters: the formatter only applies to a field whose machine name contains
`field_media_lottie_file` (see `FileLottiePlayerFormatter::isApplicable()`), because plain JSON files
share a MIME type with other formats. Keep the auto-created field name.

## 2. Display: use the Lottie player formatter

The source's `prepareViewDisplay()` already sets the source field's formatter to
`file_lottie_player` (label visually hidden) on the default view display. To adjust it:

- UI: the media type's *Manage display* → source field → format **"Lottie player"** → gear for
  settings.
- Config: `core.entity_view_display.media.<type>.default` → `content.field_media_lottie_file.type:
  file_lottie_player` with settings (see the plugins doc for keys).

## 3. Metadata mappings (optional)

Map source metadata to fields on the media type: available attributes are `width`, `height`, `name`,
`version`, `frames` (plus core File attributes). E.g. map `name` to the media label so uploads are
auto-named from the animation's `nm` property.

## Install note

`media_entity_lottie_install()` copies `images/icons/lottie.png` into the site's media icon directory
(`media.settings.icon_base_uri`) for the default thumbnail — no action needed.
