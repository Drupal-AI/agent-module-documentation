<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Gutenberg is a presentation-only glue module that makes the Gutenberg block editor look and behave correctly inside the Gin (or Claro) admin theme on node add/edit forms.

---

The module has **no settings of its own** (`configure` is null; no permissions, Drush, plugins, or config
schema). It depends on the `gutenberg` module and activates purely through hooks whenever Gutenberg
full-editing is turned on for a content type and the active admin theme is Gin or Claro. On the node
add/edit (and content-translation-add) routes it: adds a `gutenberg--enabled` class to the `<html>`
element (`preprocess_html`); attaches its `gin_gutenberg/gin_gutenberg` CSS/JS library
(`page_attachments_alter`, `form_node_form_alter`); registers and suggests two page templates
(`page__node__edit__gutenberg`, `page__node__add__gutenberg`) via `hook_theme` /
`hook_theme_suggestions_page_alter`; opens the metabox field group; and moves the Published/status (and,
on moderated types, `moderation_state`) control into Gutenberg's "meta" sidebar pane. A `#process`
callback (`processGutenbergSidebar`) repairs the Gutenberg sidebar on the translation-add form by pinning
the `edit-advanced` HTML id and reparenting the moderation control. Activation is gated by the helper
`_gin_gutenberg_gin_is_active()` (requires the `use gutenberg` permission and a Gin/Claro-based admin or
frontend theme) and `_gin_gutenberg_is_gutenberg_enabled()` (reads `gutenberg.settings:<node_type>_enable_full`).
It is a UI/theming layer only — it stores no data and changes no content.

---

- Make the Gutenberg editor render properly (spacing, sidebar, toolbar) inside the Gin admin theme.
- Get a consistent Gutenberg experience when using Claro instead of Gin.
- Add the `gutenberg--enabled` body/html class so Gin styles the node edit page correctly.
- Move the Published checkbox into Gutenberg's right-hand "meta" sidebar instead of the bottom strip.
- Place the moderation state control in the Gutenberg sidebar on content-moderated types.
- Fix the blank Gutenberg sidebar bug on the content-translation add form.
- Provide dedicated page templates for node add and node edit when Gutenberg is active.
- Open the "metabox" field group automatically on Gutenberg-enabled node forms.
- Give editors a polished full-screen block-editing surface that matches the Gin design system.
- Attach Gin-specific Gutenberg CSS/JS only on the relevant node forms (not site-wide).
- Ensure the Gutenberg editor picks up Gin's dark/light and accent settings on the edit screen.
- Improve the authoring UX for sites that standardise on Gin + Gutenberg.
- Keep Gutenberg's React sidebar aligned with Gin's Drupal advanced/meta panes.
- Support node add, node edit, and translation-add flows for Gutenberg content types.
- Avoid custom theming work to reconcile Gutenberg with Gin on every project.
- Style Gutenberg block toolbars and inspector to sit correctly within Gin's chrome.
- Roll out Gutenberg to editors without the default Claro/Gutenberg visual clashes.
- Ensure the "Save/Publish" affordances appear where Gin users expect them.
- Use with Quick Node Clone (the clone route is recognised as a content form).
- Present Gutenberg content types cleanly on multilingual sites using Gin.
