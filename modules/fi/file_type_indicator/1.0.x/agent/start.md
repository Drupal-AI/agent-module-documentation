<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File type indicator — agent orientation

D9.4/D10 text-format filter. Single plugin: `src/Plugin/Filter/FileTypeIndicatorFilter.php`.

- Adds a CSS icon class to `<a>` links whose href extension matches the configured `file_types` (default `pdf,doc,zip`).
- Uses `Html::load()`/`Html::serialize()` and only calls `setAttribute('class', ...)`; attaches `file_type_indicator/icons_css`.
- Security: DOM-based, adds only a class attribute; no user-controlled markup injection. No findings.
