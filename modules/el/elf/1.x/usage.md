<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Links Filter (elf) is a text-format filter that tags external and mailto links — adding CSS classes so a theme can mark them with an icon, add rel attributes, open them in a new tab, or expose an accessible "external link" label — and can optionally route external links through an internal redirect page.

---

Marking external links is a common editorial nicety: a small outbound-arrow icon, a `rel="noopener"`, a "you are leaving this site" behaviour. Doing it reliably means detecting, at render time, which links point off-site and adding a class the theme can style. ELF does this as part of the text format pipeline, so it applies to all filtered content without editors having to add anything by hand. It walks the rendered HTML with PHP's DOM extension, adds `elf-external` (or `elf-mailto`) plus a configurable icon class, and can also add `target="_blank"`, merge `rel` tokens (`nofollow`/`noopener`/`noreferrer`), and append a screen-reader-only label.

What counts as "external" is configurable: the module treats the site's own base URL — and any additional internal domains you list, with wildcard support — as internal, and flags everything else that Drupal considers an external URL. There is also an optional redirect mode that rewrites each external link to pass through an internal `/elf/redirect` endpoint before forwarding the browser onward, useful when you want outbound clicks to go through a single, themeable hand-off page.

The module settings page is admin-gated, and the per-format options (the `rel` tokens) live on the text format's filter settings. As a filter it is display-only: it changes how links render, not the stored content, so toggling it off restores the original markup on the next render.

---

- Add a CSS class to external links.
- Mark outbound links with an icon.
- Open external links in a new tab.
- Tag mailto links for styling.
- Apply link marking site-wide via a text format.
- Add `rel="nofollow"` to external links for SEO.
- Add `rel="noopener"` / `rel="noreferrer"` to external links.
- Route external clicks through an internal redirect page.
- Show a "leaving the site" hand-off for outbound links.
- Add an accessible "external link" label for screen readers.
- Treat additional internal domains as non-external.
- Use wildcard domain patterns to classify links.
- Keep link marking out of templates.
- Style outbound links consistently across content.
- Configure rel options per text format.
- Detect off-site links at render time.
- Apply to all filtered content automatically.
- Restrict module settings to administrators.
- Avoid editors tagging links by hand.
- Flag external links that wrap an image (`elf-img`).
- Override the icon CSS class to use a custom icon.
- Keep the stored content unchanged, only the render.
