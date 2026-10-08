<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMS Guide (cms_guide) — agent index

**Docs-as-code, in-admin editor help system.** Guide content is authored as **Markdown files
inside a module** (the contrib module itself ships empty), then an admin **imports** it: the
importer converts Markdown → HTML (`league/commonmark`), rewrites an `{{image_path}}` placeholder,
and stores each entry as a **`cms_guide` content entity**. Editors read it under
`/admin/cms-guide` (linked from the admin toolbar). Installed **1.0.0-alpha2** (version dir
`1.0.x`). Core `^10 || ^11`. License GPL-2.0-or-later. Package: none declared.

## Dependencies

- Drupal modules (`.info.yml`): core **`filter`**, core **`text`**, contrib **`pathauto`**.
- PHP library (`composer.json`): **`league/commonmark` `^2.0`** (used as
  `GithubFlavoredMarkdownConverter`), **`drupal/pathauto` `^1.12`**.
- No `.install` file, no update hooks, no Drush commands.

## What it provides (from source)

- **Content entity type `cms_guide`** (`src/Entity/CMSGuide.php`) — base table `cms_guide`,
  `admin_permission: administer cms_guide`, fields: `id`, `uuid`, `weight`, `slug` (unique,
  required), `source`, `title`, `summary`, `content` (`text_long`, format `cms_guide`),
  `sections` (`map`, importer-populated anchor list), `imported_content_hash` (SHA-256, manual-edit
  detection). Handlers: `EntityViewBuilder`, `CMSGuideListBuilder`, `EntityViewsData`,
  `CMSGuideAccessControlHandler`, add/edit form `CMSGuideForm`, admin route provider.
- **Routes** (`cms_guide.routing.yml`): `cms_guide.landing` (`/admin/cms-guide`, view) +
  `cms_guide.single` (`/admin/cms-guide/{slug}`, view) → `CMSGuideController`; plus the
  auto-generated entity CRUD routes and `entity.cms_guide.import` /
  `entity.cms_guide.delete` (admin forms).
- **Import form** `Form/CMSGuideImportContent` (`/admin/structure/cms-guide/import`) and
  **delete-all form** `Form/CMSGuideDeleteContent` (`/admin/structure/cms-guide/delete`).
- **Content-pack plugin type** `@CMSGuideContent` (manager `plugin.manager.cmsguide_content`,
  base `CMSGuideContentBase`, annotation `Annotation/CMSGuideContent`) — companion modules
  contribute content by declaring a plugin pointing at a `structure.yml`.
- **Permissions** (`.permissions.yml`): `administer cms_guide` (restrict access), `view cms_guide`,
  `create cms_guide`, `edit cms_guide`, `delete cms_guide`.
- **Optional config** (`config/optional/`): text format `cms_guide` (`filter_html` restricting
  tags), a Pathauto pattern (`/admin/cms-guide/[cms_guide:slug]`), and default form/view displays
  (content field rendered with the **`string`** — plain-text — formatter).
- **Theme/templates**: `cms_guide_landing_page` + `cms_guide` themes; twig in `templates/`; assets
  (accordion sidebar JS/CSS). `hook_library_info_alter` injects `assets/css/admin.css` into Claro.

## Solution docs

- **Importer, `structure.yml` format, Markdown/image handling, refresh & manual-edit semantics** →
  [import.md](import.md)
- **Entity type, fields, routes, permissions, access, rendering, admin integration** →
  [entity-routes.md](entity-routes.md)
- **`@CMSGuideContent` content-pack plugin (companion modules)** → [content-plugin.md](content-plugin.md)
