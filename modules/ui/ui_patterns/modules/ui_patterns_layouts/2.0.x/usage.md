<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes every SDC component as a layout plugin, so a component's slots become layout regions in Layout Builder or Display Suite. Part of UI Patterns 2.x.

---

This submodule of `ui_patterns` derives a layout plugin for each discovered SDC component (layout plugin base id `ui_patterns`, deriver appends the component id → `ui_patterns:<theme_or_module>:<component>`). When used as a layout — in Layout Builder sections, entity view displays, or Display Suite — the component's **slots** are offered as the layout's regions, and its **props** are configurable in the layout settings form via Source plugins. It depends on core `layout_discovery`. Configuration is stored in the layout's `settings.ui_patterns` array with the same shape as the block and field-formatter surfaces. This lets a design system's structural components double as page layouts.

---

- Use a component as a Layout Builder section layout
- Map a component's slots to Layout Builder regions
- Configure component props (e.g. a variant/columns count) per section
- Build entity displays out of component-based layouts
- Provide a two/three-column component layout to site builders
- Reuse one structural component as the layout across content types
- Replace custom layout plugins with portable SDC components
- Use a component layout in Display Suite field grouping
- Keep layout markup in the design system rather than in Twig layout templates
- Feed a layout component prop from a token or entity field
- Offer editors a constrained set of component layouts for landing pages
- Standardize section structure across the site with one component set
- Place fields into a component's slots as Layout Builder regions
- Build a card-grid section whose structure comes from a component
- Configure a component layout variant per Layout Builder section
- Use a component layout in an entity view display without Layout Builder templates
- Provide a hero-with-sidebar layout sourced from a design-system component
- Keep responsive section behavior inside the component rather than the theme
