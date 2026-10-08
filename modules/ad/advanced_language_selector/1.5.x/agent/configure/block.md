# Configure — place the block and choose a style

There is **no settings page**. All configuration lives in the block's placement form.

## Place it
- Admin UI: Structure → Block layout → place **"Advanced language selector block"** (category
  "Language block") into a region. Or in code, a `block.block.*` config entity with
  `plugin: advanced_language_selector_block`.
- The block is only visible on **multilingual** sites: `blockAccess()` returns forbidden unless
  `LanguageManager::isMultilingual()`. It is uncacheable (`getCacheMaxAge()` returns 0) and
  invalidated by `config:configurable_language_list`.

## The configuration form (dynamic)
The form is **not** hand-written — `blockForm()` asks `StyleManager` for all styles and builds
fields recursively from each style's YAML `properties` tree (see extend/styles.md). So the fields
you see are exactly what the `config/styles/*.yml` files declare.

Top-level selector (from `config/style_selector.yml`):
- **Look and Feel → Theme** (`settings[look_and_feel][theme]`) — the active display **style**.
  Options are the eight styles below. This value drives which style's config subtree is saved and
  which Twig template renders. Default when unset: `bootstrap_dropdown`.

Each style renders a `details`/`fieldset` subtree that is shown/hidden via `#states` keyed on the
selected theme. Only the selected theme's validation errors are enforced — `blockValidate()`
strips errors belonging to other (hidden) themes as a workaround for `states` + `required`.

## The eight styles (`config/styles/*.yml`)
| Style id | Title | Twig theme hook | Notes |
|---|---|---|---|
| `bootstrap_dropdown` | Bootstrap Dropdown | `block__language_selector__bootstrap_dropdown` | default |
| `bootstrap_navigation` | Bootstrap Navigation | `block__language_selector__bootstrap_navigation` | nav/tabs |
| `bootstrap_modal` | Bootstrap Modal | `block__language_selector__bootstrap_modal` | button opens modal |
| `bootstrap_offcanvas` | Bootstrap Offcanvas | `block__language_selector__bootstrap_offcanvas` | slide-in panel |
| `bootstrap_list_group` | Bootstrap List Group | `block__language_selector__bootstrap_list_group` | |
| `bootstrap_button_group` | Bootstrap Button Group | `block__language_selector__bootstrap_button_group` | |
| `plain_html` | Plain HTML | `block__language_selector__select` | native `<select>`, no Bootstrap |
| `plain_html_list` | Plain HTML List | `block__language_selector__plain_html_list` | `<ul>` links, no Bootstrap |

## Options each style exposes
Bootstrap styles group options under **General** and **Display options** (with separate
**selected item** and **all items** groups); plain styles are simpler. Common fields:
- **Enter ID** (`general.id`) — HTML id for the component (required on Bootstrap styles).
- **Custom CSS class** (`general.css` / per-item `css`) — extra classes; `btn-primary` etc.
- **Text transformation** (`general.text_transformation`) — `default` / `upper` / `lower` /
  `capitalize`. (Plain HTML uses a simpler `uppercase` checkbox.)
- **Load external bootstrap library** (`general.load_external_bootstrap`) — check this **only**
  when your theme is not Bootstrap-based; it attaches `advanced_language_selector/bootstrap`
  (Bootstrap 5.0.2 + Popper 2.9.2 from jsDelivr CDN). Hidden field
  `general.external_bootstrap_library` holds the library name.
- **Select items to display** (`display…show` checkboxes) — any of `icons`, `lang_code`,
  `lang_name`; "select one at least" (required). Selected-item and all-items groups are set
  independently on Bootstrap styles.
- **Flag icon height (px)** (`icon_height`) — default 25.
- **Icon alignment** (`icon_alignment`) — `left` / `right`.

## What gets rendered
`build()` calls `languageManager->getLanguageSwitchLinks()` for the interface language and, per
link, adds: `langcode`, `icon` (flag SVG path via `Langcodes::langcodeToCountryCode()`, falling
back to `assets/flags/no-flag.svg`), `uri` (current path translated to the target language, using
the entity translation when the route has a node/term/entity), and `current_langcode`. If core
Language switching produces no links (e.g. Interface Translation not installed), it falls back to a
single default-language link. The selected style's template then renders the markup.

If the block is rendered directly (e.g. from Twig, not through the block manager) with no saved
config, `build()` injects a hard-coded default configuration JSON so it still renders.
