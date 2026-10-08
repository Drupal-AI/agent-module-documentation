Adds the same client-side "filter by name" search box that Drupal core ships on the Extend (`/admin/modules`) page to many other admin config-entity listing pages.

---

Admin List Filter brings core's instant, type-to-filter search input to admin overview pages that lack it — content types, vocabularies, menus, roles, image styles, workflows, and more. It works with zero configuration: on install it uses `hook_entity_type_alter()` to swap each supported entity type's `list_builder` handler for a small subclass that adds a `#type=search` input above the table and tags the searchable cells. Filtering runs entirely in the browser using core's own `system/drupal.system.modules` JavaScript library, so there are no AJAX requests and no extra server load — typing simply hides rows whose text does not match. Two trait variants cover both standard listings and draggable (weighted, form-based) listings such as roles, languages, and text formats. Support for Pathauto pattern and Metatag defaults listings is added automatically when those contrib modules are present. The module has no routes, permissions, config, or settings of its own; every filtered page keeps its original core access control and functionality intact.

---

- Quickly find one content type by name on `/admin/structure/types` when a site has dozens.
- Filter the taxonomy vocabulary list on `/admin/structure/taxonomy`.
- Filter the menus list on `/admin/structure/menu`.
- Filter media types on `/admin/structure/media`.
- Filter block (custom block) types on `/admin/structure/block-content`.
- Filter comment types on `/admin/structure/comment`.
- Filter contact forms on `/admin/structure/contact`.
- Filter user roles on `/admin/people/roles` (draggable list).
- Filter configured languages on `/admin/config/regional/language` (draggable list).
- Filter date formats on `/admin/config/regional/date-time`.
- Filter text formats / editors on `/admin/config/content/formats` (draggable list).
- Filter image styles on `/admin/config/media/image-styles`.
- Filter responsive image styles on `/admin/config/media/responsive-image-style`.
- Filter search pages on `/admin/config/search/pages` (draggable list).
- Filter shortcut sets on `/admin/config/user-interface/shortcut`.
- Filter workflows on `/admin/config/workflow/workflows`.
- Filter the field report list on `/admin/reports/fields`.
- Filter Pathauto URL alias patterns on `/admin/config/search/path/patterns` (when Pathauto is installed).
- Filter Metatag defaults on `/admin/config/search/metatag` (when Metatag is installed).
- Give admins a faster way to locate config entities on large sites without scrolling.
- Reuse core's proven filtering JavaScript instead of a bespoke, unmaintained search widget.
- Add filtering without any configuration, permissions, or performance cost (purely client-side).
