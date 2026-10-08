<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_article — agent index

Feature module of the **Acquia CMS** distribution (rebranded "Acquia Drupal Starter Kit"). It ships
the **`article` node type** (label "Article") and its whole content model as installed config —
fields, form/view displays, an `article_type` taxonomy vocabulary, three Views, facet blocks,
metatag/pathauto/language defaults, and Site Studio templates. The only PHP is thin install/update
glue in `acquia_cms_article.install`; there is no `src/`, no routing, no services, no plugins.

Resolved release **1.6.3**. Core `^9.4 || ^10 || ^11`. Depends on `acquia_cms_person`
(for the `person` node type referenced by Display Author). The content model wiring
(editorial workflow, `categories`/`tags` vocabularies, metatag/sitemap facades) comes from
[`acquia_cms_common`](../../../acquia_cms_common/3.3.x/agent/start.md), which is pulled in transitively.

**No settings page** — no `*.routing.yml`, `configure` is null. This is distribution config, not a
standalone feature: enabling it makes the Article type editor-ready and expects its siblings present.

- **The Article content type: fields, displays, vocabularies, third-party settings** → [fields/article.md](fields/article.md)
- **The 5 Article node permissions and how roles get them** → [permissions/permissions.md](permissions/permissions.md)
- **Install/update glue: the role-presave alter it implements, module_preinstall, update_N hooks** → [hooks/integration.md](hooks/integration.md)
- **The Views, facet blocks and search config it ships (optional config)** → [views/views.md](views/views.md)

## Key facts
- Node type: `article` (config `node.type.article`, optional config, `enforced.module: acquia_cms_article`).
- Fields on `node.article`: `body`, `field_article_image`, `field_article_media`, `field_article_type`, `field_categories`, `field_display_author`, `field_tags`.
- Field storages shipped here: `field_article_image` (media, card 1), `field_article_media` (media, card -1), `field_article_type` (taxonomy_term, card 1), `field_display_author` (node:person, card 1). `body`, `field_categories`, `field_tags` storages come from core/`acquia_cms_common`.
- Taxonomy vocabulary defined: `article_type` (label "Article Type").
- View displays: `default`, `card`, `horizontal_card`, `search_results`, `teaser`; form display `default`.
- Views: `articles` (search_api index `content`), `article_cards`, `articles_fallback`.
- Permissions (in `acquia_cms_article.permissions.yml`, `provider: node`): `create article content`, `edit own article content`, `delete own article content`, `edit any article content`, `delete any article content`.
- Install alter implemented: `acquia_cms_article_content_model_role_presave_alter(RoleInterface &$role)` — grants the perms above to `content_author` / `content_editor`.
- `hook_module_preinstall` calls service `acquia_cms_common.utility`→`setModulePreinstallTriggered()`.
- Update hooks: `acquia_cms_article_update_8001`–`_8008` (Site Studio display style, optional Display Author, pathauto entity_bundle swap, media target bundles, image/author display modes, Scheduler form widgets, enforced Site Studio deps, invalid-config cleanup).
- Node-type `third_party_settings`: `acquia_cms_common` (workflow `editorial`, metatag tag types, `search_index: content`, `subtype.field: field_article_type` / `subtype.facet: articles_article_type`, `sitemap_variant: default`), `menu_ui` (main menu), `scheduler` (publish/unpublish enabled).
- No config schema dir, no drush, no plugin types.
