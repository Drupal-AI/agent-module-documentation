<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_page — agent index

Feature module in the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit"). Ships the
unstructured **Page** content type (`node.type.page`) and all of its related config: fields, the
default form display, six view displays, a pathauto pattern, metatag defaults, translation settings,
and (when Site Studio is present) a Layout Canvas field plus Cohesion content templates. Almost all
behavior is installed *config* — the PHP is thin install/update glue.

- No settings page (no routing/services); `configure` is null. Adjust the content type and its
  displays like any other node bundle.
- Defines 5 node permissions and grants them to Acquia CMS's `content_author` / `content_editor`
  roles. No drush commands, no plugin types, no config schema of its own.
- Depends on `acquia_cms_image`, core `path`, and `field_group`. The content type also enforces
  `acquia_cms_common`, `menu_ui`, `scheduler`; Site Studio pieces need `acquia_cms_site_studio` +
  `cohesion_elements`. Cross-references `acquia_cms_common` for its workflow/metatag/search glue.

What you'd do:
- **Understand / adjust the Page content type + its displays** → [configure/content-type.md](configure/content-type.md)
- **See the fields, widgets and formatters on Page** → [fields/page-fields.md](fields/page-fields.md)
- **Grant/understand who can author Page content** → [permissions/permissions.md](permissions/permissions.md)
- **Know the install/update side effects (body relabel, role grants, node_revision_delete)** → [hooks/hooks.md](hooks/hooks.md)

Key facts (real machine names):
- Content type: `page` (config `node.type.page`), `new_revision: true`, `preview_mode: 0`,
  `display_submitted: false`, editorial workflow via `acquia_cms_common` third-party settings.
- Own field storages: `node.field_page_image` (entity_reference→media), `node.field_layout_canvas`
  (`cohesion_entity_reference_revisions`, Site Studio only). Reused: `body`, `field_categories`,
  `field_tags`.
- View modes wired: `default`, `card`, `horizontal_card`, `teaser`, `search_results`, `search_index`.
  Form display: `node.page.default`.
- Other config: `pathauto.pattern.page` (`[node:title]`), `metatag.metatag_defaults.node__page`,
  `language.content_settings.node.page`.
- Permissions (provider `node`): `create page content`, `edit own page content`,
  `delete own page content`, `edit any page content`, `delete any page content`.
- Hooks: `acquia_cms_page_install`, `acquia_cms_page_modules_installed`,
  `acquia_cms_page_content_model_role_presave_alter`, `acquia_cms_page_module_preinstall`,
  update hooks `8001`–`8006`.
