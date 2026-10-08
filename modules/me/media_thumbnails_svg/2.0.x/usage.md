Media Thumbnails SVG is a plugin for the Media Thumbnails framework that rasterizes uploaded SVG media into PNG thumbnails, so vector media entities get real preview images.

---

The module provides a single `MediaThumbnail` plugin (`media_thumbnail_svg`) that handles the MIME types `image/svg` and `image/svg+xml`. When an SVG is uploaded to a media entity, the Media Thumbnails framework calls the plugin's `createThumbnail()`, which converts the SVG to a PNG using the best rasterizer available on the host, tried in order: **GraphicsMagick** (`gm convert`, best quality), then **ImageMagick** (`convert`), then the pure-PHP **GD + meyfa/php-svg** fallback (lowest quality, always available). The generated PNG becomes the media entity's `thumbnail` field value, which you can then place in Views or display modes and run through any image style. The module has **no configuration page of its own** — output width and background color are read from the parent Media Thumbnails settings (`media_thumbnails.settings`: `width`, `bgcolor_active`, `bgcolor_value`) at `/admin/config/media/thumbnails`. A `hook_requirements()` implementation reports which rasterizer was detected on the status report. There are no permissions, no routes, no Drush commands, and no config schema shipped by this module.

---

- Generate PNG preview thumbnails for SVG logos stored as media entities.
- Show a visual thumbnail for SVG icons in the Media Library instead of a generic file icon.
- Add the media `thumbnail` field to a Views listing of SVG media.
- Apply an image style (e.g. `thumbnail`, `medium`) to the rasterized SVG preview.
- Give editors a recognisable preview when picking SVGs from an entity reference field.
- Rasterize SVGs at a configured maximum width for consistent grid previews.
- Flatten transparent SVGs onto a solid background color for previews.
- Produce previews of vector illustrations for a decoupled front end via the thumbnail image.
- Enable SVG uploads on the core "document" media type and get thumbnails automatically.
- Use GraphicsMagick where installed for the highest-quality SVG rasterization.
- Fall back to ImageMagick on hosts without GraphicsMagick.
- Fall back to PHP GD when no CLI rasterizer is present, keeping basic SVGs working everywhere.
- Present SVG brand assets in a digital-asset-management style media grid.
- Create consistent card thumbnails for a mixed media library containing SVG and raster images.
- Show SVG thumbnails in admin content overviews that reference media.
- Check the status report to confirm which rasterizer (GM/IM/GD) is active on the site.
- Support both `image/svg` and `image/svg+xml` uploaded files.
- Keep original SVG media untouched while serving a raster preview separately.
- Standardise preview background color across all SVG thumbnails via one setting.
- Improve editorial UX where SVGs previously showed no image at all.
- Combine with responsive image styles to serve appropriately sized SVG previews.
- Regenerate SVG thumbnails after changing the width/background settings.
- Provide preview images for SVG media embedded in content.
- Add SVG previews to a media browser used inside CKEditor.
- Use the rasterized thumbnail as an open-graph/social preview source for vector art.
