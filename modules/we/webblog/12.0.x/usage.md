Web Blog installs a ready-to-use "Web Blog" content type with a listing view and a featured queue, so a site has a working blog out of the box.

---

Web Blog is a recipe/config-bundle module from the Webship ("web*") suite. It ships almost no PHP: `webblog_install()` simply applies the bundled recipe at `recipes/default`, which enables the required modules and imports config. On install it creates a `webblog` node type ("Web Blog") with a Body field and a `field_media` image reference, default/teaser/full view modes rendered through Display Builder, a `webblogs` view (default display plus "Web Blogs List" and "Featured Web Blogs" block displays), and a `featured_webblogs` entityqueue used to hand-pick highlighted posts. The content type has content moderation, revisions, a media-library widget, and is placed under the main menu. Version 12.0.1 requires Drupal `^11.4 || ^12` and depends on core `path`/`text`/`node`/`user`/`menu_ui`/`content_moderation`/`media_library` plus the contrib `manage_display`, `entityqueue`, `webassets`, and `display_builder` (entity view + UI). Note that unlike the 11.0.x line, the display layer is now Display Builder rather than Layout Builder. It provides no routes, permissions, services, or config schema of its own — content access follows core node and content-moderation permissions.

---

- Stand up a working blog on a fresh Drupal 11.4/12 site without hand-building a content type.
- Get a `webblog` ("Web Blog") node type with title, Body (text + summary), and a Media image reference.
- Let editors attach an image to a post through the core Media Library widget (`field_media` → image media).
- Author posts with content moderation enabled (a `moderation_state` widget on the form) and revisions on by default.
- Publish/unpublish, promote, and mark posts sticky using the standard node form controls the recipe exposes.
- Add posts to the site's main menu directly from the node form (menu_ui integration, parent `main:`).
- Give each post a URL alias via the Path field on the create/edit form.
- Show a paginated grid of published blog posts using the `webblogs` view (9 per page, 3-column responsive grid, newest first).
- Render post teasers with a smart-trimmed body (200 chars, "Read more…" link) and a square media thumbnail via Display Builder.
- Present a hand-curated "Featured Web Blogs" list by placing the view's `block_featured_webblogs` display and ordering entries in the `featured_webblogs` entityqueue.
- Place a general "Web Blogs List" block (`block_webblogs_list` display) in any region for a blog index.
- Curate homepage/highlight sections by dragging posts into the Featured Web Blogs queue at `/admin/structure/entityqueue`.
- Style the full post view with a large "ultrawide" media rendering and formatted publish date (Display Builder full view mode).
- Reuse the recipe as a building block inside a larger install profile or site recipe (it declares `type: install`).
- Customize fields, widgets, and formatters afterward at `/admin/structure/types/manage/webblog` since everything is plain config.
- Add more media types to a post by extending `field_media` (currently limited to the image media bundle).
- Adjust how many posts appear by editing the `webblogs` view pager, or add a page display to expose a blog index route.
- Translate posts (title, body, and the base fields are translatable) on a multilingual site.
- Keep the blog visually consistent with the rest of a Webship/UI-Suite site because rendering runs through Display Builder profiles.
- Bootstrap demo/blog content structure for prototypes, client demos, or training environments quickly.
