# exif_orientation — agent start

Automatically rotates uploaded **JPEG/PNG** images to match their EXIF `Orientation` tag, at
upload time via `hook_file_presave()`. Requires PHP's EXIF extension (`exif_read_data`). No
config UI, no settings, no permissions, no image effect — it just works once enabled.

- How it works, requirements & caveats (zero config) → [configure/exif_orientation.md](configure/exif_orientation.md)
- Hooks it implements + reusable validator function → [api/exif_orientation.md](api/exif_orientation.md)
