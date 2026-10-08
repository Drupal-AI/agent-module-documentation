<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS — Page ships a ready-made **Page content type** (`node.type.page`) together with its fields, form and view displays, pathauto pattern, metatag defaults and translation settings — one feature module of the Acquia CMS (Acquia Drupal Starter Kit) content model, with optional Acquia Site Studio visual-builder support.

---

Acquia CMS is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Instead of a site builder creating an unstructured landing-page type from scratch — the Body/Categories/Tags/Image fields, the widgets, six view modes, the `[node:title]` alias pattern, the metatag defaults — this module installs that configuration as a unit, so the Page type exists and is editor-ready the moment it is enabled. The content type is wired into the shared `acquia_cms_common` layer: the editorial Content Moderation workflow, metatag tag types, the search index and sitemap variant, plus Scheduler publish/unpublish and a main-menu placement. It also defines five standard Page node permissions and auto-grants them to Acquia CMS's `content_author` and `content_editor` roles.

When `acquia_cms_site_studio` is present, the module additionally installs a `field_layout_canvas` (Cohesion) field and a pack of Site Studio content templates, and it repurposes the Body field as a "Search Description" — the visible page is then built on the Layout Canvas while Body feeds search results. There is no settings page: the module is pure installed config plus thin install/update glue, so what it does is fixed by that config and extended the way you would extend any node bundle (add fields, adjust displays). It travels with a config export like any other content-type configuration.

The value and the limitation are the same fact: it is **distribution configuration, not a generic feature**. It encodes Acquia's opinions about what a Page should be and expects its siblings (`acquia_cms_common`, `acquia_cms_image`, and often Site Studio, Scheduler, Smart Trim, Field Group) to be present. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong, opinionated starting point you inherit whole.

---
- Add a pre-built, editor-ready Page content type to an Acquia CMS site.
- Author an unstructured landing page (homepage, marketing/event landing page).
- Get the Page fields — Body, Categories, Tags, Image — configured out of the box.
- Get six Page view displays (default, card, horizontal_card, teaser, search_results, search_index).
- Get the Page edit form laid out, with a Taxonomy field group and Scheduler tab.
- Build page layouts visually with Acquia Site Studio's Layout Canvas.
- Use Body as a search-only "Search Description" in a Site Studio setup.
- Get a `[node:title]` pathauto alias pattern for Page automatically.
- Get metatag/Open Graph/Twitter/Schema defaults for Page.
- Put Page under the editorial Content Moderation workflow.
- Schedule Page publish/unpublish via Scheduler.
- Grant Page authoring/editing to content_author and content_editor roles automatically.
- Index Page content for search and add it to the default sitemap.
- Enable Page content translation with untranslatable fields hidden.
- Keep the latest 30 Page revisions when node_revision_delete is installed.
- Standardise Page content and its editing experience across a site.
- Base a custom Page type on Acquia's model, then add fields.
- Reuse the Acquia CMS content model and its shared taxonomies.
- Export the Page config with the rest of the site.
- Match the Acquia CMS family, alongside Article, Event, Person and Place.
