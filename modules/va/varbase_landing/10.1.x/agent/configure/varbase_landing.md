<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# varbase_landing — content type & installed configuration

`varbase_landing` has no settings form. Everything is installed once by `hook_install()`, which runs
the recipe at `recipes/default/` via `RecipeRunner::processRecipe()`. There is no `configure` route.
To change anything, edit the resulting config in the normal Drupal admin (Structure → Content types →
*Landing page (Paragraphs)*, and the Manage fields / form display / display tabs) or re-export config.

## What the recipe installs

The `recipe.yml` first ensures these modules are enabled: `user`, `node`, `menu_ui`,
`paragraphs_features`, `paragraphs_asymmetric_translation_widgets`, `length_indicator`,
`advanced_text_formatter`, `maxlength`. Then it imports the config below and grants permissions
(see `permissions/varbase_landing.md`).

### Content type — `node.type.landing_page`
- Name: **"Landing page (Paragraphs)"**, machine `landing_page`.
- `new_revision: true`, `preview_mode: 1` (optional preview), `display_submitted: false`.
- `menu_ui` third-party settings: available menu `main`, parent `main:` — so editors can place the
  node in the main menu from the node form.

### Fields
| Field | Type | Notes |
|---|---|---|
| `field_lp_paragraphs` | `entity_reference_revisions` → paragraph | Label **"Components"**, cardinality **-1**, translatable. Allowed bundles (all from `varbase_bootstrap_paragraphs`): `bp_accordion`, `bp_block`, `bp_carousel`, `bp_columns`, `bp_columns_three_uneven`, `bp_columns_two_uneven`, `bp_image`, `bp_modal`, `bp_simple`, `bp_tabs`, `bp_view`, `bp_webform`, `from_library`, `text_and_image`. |
| `field_description` | `string_long` | Label "Page description"; used for overview pages and Google/Facebook snippets. |
| `field_meta_tags` | `metatag` (firehose widget) | From `varbase_seo` / metatag. |
| `field_yoast_seo` | `yoast_seo` (real-time SEO widget) | Widget `body` mapped to `field_description`. |
| `path`, `menu_link` | core | URL alias + computed menu link. |

The `bp_*` paragraph bundles are **not** defined here; they ship with
`varbase_bootstrap_paragraphs`. The field config only references them, which is why the recipe
requires that module to be present first.

### Form display — `core.entity_form_display.node.landing_page.default`
- `field_lp_paragraphs` uses the **`paragraphs_previewer`** widget: `add_mode: modal`,
  `edit_mode: closed`, `closed_mode: preview`, title "Component(s)"; features enabled: duplicate,
  collapse_edit_all, add_above. `paragraphs_features` third-party settings add
  `delete_confirmation`, `add_in_between`, `split_text`.
- `field_description`: `string_textarea` (5 rows) with `maxlength` JS limit **160** (soft, not
  enforced) and `advanced_text_formatter`.
- `title`: `length_indicator` (optimin 15 / optimax 50 / tolerance 10) + `advanced_text_formatter`.
- `field_group` `group_page_content` (details, open) wraps `field_lp_paragraphs` as "Page content".
- `promote` and `sticky` are **hidden**.

### View display — `core.entity_view_display.node.landing_page.default`
- Only `field_lp_paragraphs` is shown, formatter `entity_reference_revisions_entity_view`
  (view_mode `default`, label hidden). `field_description`, `field_meta_tags`, `field_yoast_seo`,
  `langcode` and `links` are hidden — the page *is* its components.

### Behavioural config also installed
- **Pathauto** pattern `hierarchical_paths_for_landing_pages`:
  `[node:menu-link:parents:join-path]/[node:title]`, scoped to the `landing_page` bundle, weight -5.
- **Metatag** defaults `node__landing_page`: title `[node:title] | [site:name]`,
  description `[node:field_description]`, og:image `[node:share-image]`.
- **Rabbit Hole** `node_type_landing_page`: action `display_page`, `allow_override: 0`.
- **Content translation** enabled for the bundle (`language_alterable: true`), with
  `paragraphs_asymmetric_translation_widgets` so each language may have a different component
  structure (not just translated text).
- Base-field overrides for `created`, `changed`, `promote`, `sticky`, `uid`, `menu_link`.

## Runtime code
Only `src/Hook/VarbaseLandingHooks.php`: both the add form (`node_landing_page_form`) and edit form
(`node_landing_page_edit_form`) get `#attached` library
`varbase_bootstrap_paragraphs/vbp-default-admin` for the component admin styling. No other code runs.
