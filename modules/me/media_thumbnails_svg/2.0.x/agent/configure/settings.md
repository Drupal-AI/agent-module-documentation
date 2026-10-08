# Configure — output width & background

Media Thumbnails SVG has **no config UI or config object of its own** (`configure: null`,
no `config/` directory). It reads the shared settings of its parent module,
**Media Thumbnails**, config object `media_thumbnails.settings`, edited at
`/admin/config/media/thumbnails` (route provided by `media_thumbnails`).

Keys the SVG plugin consumes (with shipped defaults):

```yaml
# media_thumbnails.settings
width: 500              # integer; target thumbnail width in px (height keeps aspect ratio)
bgcolor_active: false   # boolean; when true, flatten onto bgcolor_value instead of transparent
bgcolor_value: '#eeeeee'  # string; hex color used when bgcolor_active is true
no_thumbnail_update: false  # (framework) do not recreate thumbnail on media update
allow_thumbnail_edit: false # (framework) allow manual thumbnail editing
```

Read / set via Drush:

```bash
drush cget media_thumbnails.settings                 # view all
drush cset media_thumbnails.settings width 300 -y    # 300px wide thumbnails
drush cset media_thumbnails.settings bgcolor_active 1 -y
drush cset media_thumbnails.settings bgcolor_value '#ffffff' -y
```

To actually get SVG thumbnails: enable a media type whose source field accepts the `svg`
extension (e.g. add `svg` to the core "document" media type's file field, or create a media
type), upload an SVG, and the framework invokes the `media_thumbnail_svg` plugin to build the
`thumbnail`. Changing width/background affects thumbnails generated **after** the change;
existing media may need their thumbnails regenerated (re-save the media / clear caches).
