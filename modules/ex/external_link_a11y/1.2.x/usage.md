<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a link-field formatter and a WYSIWYG text-format filter that add `target="_blank"` and accessibility cues to external links.

---

Accessible external link formatter and filter (`external_link_a11y`) helps external links open in a new tab in an accessible way. It ships two plugins that both build on core Link: a field formatter (`external_link_a11y`, extending core's `LinkFormatter`) used on Link fields via Manage display, and a text-format filter (`external_link_a11y`) used on rich-text formats. A link is treated as in scope when its `href` is an external URL, or (filter only) when it already carries `target="_blank"`. For in-scope links the plugins can add `target="_blank"` to links that do not already define a target, append a visually-hidden "Open in new window" span plus a matching `title` attribute for screen-reader users, add configured values to the anchor's `rel` attribute, add CSS classes, and (filter only) append a custom HTML suffix. The module has no settings page, routes, permissions, services or entities of its own; all behaviour is configured per view-display (formatter) and per text format (filter), and it depends only on core Link.

---

- Add `target="_blank"` to external links on a Link field's display output.
- Add `target="_blank"` to external links inside WYSIWYG/body content via a text-format filter.
- Announce "Open in new window" to screen-reader users with a visually-hidden span (`visually-hidden sr-only`).
- Add a `title` attribute of the form "<link text> (Open in new window)" to new-tab links.
- Detect external links automatically by inspecting the `href` (via core `UrlHelper::isExternal`).
- Treat links that already have `target="_blank"` as in scope (filter option `target_blank`).
- Keep the accessibility enhancements without forcing a new tab by disabling `add_target_blank`.
- Add `noopener` to the anchor's `rel` attribute for in-scope links (option `rel_noopener`).
- Add `noreferrer` to the anchor's `rel` attribute for in-scope links (option `rel_noreferrer`).
- Add one or more space-separated CSS classes to processed external links for custom styling.
- Append a custom HTML suffix inside the link element (filter only, `html_suffix`).
- Use it on Link fields by choosing the "Link (target blank when external a11y)" formatter on Manage display.
- Use it on body/rich text by enabling the "Accessible external link filter" on a text format.
- Configure the formatter and filter independently, since they store settings in different config objects.
- Leave `title` attributes that authors already set untouched (only empty titles are filled).
- Leave links that already define a `target` untouched (no target is overwritten).
- Standardise external-link handling across content types without editing each link by hand.
- Improve WCAG conformance for links that change context by opening in a new tab.
- Combine with core Link's existing display options (the formatter extends core's Link formatter).
- Apply the treatment site-wide by enabling the filter on the default rich-text format used by editors.
