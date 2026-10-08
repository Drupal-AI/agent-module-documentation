<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Civic Accessibility Toolbar adds a placeable block with front-end buttons that let visitors resize page text (100%/125%/150%) and switch color-contrast themes (normal/blue/high-visibility/soft), remembering each choice in a cookie.

---

The module provides a single Block plugin, `accessibility_toolbar_block`, whose block-config form has
four settings: show the text-resize controls, show the color-contrast controls, and an optional label for
each group. `build()` renders the `block__accessibility_toolbar` theme hook (template
`block--accessibility_toolbar.html.twig`) and attaches the
`civic_accessibility_toolbar/civic_accessibility_toolbar.accessibility_toolbar` library (jQuery + CSS).
The template outputs buttons carrying `data-accessibility-feature` (`fontSize` or `colorContrast`) and
`data-accessibility-unit` attributes. The JS (`assets/js/accessibility_toolbar.js`) handles clicks:
for font size it toggles `font__1` / `font__125` / `font__15` classes on `<html>`; for contrast it
toggles `theme__blue` / `theme__hivis` / `theme__soft` classes on `<body>`; each choice is written to a
`SameSite=Strict` cookie (`fontSize` / `colorContrast`, 365-day) and re-applied on the next page load.
The shipped CSS scales `rem`-based font sizes and defines the contrast themes, so **your theme must use
`rem`/`em` units** for text resizing to take effect. There is no global settings page (`configure`
null), no permissions, no services, and no config schema — all configuration lives in the block
instance. Customise the look by overriding the Twig template and the CSS classes in your own theme.

---

- Give site visitors a front-end text-resize control (100% / 125% / 150%).
- Offer color-contrast theme switching (normal, blue, high-visibility, soft) for low-vision users.
- Place the accessibility controls in a header, sidebar, or footer region via Block Layout.
- Show only the text-resize controls (hide contrast) for a simpler widget.
- Show only the contrast controls (hide text resize).
- Add custom labels (e.g. "Text size", "Contrast") next to each control group.
- Remember a visitor's chosen font size across pages using a functional cookie.
- Remember a visitor's chosen contrast theme across pages using a functional cookie.
- Improve WCAG conformance by providing user-controllable text scaling and contrast.
- Provide a lightweight, dependency-free (core jQuery only) accessibility widget.
- Restrict the toolbar's visibility with core Block visibility conditions (paths, roles, content types).
- Style the contrast themes to match brand guidelines by overriding `theme__*` CSS.
- Restyle or re-order the buttons by copying `block--accessibility_toolbar.html.twig` into a theme.
- Support public-sector / civic sites that must meet accessibility regulations.
- Let users increase readability without browser zoom affecting layout, when the theme uses rem/em.
- Add a "high visibility" mode toggle for users who need maximum contrast.
- Provide a "soft" reduced-contrast theme for light-sensitivity users.
- Classify the toolbar cookies as functional/necessary in a cookie-consent tool.
- Ship a consistent accessibility toolbar across multiple sites/themes.
- Combine with a rem-based design system so the resize buttons scale the whole UI.
