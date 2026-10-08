<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia CMS Article ships a ready-made **Article content type** — its fields, form and view displays, an `article_type` vocabulary, listing Views with facets, and metatag/pathauto/Scheduler/editorial-workflow defaults — as installed configuration, so a blog/news Article type exists and is editor-ready the moment the module is enabled.

---

Acquia CMS (rebranded "Acquia Drupal Starter Kit") is Acquia's Drupal distribution, assembled from small single-purpose feature modules like this one. Instead of a site builder hand-building an Article type — Body, an image and a media gallery, Article Type / Categories / Tags taxonomies, a Display Author reference to a Person node, plus the widgets, view modes, URL-alias patterns and metatag defaults — this module delivers that whole model as a unit of optional config. Enabling it creates the `article` node type and wires it into the family's editorial workflow, Scheduler publishing, Search-API-backed Articles listing, and facet blocks.

The value and the limitation are the same fact: it is **distribution configuration, not a generic feature**. It encodes Acquia's opinions and expects its siblings present — it hard-depends on `acquia_cms_person` (for the Person author reference) and pulls in `acquia_cms_common` (which supplies the editorial workflow, the `categories`/`tags` vocabularies, and the metatag/sitemap facades that read the node type's third-party settings). The only PHP is thin install/update glue: a role-presave alter that grants the Article permissions to the `content_author`/`content_editor` roles, a module-preinstall flag, and a series of config-migration update hooks. On an Acquia CMS site it is exactly right; on an unrelated site it is a strong, opinionated starting point you can adopt and extend like any content-type config.

---
- Add a ready-made Article content type to an Acquia CMS site.
- Author blog or news articles with a structured content model.
- Get an Article type with Body, Image, Media, Author, Type, Categories and Tags fields preconfigured.
- Skip hand-building an article/blog content type, its widgets and view modes.
- Provide editors a ready Article edit form with grouped media and taxonomy sections.
- Reference a Person node as the displayed author of an article.
- Categorize articles by an `article_type` taxonomy plus shared Categories and Tags.
- Reuse Acquia CMS's Article model across sites for consistency.
- Get card, horizontal-card, teaser and search-result view displays out of the box.
- Schedule articles to publish/unpublish via the built-in Scheduler settings.
- Route new articles through the distribution's editorial moderation workflow.
- Expose an Articles listing page backed by Search API with Article Type and Category facets.
- Show a "Recent articles" block from the shipped Article Cards view.
- Get pathauto URL-alias patterns and metatag defaults for articles automatically.
- Grant Article create/edit/delete permissions to standard content roles automatically.
- Base a custom article type on this configuration and extend it with extra fields.
- Standardize the article editing experience across an editorial team.
- Enable Article as one component of a full Acquia CMS content model.
- Export the Article configuration with a normal site config export.
- Render article displays through Acquia Site Studio templates when Site Studio is present.
- Adopt Acquia's opinionated article structure as a migration or build starting point.
- Translate article content using the enabled content-language settings.
