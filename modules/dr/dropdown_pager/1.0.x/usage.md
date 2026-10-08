<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dropdown Pager adds an accessible dropdown-based pager option to Drupal Views, replacing the standard row of numbered page links with a compact dropdown button.

---

Dropdown Pager provides a Views pager plugin (id `dropdown`, label "Paged output, dropdown pager") that renders pagination as a compact button showing the current position (for example "5 / 6") plus First / Previous / Next / Last controls, with the page list presented in an accessible dropdown (a `role="listbox"` widget, not a native `<select>`). It is built on core's `SqlBase` pager, so paging behaviour and the View's query are unchanged — only the pager's presentation differs. The widget is WCAG-oriented: ARIA labelling, full keyboard navigation, and an optional numeric search field to jump straight to a page. Button text, screen-reader label and per-page link text are customizable via placeholder templates, and the markup is fully themeable through `views-dropdown-pager.html.twig`. It depends only on core Views, has no settings page (configure it per View under Pager settings), and does not change which results appear or who can see them — the View's own access and filters apply as before.

---

- Replace a View's numbered pager with a compact dropdown button.
- Save horizontal space on listings that have many pages.
- Provide an accessible, keyboard-navigable pager (WCAG-oriented).
- Let visitors jump to a specific page via an optional numeric search field.
- Show the current position on the button (e.g. "5 / 6").
- Keep First / Previous / Next / Last navigation controls.
- Customize the dropdown button text with a placeholder template.
- Customize the hidden screen-reader button label template.
- Customize the per-page link text template.
- Control how many page links are visible in the dropdown (quantity).
- Rename the First and Last link labels.
- Set the pager's aria-label (navigation title).
- Apply the pager to any View display (page, block, attachment, etc.).
- Configure the pager entirely from the Views UI, no separate admin page.
- Theme the pager markup by overriding `views-dropdown-pager.html.twig`.
- Restyle it with the shipped `css/dropdown-pager.css` (CSS custom properties).
- Use it on content, media, user or custom-entity listings built with Views.
- Improve pager UX on mobile / narrow layouts.
- Keep the View's results, filters and access completely unchanged.
- Combine with items-per-page and offset options from the standard Views pager.
- Work under AJAX-enabled Views (behavior re-attaches after AJAX page loads).
