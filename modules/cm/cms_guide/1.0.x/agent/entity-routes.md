<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity type, routes, permissions & rendering

## The `cms_guide` content entity

`src/Entity/CMSGuide.php` — `@ContentEntityType(id = "cms_guide")`, base table `cms_guide`,
`admin_permission = "administer cms_guide"`. Not revisionable, not translatable, no bundles.

Base fields (`baseFieldDefinitions()`):

| field | type | notes |
|-------|------|-------|
| `id` / `uuid` | integer / uuid | read-only |
| `weight` | integer | read-only; import order |
| `slug` | string(255) | **required**, `UniqueField` constraint; the URL slug |
| `source` | string(255) | required; provenance label (`Default` or provider module name) |
| `title` | string(255) | required; entity label |
| `summary` | string_long | optional; shown on the landing list |
| `content` | text_long | required; format `cms_guide`; the assembled HTML |
| `sections` | map (cardinality 1) | importer-populated `[{title, anchor}]` for anchor nav |
| `imported_content_hash` | string(64) | SHA-256 of content at last import (manual-edit detection) |

Helpers: `getTitle/setTitle`, `getSlug`, `getSource`, `getSummary/setSummary`,
`getSlugUrl()` (→ `cms_guide.single`), `getImportedContentHash`, `getContentValue`,
`hasBeenManuallyEdited()`.

Handlers: view builder = core `EntityViewBuilder`; `CMSGuideListBuilder` (admin collection at
`/admin/content/cms-guide`, ID + Title columns); `EntityViewsData`; access =
`CMSGuideAccessControlHandler`; add/edit form `CMSGuideForm`; delete form = core
`ContentEntityDeleteForm`; `AdminHtmlRouteProvider`.

## Routes

Custom (`cms_guide.routing.yml`):

| route | path | controller/form | requirement |
|-------|------|-----------------|-------------|
| `cms_guide.landing` | `/admin/cms-guide` | `CMSGuideController::loadCmsGuideLandingPage` | `_permission: view cms_guide` |
| `cms_guide.single` | `/admin/cms-guide/{slug}` | `CMSGuideController::loadCmsGuideSinglePage` | `_permission: view cms_guide` |
| `entity.cms_guide.import` | `/admin/structure/cms-guide/import` | `CMSGuideImportContent` form | `_permission: administer cms_guide` |
| `entity.cms_guide.delete` | `/admin/structure/cms-guide/delete` | `CMSGuideDeleteContent` form | `_permission: administer cms_guide` |

Plus entity CRUD routes from `AdminHtmlRouteProvider` (add/edit/delete/collection under
`/admin/content/cms-guide`). `CMSGuideController::loadCmsGuideSinglePage($slug)` loads by numeric
id or by slug (`entityQuery` on `slug`, `accessCheck(TRUE)`); unknown slug → redirect to
`system.404`.

## Permissions & access

`cms_guide.permissions.yml`: `administer cms_guide` (**restrict access: true**), `view cms_guide`,
`create cms_guide`, `edit cms_guide`, `delete cms_guide`. None are granted to any role by default.

`CMSGuideAccessControlHandler`: `view` → `view cms_guide` OR `administer cms_guide`; `update` →
`edit cms_guide` OR admin; `delete` → `delete cms_guide` OR admin; `create` → `create cms_guide`
OR admin (all `OR`-combined). Every entity query in the module runs `accessCheck(TRUE)`.

## Rendering

- **Landing** (`loadCmsGuideLandingPage`) themes `cms_guide_landing_page` with the flat section
  list from `cms_guide_get_cms_guide_content()` (all entries sorted by weight, each with
  `title`/`summary`/`link` and sub-section anchors). Template
  `templates/cms-guide-landing.html.twig`.
- **Single page** renders the entity via the view builder (`default` view mode). The default view
  display (`config/optional/core.entity_view_display…default.yml`) renders `content`, `summary`,
  `title` with the **`string`** (plain-text) formatter. Template `templates/cms-guide.html.twig`
  extends `cms-guide-template.html.twig`, which builds the accordion sidebar (anchor deep-links to
  `#section-{anchor}`) and a "Back to index" link.
- The `cms_guide` text format (`config/optional/filter.format.cms_guide.yml`) applies `filter_html`
  with an allow-list of safe tags (no `<script>`, no event-handler attributes).

## Module glue (`cms_guide.module`)

- `hook_theme` (both themes); `hook_preprocess_block` forces the "CMS Guide" page title on the two
  guide routes; `template_preprocess_cms_guide` populates `site_title`, `sections`, `parent_link`.
- `hook_library_info_alter` adds `assets/css/admin.css` to Claro's global styling.
- `hook_form_alter` on `cms_guide_edit_form`: attaches the forms library and makes the `slug` widget
  **read-only** (slug is the stable import match key).
- Pathauto pattern `config/optional/pathauto.pattern.cms_guide.yml`:
  `/admin/cms-guide/[cms_guide:slug]`.
