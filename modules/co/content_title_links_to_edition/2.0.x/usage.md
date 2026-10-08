<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Turns the node-title field in a configured Views listing into a link to that node's edit form.

---

Content Title Links to Edition is a small, core-only module that hooks into the rendering of Views field output (`hook_preprocess_views_view_field`) and, for the views and title columns you configure, replaces the title field's normal link (usually to the node canonical page) with a link to that node's edit form (`entity.node.edit_form`). It is configured at `/admin/config/content_title_links_to_edition/settings` (permission "administer content title links to edition"): you list one or more view IDs plus the machine name of the title field in each, and you choose whether the behaviour applies to all content types or only selected ones. It ships pre-configured for the core `content` admin view's `title` field, is multilingual-aware (adds the row's language to the generated edit URL), and depends only on core `node` and `views`. The rewrite happens purely at display time — no content, routes, or entities are altered — which makes it handy for editorial or headless setups where editors work from a listing rather than the default admin content screen.

---

- Make node titles in the core admin Content view (`/admin/content`) link straight to the edit form instead of the node page.
- Give content editors a one-click path from a listing to editing, skipping the node view page.
- Add the same edit-link behaviour to a custom Views-based content listing by adding its view ID and title-field name.
- Configure multiple views at once, each with its own title column, via the "Views" table on the settings form.
- Restrict the edit-link rewrite to specific content types (e.g. only "Article" and "Page").
- Apply the rewrite to all content types with a single "All content types" checkbox.
- Automatically opt new content types into the behaviour as they are created (the "Enable automatically" option).
- Streamline a headless/decoupled Drupal admin experience where editors mainly use custom listings.
- Speed up editorial QA by letting reviewers jump from a moderation listing directly into editing.
- Target a non-default title column name when a view exposes the title under a custom field alias.
- Keep the module dormant for content types left unchecked, so only chosen bundles get edit links.
- Preserve multilingual editing by routing the edit link through the row's language.
- Provide a Configuration → Content authoring settings page for site builders to manage the behaviour.
- Add or remove view rows dynamically on the settings form with AJAX "Add Row" / "Remove" buttons.
- Turn a curated dashboard view of recent content into an editor's quick-edit workspace.
- Avoid teaching editors the full admin content UI by surfacing edit access from familiar listings.
- Use it as a lightweight alternative to building a custom Views "edit" link field.
- Roll the behaviour out site-wide via exported configuration (`content_title_links_to_edition.settings`).
- Enable per-view control so some listings link titles to edit while others link to the canonical page.
- Support Drupal 8.8 through 11 with no non-core dependencies.
