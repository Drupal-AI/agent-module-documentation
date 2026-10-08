UI Icons is a generic icon manager for Drupal 11 that lets any third-party icon pack be declared once in a YAML file and then used everywhere Drupal renders output. The base `ui_icons` module ships the `icon_autocomplete` form element, an icon search service, and an icon preview API on top of Drupal core's Icon API (11.1+).

---

UI Icons builds on Drupal core's experimental Icon API (`\Drupal\Core\Theme\Icon`, available in 11.1+). Any module or theme declares one or more icon packs in an `EXTENSION_NAME.icons.yml` file at its root; each pack names an `extractor` plugin (core provides `path`, `svg`, and `svg_sprite`), a set of `config.sources` glob paths or URLs, and a Twig `template` used to render each icon. Core's `IconPackManager` (`plugin.manager.icon_pack`) discovers these packs and builds the icon list, while `IconExtractorPluginManager` (`plugin.manager.icon_pack.extractor`) runs the extractor plugins. The base `ui_icons` module adds the reusable `icon_autocomplete` render element with an AJAX autocomplete/preview controller, an `IconSearch` service for querying icons by pack and label, an `IconPreview` helper plus an `icon_preview` Twig function, and theme-specific autocomplete styling (Gin, DaisyUI, DSFR). A large set of submodules layers on top: an Icon field type, Media type, CKEditor 5 button, text filter, menu-link icons, a visual picker, a UI Patterns bridge, a web-font extractor, and an admin icon library overview. The base module itself has no configuration UI or permissions — it is plumbing that other integrations consume. Icons are addressed everywhere by a combined `pack_id:icon_id` string.

---

- Declare an icon pack from a directory of SVG files using the core `svg` extractor and a `*.icons.yml` file.
- Declare an icon pack from a single SVG sprite sheet using the `svg_sprite` extractor.
- Declare an icon pack of raster images (PNG/JPG) or remote URLs using the `path` extractor.
- Add an `icon_autocomplete` form element to a custom config or content form so editors can search and select an icon.
- Restrict an icon selector to specific packs via `#allowed_icon_pack`.
- Return a plain `pack_id:icon_id` string from a form instead of an icon object using `#return_id`.
- Expose per-icon extractor settings (size, class, title) in a form with `#show_settings`.
- Render an icon in a Twig template with the `icon_preview(pack_id, icon_id, settings)` function.
- Search icons programmatically by keyword and pack with the `ui_icons.search` service.
- Build a live icon preview via AJAX for a custom widget using the preview controller.
- Attach an Icon field to a content type or taxonomy term (via `ui_icons_field`).
- Combine an icon with a link field for icon-decorated links (via `ui_icons_field` link integration).
- Add icons to menu links in the menu UI (via `ui_icons_menu`).
- Let editors insert inline icons into rich text with a CKEditor 5 button (via `ui_icons_ckeditor5`).
- Allow icons inside filtered text bodies through a text filter (via `ui_icons_text`).
- Manage icons as Media entities so they participate in the media library (via `ui_icons_media`).
- Give editors a visual grid picker instead of a text autocomplete (via `ui_icons_picker`).
- Browse every icon available on the site from an admin overview page (via `ui_icons_library`).
- Define icon packs sourced from an icon web font like Font Awesome (via `ui_icons_font`).
- Use icons as props/slots inside UI Patterns components (via `ui_icons_patterns`).
- Integrate icons with Linkit-powered autocomplete link fields (via `ui_icons_field_linkit`).
- Add icon options to Link Attributes / Linkit Attributes widgets (via the `*_attributes` submodules).
- Theme the autocomplete result list as a `list` or a `grid` via `#result_format`.
- Limit autocomplete result count with `#max_result`.
- Provide a bespoke admin preview template for font-based packs via the `preview` key in `icons.yml`.
- Attach a Drupal library to an icon pack (CSS/JS for the icon font) via the `library` key.
- Ship icon packs directly from a theme (icons.yml is discovered from themes too).
- Bundle a licence and version metadata with an icon pack for attribution.
