# Font Awesome icon media source

Plugin `\Drupal\fontawesome_media\Plugin\media\Source\FontAwesomeIconMedia`
(`@MediaSource id = "font_awesome_icon"`), a core `MediaSourceBase` wrapping a
`fontawesome_icon` field.

## Set up
1. Add a new **Media type** (Admin → Structure → Media types) and choose media source
   **Font Awesome Icon**.
2. The source stores its value in a `fontawesome_icon` source field and exposes a **Title**
   metadata attribute.
3. Editors add items with the media-library add form
   (`\Drupal\fontawesome_media\Form\FontawesomeMediaAddForm`), then reference the media
   anywhere (fields, media library, CKEditor embeds).

`allowed_field_types = {"fontawesome_icon"}`; thumbnails handled via the `svg_image`
dependency.
