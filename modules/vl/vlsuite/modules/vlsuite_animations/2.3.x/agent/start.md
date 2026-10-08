<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Animations (vlsuite_animations) — agent index

Submodule of **vlsuite**. Entrance and scroll **animations** for blocks, sections and layouts.
Version **2.3.3**. Core `^10.3 || ^11`. Depends on `vlsuite`.
`vlsuite_block` and `vlsuite_layout` both depend on it.

**Accessibility is the thing to verify, every time.** `prefers-reduced-motion` is a statement that
motion causes problems — vestibular disorders make it disabling, not annoying. Check what the
shipped CSS does with that media query; add it in the theme if it does nothing.

Second: **accumulation**. Animation on one hero is design; on every block it is a page that fights
the reader. Decide whether convention or a restricted setting controls that before editors find
it.