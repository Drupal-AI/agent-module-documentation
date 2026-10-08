<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles Layout Builder adds the UI Styles selector to Layout Builder, so you can apply curated CSS classes to whole sections, to the regions inside a section, and to individual block components placed in a layout.

---

This submodule wires UI Styles into core Layout Builder. `FormLayoutBuilderConfigureSectionAlter`
adds `ui_styles_styles` selectors to the "Configure section" form: one for the **section**
itself and one per **region** the layout defines. Choices are stored in the `Section` object's
third-party settings under the `ui_styles` provider — `selected`/`extra` for the section and a
`regions` map keyed by region name (config schema `layout_builder.section.third_party.ui_styles`).
`FormLayoutBuilderBlockAlter` adds selectors to each block component's config form, stored on the
`SectionComponent` (`ui_styles_*` / `ui_styles_*_extra` keys). At render, an event subscriber
(`BlockComponentRenderArraySubscriber`), an `EntityViewAlter` hook and a `PreprocessBlock` handler
(plus `LayoutBuilderTrustedCallbacks` / `ElementInfoAlter`) inject the resulting classes onto the
section wrapper, region wrappers and block build arrays via `StylePluginManager::addClasses()`.
Sections/components live wherever Layout Builder stores them: overrides on an entity, or defaults
in `core.entity_view_display.<entity>.<bundle>.<mode>`.

---

- Add a background colour or full-width utility to a Layout Builder section.
- Apply a grid-gap or padding class to the regions inside a two-column section.
- Style an individual block component (card, shadow, rounded) inside a layout.
- Give a hero section a distinct background and spacing without a custom layout plugin.
- Apply alternating background colours to stacked sections on a landing page.
- Add responsive visibility classes to a section for mobile/desktop.
- Style each region of a multi-column section independently.
- Apply a "container" max-width class to a section wrapper.
- Add border or divider utilities between sections.
- Give a call-to-action block component an accent background.
- Apply text-alignment utilities per region.
- Use extra free-text classes for one-off section tweaks.
- Keep section/region styling in the layout config (defaults or overrides) for export.
- Build landing pages with consistent spacing utilities via Layout Builder.
- Apply a shadow/elevation utility to a featured block component.
- Style the block title separately from its content within a component.
- Reuse a design system's utility classes across all layouts.
- Apply a coloured left-border to a testimonial block component.
- Add rounded corners to media block components in a gallery section.
- Give an admin-configured default layout a branded look via section styles.
- Standardise vertical rhythm across sections with spacing styles.
- Highlight a promotional section with a gradient/background utility.
