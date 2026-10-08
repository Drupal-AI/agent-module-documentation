<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Title Help Text lets administrators add per-content-type help text under the Title field on node add/edit forms, so content editors get guidance on what to put in the title.

---

The module adds a "Title field help text" textarea to the node type edit form ("Submission form settings" section) via `hook_form_FORM_ID_alter()` on the node type form, and stores the entered text as a third-party setting on the node type config entity (`node.type.<bundle>.third_party.node_title_help_text.title_help`). On the node add/edit form it implements `hook_form_BASE_FORM_ID_alter()` for `node_form` to read that setting and set it as the `#description` of the title widget — but only if the title field has no description already, so it never clobbers another module's help text. It also supports the Inline Entity Form module by implementing `hook_inline_entity_form_entity_form_alter()`, applying the same title help inside IEF node widgets. There is no dedicated settings page, no permissions, no services, and no Drush commands; each content type simply carries its own optional help string. On uninstall it removes the `title_help` third-party setting from every node type.

---

- Tell editors exactly what belongs in a node's title (e.g. "Use the format: Event — City — Date").
- Add different title guidance to each content type (Article vs. Event vs. Landing page).
- Enforce a naming convention by describing it right under the title field.
- Remind authors to keep titles under a length for SEO/teaser display.
- Explain how the title is used (e.g. shown in menus, breadcrumbs, browser tab).
- Provide examples of good titles for a specific content type.
- Guide non-technical editors filling in a complex content type.
- Show help text inside Inline Entity Form widgets when nesting nodes.
- Standardize title formatting across an editorial team.
- Document required prefixes/suffixes for titles (e.g. product SKUs).
- Add localization-friendly hints (the help text is translatable config).
- Improve onboarding for new content contributors.
- Reduce back-and-forth review by clarifying title expectations up front.
- Give landing-page titles campaign-specific instructions.
- Set help text via exported config for repeatable deployments.
- Toggle guidance per content type without touching code.
- Clarify the difference between the node title and other heading fields.
- Prompt editors to include a keyword in the title for search.
- Avoid duplicate/ambiguous titles by describing a disambiguation scheme.
- Provide accessibility-friendly instructions tied to the title input.
- Keep help concise using plain text under the title box.
- Roll out title conventions to many content types quickly through the content type edit form.
