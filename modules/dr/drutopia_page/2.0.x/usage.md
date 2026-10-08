<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Page ships a ready-made Basic "Page" content type plus its fields, Paragraphs body builder, Display Suite displays, URL pattern, RDF mapping, and role permission grants as installable configuration.

---

Drutopia Page is a config-only Features module (bundle `drutopia`) from the Drutopia distribution, and is the recommended replacement for the deprecated `drutopia_landing_page`. It contains no PHP code, routes, services, hooks, or permission definitions of its own. Enabling it imports a `page` node type intended for static content (an "About us" page, a policy page, or any standalone page) together with a small field set: a required `field_summary` (Summary), a `field_body_paragraph` Paragraphs body builder (labelled "Description", targeting the text/image/file/video/slide/update/faq paragraph types), a `field_meta_tags` Metatag field, and a core `body` field that is shipped but hidden in every display. It also imports a Display Suite (`ds_1col`) form display and default/full/teaser view displays, a `promote` base-field override that defaults pages off the front page, a pathauto pattern that aliases pages to `[node:title]`, and an RDF `schema:WebPage` mapping. Config actions grant page create/edit permissions to the Drutopia `contributor`, `editor`, and `manager` roles. It is installed here as a dev checkout tracking the 2.0.x branch and pulls in the Drutopia dependency chain (drutopia_core, drutopia_seo, ds, paragraphs, entity_reference_revisions, metatag, pathauto, menu_ui, rdf, text), so it is normally deployed through the distribution rather than on its own.

---

- Add a fully structured Basic "Page" content type to a site without hand-building fields.
- Publish static, non-time-sensitive content such as an "About us", contact, or policy page.
- Replace the deprecated `drutopia_landing_page` module with the current Drutopia page feature.
- Give editors a required Summary field (`field_summary`) that drives the teaser display and search results.
- Build page bodies from Paragraphs (text, image, file, video, slide, update, FAQ) via `field_body_paragraph`.
- Compose long-form pages by stacking reusable paragraph components instead of one WYSIWYG blob.
- Manage per-page SEO metadata through the Metatag `field_meta_tags` field.
- Generate clean page URLs automatically (`[node:title]`) via the shipped pathauto pattern.
- Keep pages off the front page by default through the `promote` base-field override.
- Add pages to the `main` or `footer` menu directly from the node form (menu_ui, parent `main:`).
- Present pages consistently using the shipped Display Suite `full` and `teaser` view modes.
- Render the paragraph body on the full page view through the DS one-column layout.
- Show a linked title plus summary on page teasers and listings.
- Track page revisions automatically (`new_revision: true`) for editorial history.
- Offer optional content preview before saving (`preview_mode: 1`).
- Expose per-page RDF `schema:WebPage` metadata for structured-data consumers.
- Grant contributors the ability to create pages and edit their own pages.
- Grant editors and managers the ability to create and edit any page.
- Onboard an editorial team with page permissions out of the box, no manual permission setup.
- Serve as the base "page" feature that other Drutopia site builds and features extend.
- Provide the page content type that `drutopia_storyline` and similar features build on.
