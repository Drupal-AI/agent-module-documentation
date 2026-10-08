Web Doc is a recipe-only module that provisions a ready-to-use "Web Doc" documentation content type — with body field, teaser/full displays built on Display Builder, book navigation, a pathauto alias pattern and editorial permissions — on install.

---

Web Doc (machine name `webdoc`) is a thin config-bundle module from the Webship web* suite. It ships no runtime PHP beyond an install hook: enabling it applies `recipes/default`, which installs its prerequisite modules (book, node, menu_ui, manage_display, pathauto, text, display_builder and its `display_builder_entity_view` / `display_builder_ui` submodules) and creates a `webdoc` node type. The recipe adds a `body` (text_with_summary) field, `teaser` and `full` view modes, a default form display, three Display Builder-driven view displays (default/full/teaser) that render the body and a Book navigation block, a pathauto pattern `web-doc/[node:book:parents:join-path]/[node:title]`, registers the type with the Book module so pages nest as a book hierarchy, and grants the `content_editor` role the create/edit-own/delete-own/revision plus book permissions. It targets Drupal `^11.4 || ^12`. There is no settings form — all behavior is the provisioned config, editable through the usual Structure UI afterwards.

---

- Install a documentation content type without hand-building fields, displays and aliases.
- Bootstrap a "Documentation" or knowledge-base section on a Drupal site quickly.
- Author documentation pages at `/node/add/webdoc` with a title and rich-text body.
- Organize documentation pages into a nested book hierarchy via the Book module.
- Render a Book navigation block automatically on each Web Doc page.
- Get clean, hierarchical URL aliases like `/web-doc/parent/child/page-title` via pathauto.
- Present documentation body via Display Builder in the default and full view modes.
- Show trimmed teaser summaries (300–600 chars) in documentation listings.
- Give editors (the `content_editor` role) rights to create and manage their own docs.
- Let editors create new books and add content to existing books.
- Keep documentation under content moderation (the default form exposes a moderation_state widget).
- Maintain revisions of documentation pages (the type creates a new revision by default).
- Provide a consistent documentation content model across sites in the Webship suite.
- Combine Book hierarchy with Display Builder layouts for structured docs.
- Serve as a starting point you customize (add fields, tweak displays) after install.
- Reapply the recipe elsewhere to reproduce the same documentation setup.
- Migrate existing documentation content into a standardized `webdoc` type.
- Use pathauto tokens to keep documentation URLs stable as the book tree changes.
- Enable teaser-based documentation index/landing pages.
- Pair with the wider web* / Webship suite for a full documentation site.
