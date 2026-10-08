<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# imageapi_optimize_resmushit — agent start

Adds **one** image-optimize processor plugin, id **`resmushit`**, to the Image Optimize
(**imageapi_optimize**) pipeline system. It has no page or config entity of its own — you
place it inside an `imageapi_optimize_pipeline` config entity (config name
`imageapi_optimize.pipeline.<name>`), then attach that pipeline to image styles. Its only
setting is **`quality`** (integer 1–100, JPEG quality), stored per-instance as `data.quality`.
At runtime it POSTs each derivative to `http://api.resmush.it/ws.php` and overwrites the file
with the returned optimized image. Requires module **imageapi_optimize**; core `^8 || ^9 || ^10 || ^11`.
Installed release is `2.1.0-beta1` (**beta**). Admin UI:
**Admin → Config → Media → Image Optimize pipelines** (`/admin/config/media/imageapi-optimize-pipelines`).

> Actual optimization is a live call to the third-party reSmush.it API (needs network + the
> service up). Ground any "is it configured?" check on the **pipeline config** (processor
> present with the intended quality), not on a live optimize round-trip.

- The `resmushit` processor plugin (id, class, `quality`, runtime flow) → [plugins/plugins.md](plugins/plugins.md)
- Put it in a pipeline + set quality (UI / drush / config) → [configure/configure.md](configure/configure.md)
