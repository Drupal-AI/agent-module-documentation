Basic Page (`lightning_page`, a Lightning Core submodule) installs a simple "Basic page" node type for static content, plus optional integrations with Metatag, Pathauto, Layout Library, and menus.

---

Basic Page ships a `page` node type ("Basic page") much like Drupal's Standard profile page, intended for static content such as an About page. On install it provides the node type (revisions on, not promoted, submission info hidden), a Body field, default form/view displays, and a teaser display — all as `config/install`. `config/optional` adds behavior only when the relevant modules are present: a Pathauto pattern (`[node:title]`) for pages, a `field_meta_tags` Metatag field (wired into the page form/view displays via `hook_ENTITY_TYPE_insert`), and a two-column Layout Library layout. On install and via `hook_modules_installed` it opportunistically enables Layout Builder for the page view display (if Layout Library is present), adds the page type to the `main` menu (if Menu UI is present), and adds `page` to the editorial content-moderation workflow (if Lightning Workflow is present). It defines no config UI of its own (`configure` is null); you manage the resulting content type at `/admin/structure/types/manage/page`. **Not compatible with the Standard install profile**, which already defines a `page` type. No permissions, plugins, or Drush commands.

---

- Add a ready-made "Basic page" content type for static content (About, Terms, etc.).
- Get a Body field and sensible default/teaser view displays without configuring them.
- Have basic pages create revisions by default (`new_revision: true`).
- Keep basic pages out of the front-page promotion and hide submission info.
- Auto-generate `[node:title]` URL aliases for pages when Pathauto is installed.
- Add SEO meta tags to pages via a `field_meta_tags` field when Metatag is installed.
- Wire the meta-tags field into the page form and view display automatically.
- Enable Layout Builder for the page view display when Layout Library is installed.
- Offer a pre-built two-column layout (`page_two_column`) via Layout Library.
- Add the Basic page type to the main navigation menu when Menu UI is installed.
- Put basic pages under the editorial workflow when Lightning Workflow is installed.
- Provide a starting-point page type on a fresh (non-Standard) Drupal site.
- Manage the generated type at `/admin/structure/types/manage/page` like any node type.
- Serve as the "simple content" companion to richer Lightning content types.
- Give site builders a page type that mirrors Drupal core's Standard page without using Standard.
