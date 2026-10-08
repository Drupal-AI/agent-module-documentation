<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Alt Fallback — agent index

Fills **empty image `alt` attributes with the entity label** as fallback (accessibility). Depends on core
`system`, `views`, `image`, `media`. Config at `image_alt_fallback.settings`. Version **1.1.3**. Core
`^10||^11`.

Accessibility/display — supplies fallback alt at render (no data/access change). A label fallback beats
empty but isn't a substitute for meaningful alt — encourage proper alt too.
