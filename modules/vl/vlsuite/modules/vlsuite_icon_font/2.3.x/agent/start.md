<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Icon Font (vlsuite_icon_font) — agent index

Submodule of **vlsuite**. **Icon font** vocabulary for the suite's components.
Version **2.3.3**. Core `^10.3 || ^11`. Depends on `vlsuite`.

Depended on by `vlsuite_utility_classes` and `vlsuite_bundle_field` — infrastructure, low in the
stack, not just a visible feature.

**Two design-time points:** an icon font renders as text (inherits colour and size, but is
invisible to a screen reader unless the markup gives an accessible name — `aria-hidden` for
decorative, a label for meaningful); and a font is one file, so a large set costs bandwidth for
icons nobody uses.