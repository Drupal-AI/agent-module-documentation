Bootstrap Horizontal Tabs provides a multi-value field type whose items (each a tab header + rich-text body) render as a set of Bootstrap nav tabs or pills, with the body content shown in the matching tab pane.

---

The module ships a Field API triad: a field type `bootstrap_horizontal_tabs` (columns `header` varchar, `body_value` text, `body_format` varchar), a matching widget (a plain-text **Tab Label** plus a `text_format` **Tab Body**), and a formatter that emits Bootstrap tab markup. Each field delta is one tab. The widget validates that tab headers are unique and core adds a NotBlank constraint requiring a header when a body is present. The formatter (`BootstrapHorizontalTabs`) builds `nav`/`nav-tabs` (or `nav-pills`) list markup with `tablist`/`tab`/`tabpanel` ARIA roles, unique transliterated ids per tab, and marks the first tab active; a single-item field renders as plain content with no tab chrome. It reads a site-wide **Bootstrap version** setting (`bootstrap_horizontal_tabs.settings:version`, default 5, set at `/admin/config/content/bootstrap-horizontal-tabs`) to choose between `data-toggle` (BS3/4) and `data-bs-toggle` (BS5) and the correct active/show classes. The formatter has per-display settings `tab_display` (tabs|pills) and `tab_orientation` (horizontal|vertical) and, for the tabs display, attaches a `deep-linking` JS library that activates and scrolls to a tab from the URL fragment. Rendering uses the `field__bootstrap_horizontal_tabs` theme hook (template `field--bootstrap-horizontal-tabs.html.twig`) with attributes exposed by `hook_preprocess_field()`. The module supplies **no Bootstrap CSS/JS itself** — the host theme must load Bootstrap. Depends on core `field` and `text`.

---

- Add a tabbed content field to a content type (e.g. product Description / Specs / Reviews tabs).
- Build an FAQ or documentation node where each tab is a topic with rich-text body.
- Render grouped content as Bootstrap **pills** instead of tabs via the formatter setting.
- Show tab headers stacked **vertically** (nav-stacked) beside the content.
- Provide editors a repeatable "label + WYSIWYG body" widget that becomes tabs on display.
- Use a chosen Bootstrap version (3, 4, or 5) to match the theme's markup conventions.
- Deep-link to a specific tab via a URL fragment so a shared link opens the right tab.
- Keep the first tab open by default with correct active/show classes per Bootstrap version.
- Fall back gracefully: a single tab renders as plain body content with no tab UI.
- Enforce unique tab headers so anchor ids and navigation stay consistent.
- Require a header whenever a tab body is filled in (core NotBlank constraint).
- Apply per-view-mode formatter settings (tabs vs pills, horizontal vs vertical) on different displays.
- Use different text formats per tab body (each item stores its own `body_format`).
- Build a "how it works" section with step tabs on a landing page.
- Present specifications, dimensions, and warranty as separate tabs on a product page.
- Theme the output by overriding `field--bootstrap-horizontal-tabs.html.twig`.
- Add accessible tab markup (ARIA `tablist`/`tab`/`tabpanel`, `aria-selected`) without hand-coding it.
- Reuse the field across bundles/entities anywhere the Field UI is available.
- Provide anchor ids generated from transliterated headers for predictable in-page links.
