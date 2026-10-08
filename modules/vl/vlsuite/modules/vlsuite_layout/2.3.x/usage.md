<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Layout supplies the section layouts — the column arrangements and containers editors choose when adding a section in Layout Builder.

---

Core ships a handful of layouts and most sites need more: a full-bleed band, an asymmetric two-column, a container with a background image, a section that becomes a slider. This submodule provides VLSuite's set through Layout Discovery, with per-section configuration for the things that make a layout usable — background media (hence the `media_library_form_element` dependency), utility classes, animation and slider behaviour.

That per-section configuration is the difference between a layout library and a theme. A layout that can take a background image and a set of spacing classes covers a dozen designs; one that cannot needs a new plugin per variation, and the list grows until editors cannot find anything.

The nested `vlsuite_layout_tabs` submodule adds tabbed sections. Note also that `vlsuite_layout_builder` is a separate submodule covering the Layout Builder UI itself — this one is the layouts, that one is the editing experience around them.

---

- Add a full-bleed section to a page.
- Build an asymmetric two-column section.
- Give a section a background image.
- Apply utility classes to a section.
- Animate a section on scroll.
- Turn a section into a slider.
- Choose a layout when adding a section.
- Configure spacing per section.
- Avoid a new layout plugin per design variation.
- Keep the layout list short enough to use.
- Add tabbed sections with the nested submodule.
- Select background media from the media library.
- Theme a layout with the site's CSS.
- Reuse layouts across content types.
- Standardise section structure sitewide.
- Extend the set with a custom layout.