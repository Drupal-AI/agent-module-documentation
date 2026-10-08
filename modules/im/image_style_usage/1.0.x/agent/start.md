<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image style usage — agent index

Report of **where each image style is used** (entity view displays + Views) and which are **unused**. Version **1.0.1**. Core `^8 || ^9 || ^10`.

- Route `/admin/config/media/image-styles/usage` (`image_style_usage.controller`, `administer image styles`).
- `ImageStyleUsageController::usage()`. Read-only; `accessCheck(TRUE)` queries; escaped Link/table output. Sound.
