<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Product & Release content model

All config below ships in `recipes/default/config/` and is applied by the recipe (not from a
`config/install` dir — the module has none). Install standalone with `drush en webreleases -y`
(runs `webreleases_install()` → applies `recipes/default`), or apply the recipe directly.

## Node types (`node.type.*.yml`)
- **Product** (`product`) — "Use *Product* content to describe a product that has releases."
- **Release** (`release`) — "Use *Release* content to publish a release for a product."

Both: `new_revision: true`, `preview_mode: 1`, `display_submitted: true`, and are placed on the
`main` menu (`third_party_settings.menu_ui.available_menus: [main]`, `parent: 'main:'`). The
editorial (content_moderation) workflow comes from the Webpage recipe, so new content starts
unpublished/draft until moderated.

## Fields
Storage in `field.storage.node.*.yml`, per-bundle instances in `field.field.node.*.yml`.

| Field | Bundle | Type | Key settings |
|-------|--------|------|--------------|
| `body` | product, release | text_with_summary | from the Webpage recipe (shared body storage) |
| `field_image` | product | entity_reference → media | target bundle `image`; cardinality 1 |
| `field_product` | release | entity_reference → node | **required**, target bundle `product`, cardinality 1 — the release→product link |
| `field_release_image` | release | entity_reference → media | target bundle `image`; optional |
| `field_release_link` | release | link | `link_type: 17` (generic: internal or external URL), `title: 1` (optional link text); optional |

![Release content type — Manage fields](../../../../../../../screenshots/webreleases/12.0.x/release-manage-fields.png)

![Create Release node form](../../../../../../../screenshots/webreleases/12.0.x/release-add-form.png)

The Media (`image`) type these reference is provided by the **Web Assets** recipe; the `body`
storage by the **Webpage** recipe. That is why `recipes/default/recipe.yml` lists those two sibling
recipes first — a recipe installs modules with config-entity creation disabled, so the referenced
config must come from the sibling recipes, not from enabling the modules alone.

### The release → product relationship
`field_product` on the release bundle is a required single-value node reference restricted to
`product` nodes (`handler_settings.target_bundles.product`). Every release therefore belongs to
exactly one product; this is the join the `releases` View filters on (contextual filter
`field_product_target_id`) and that the Pathauto pattern and path processor use to build
`/products/<product>/releases/...` URLs.

## View modes & displays
View modes (`core.entity_view_mode.node.*.yml`): `teaser`, `full`, `archive`, `product_release`.

Form displays (`core.entity_form_display.node.{product,release}.default.yml`) and view displays
(`core.entity_view_display.node.*`) are provided for both bundles across the modes above
(product: default/full/teaser; release: default/full/teaser/archive/product_release). The
`core.base_field_override.node.release.title.yml` retitles the release title field. These displays
are built for **Display Builder**; `WebReleasesHooks::nodeViewAlter()` re-attaches the standard
`node`, `node--type-<bundle>`, `node--view-mode-<mode>` CSS classes (and a newline suffix per
field) when Display Builder renders them without the node template.

To extend: add fields through the normal Field UI at
`/admin/structure/types/manage/{product,release}/fields`.
