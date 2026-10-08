<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors add a URL fragment (anchor) to menu links, so a menu item can target an in-page anchor like `#section`.

---

Via `hook_form_menu_link_content_form_alter()` (`menu_link_fragment.module`) the module adds a **Link fragment** textfield to the menu link add/edit form, defaulted from the link's stored `options['fragment']`. A validate handler restricts the value to `[A-Za-z0-9-_]` (alphanumerics, hyphens, underscores - no spaces). A submit handler merges the fragment into the menu link entity's `link` field `options` and re-saves the entity, so Drupal appends `#<fragment>` when rendering the link's URL. `hook_page_attachments()` attaches a small library on admin routes only. No config, permissions, routes or services; it relies on the core menu link edit permission for access, and the strict fragment regex prevents injection into the anchor.

---

- Point a menu link at an anchor within a page, e.g. `/about#team`.
- Build single-page-site navigation where menu items scroll to sections.
- Add a fragment without hand-editing the link URL field.
- Reuse the same destination path with different anchors across several menu items.
- Preserve the fragment across menu link edits (defaulted from stored options).
- Validate fragments to safe characters (alphanumerics, hyphen, underscore).
- Support table-of-contents style menus that jump to headings.
- Keep the fragment as part of the menu link's `link` options, not a separate field.
- Work with any menu managed by core `menu_link_content`.
- Attach helper assets only on admin routes to avoid front-end weight.
- Let editors create anchor links without developer involvement.
- Combine with in-page anchors added by CKEditor or templates.
- Avoid broken menu URLs by rejecting spaces/special characters in fragments.
- Use on Drupal 8.8+, 9 or 10.
- Provide accessible skip-style navigation via menu anchors.
- Support deep-linking to a specific part of a long landing page.
