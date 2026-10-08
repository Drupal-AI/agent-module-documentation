# Configure the ImageMagick toolkit

Select the active toolkit and its settings at `/admin/config/media/image-toolkit`
(route `system.image_toolkit_settings`). Choose **ImageMagick** as the toolkit, then
configure it. Stored in `imagemagick.settings` (defaults in `config/install`):

```yaml
quality: 75                 # output quality (JPEG/WEBP…)
binaries: 'imagemagick'     # package suite: 'imagemagick' or 'graphicsmagick'
imagemagick_version: 'v6'   # 'v6' | 'v7'
path_to_binaries: ''        # e.g. '/usr/bin/' — trailing slash required; empty = on $PATH
prepend: ''                 # string prepended to every command (e.g. 'nice -n 19')
log_warnings: true
debug: false                # log the exact CLI commands executed
advanced:
  density: 0
  colorspace: '0'
  profile: ''
  coalesce: false           # flatten animated GIF frames
image_formats:              # per-format enable + MIME mapping
  PNG:  { mime_type: image/png }
  JPEG: { mime_type: image/jpeg }
  WEBP: { mime_type: image/webp }
  AVIF: { mime_type: image/avif }
  TIFF: { mime_type: image/tiff, enabled: false }
  PDF:  { mime_type: application/pdf, enabled: false, identify_frames: '[0]' }
  # HEIC, PSD, BMP, SVG, ICO, … default disabled
```

## Notes
- Enabled formats gate which types Drupal will read/write; MIME mapping is validated against
  `sophron`. Enable e.g. `TIFF`/`PDF`/`HEIC` only if the installed binary supports them.
- `path_to_binaries` must include the trailing slash (`/usr/bin/` or
  `C:\Program Files\ImageMagick...\`). Leave empty if binaries are on `$PATH`.
- The toolkit form runs a **path check** confirming the binaries are found and reports the
  detected package/version.
- `hook_runtime_requirements()` (`src/Hook/ImagemagickHooks.php`) warns on the status report
  if rotate effects can't be supported.
- Turn on `debug` to log the literal `convert`/`identify` command lines for troubleshooting.
