<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Action / VBO plugins

The module ships core Action plugins so you can warm existing entities (e.g. from a
Views Bulk Operations list or `system.action.*` config). It does **not** define a plugin
*type*; these are ordinary `@Action` plugins.

| Plugin id | Class | `type` | What `execute()` does |
|---|---|---|---|
| `image_style_warmer_warmup_file` | `WarmupFile` | `file` | Calls `warmer->warmUp($file)` on each selected file. Access = `view` on the file. |
| `image_style_warmer_warmup_media` | `WarmupMedia` | `media` | Iterates the media entity's image fields and warms every referenced file. Access = `edit` on the media. |
| `image_style_warmer` (**deprecated**) | `ImageStyleWarmer` extends `WarmupFile` | `file` | Legacy alias; replace with `image_style_warmer_warmup_file`. |

Shipped action config entities:
- `system.action.image_style_warmer_warmup_file` (config/install, requires `file`).
- `system.action.image_style_warmer_warmup_media` (config/optional, installed only when
  `media` is enabled).

Because warming runs through `warmUp()`, the action respects the same `initial_image_styles` /
`queue_image_styles` split: selected files get initial styles at request end and queue styles
pushed to cron.

## Use from a View (VBO)

Add a bulk-operations field to a View of files or media, expose the "Warmup image styles of
files/media entities" action, select rows, and run. This is the UI equivalent of calling
`warmUp()` on each selected entity.
