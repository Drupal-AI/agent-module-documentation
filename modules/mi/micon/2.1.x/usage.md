<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon is an IcoMoon-based icon manager: you upload IcoMoon font or SVG icon packages as `micon` config entities and then reference icons by id (e.g. `fa-user`) through a Twig function, a render `#theme`, a form element, a field type, or a small PHP API — no manual CSS wiring.

---

Micon turns an IcoMoon export (a downloaded `.zip`) into a published `micon` config entity. On save the archive is extracted under `public://micon/<id>/`, its `selection.json`/`style.css` are rewritten so the CSS class prefix matches the entity id, and the package stylesheet is attached site-wide via `hook_library_info_build()` + `hook_library_info_alter()`. Icons are then addressed by a **selector** — the package prefix plus the icon name (the shipped Font Awesome package uses prefix `fa-`, e.g. `fa-user`). Rendering goes through two theme hooks, `micon_icon` (icon only) and `micon` (icon + title, with position/`icon_only`), both backed by `templates/*.html.twig`. The Twig function `{{ micon('fa-user') }}`, the global PHP function `micon('Hello')->setIcon('fa-user')` (returning a `MiconIconize` that extends `TranslatableMarkup`), and the `MiconIconizeTrait::micon()` wrapper are the everyday entry points. A `string_micon` field type/widget/formatter stores an icon id per entity, and a `#type => 'micon'` form element renders the searchable fonticonpicker select. A separate **YAML plugin type** (`*.micon.icons.yml`, alter hook `hook_micon_icons_alter`) maps arbitrary text/regex strings to icon ids so that plain translated strings can be auto-decorated with icons. Two managers drive it: `micon.icon.manager` (`MiconIconManager`, resolves an icon id to a `MiconIcon`) and `plugin.manager.micon.discovery` (`MiconDiscoveryManager`, matches strings to icon ids). A Drush command `drush micon <path>` exports the active icons as an SCSS mixin/variable file. Nine submodules add icons to content types, vocabularies, paragraph types, menu links, link fields, Linkit widgets, local-task tabs, and CKEditor.

---

- Upload an IcoMoon Font Awesome (or custom) package and use its icons site-wide with no theme code.
- Render an icon in a Twig template with `{{ micon('fa-user') }}`.
- Add an icon in a render array via `['#theme' => 'micon_icon', '#icon' => 'fa-star']`.
- Render an icon next to a label with `['#theme' => 'micon', '#icon' => 'fa-user', '#title' => t('Profile'), '#position' => 'after']`.
- Attach an icon to translatable text programmatically: `micon('Save')->setIcon('fa-check')`.
- Use `MiconIconizeTrait` in a controller/service so `$this->micon('Delete')->setIcon('fa-trash')` works.
- Show the icon only (hide the label) with `->setIconOnly()`.
- Place the icon after the label with `->setIconAfter()`.
- Add a `string_micon` "Icon" field to a content type so editors pick an icon per node.
- Restrict a `string_micon` widget to only certain packages so editors see a curated icon set.
- Render a stored icon field with the `string_micon` formatter.
- Expose a searchable icon picker anywhere in a form with `'#type' => 'micon'` and `'#packages' => ['fa']`.
- Look up a `MiconIcon` object for an id via `\Drupal::service('micon.icon.manager')->getIconMatch('fa-user')`.
- Auto-decorate strings with icons by shipping a `mymodule.micon.icons.yml` mapping (text/regex → icon id).
- Add icon definitions at runtime with `hook_micon_icons_alter()`.
- Give status/label/operation strings default icons (the base `micon.micon.icons.yml` maps `published`, `status`, `operations`, etc.).
- Generate an SCSS `_micon.scss` mixin + `$micons` map for a theme with `drush micon themes/my_theme/src/scss/base`.
- Use SVG (image) IcoMoon packages, rendered as inline `<svg><use xlink:href>` sprites.
- Swap the whole site's icon set by uploading a new package and disabling the old one.
- Serve icons from a single embedded config entity so packages travel with a config export.
- Add icons to admin local-task tabs automatically (via `micon_local_task`).
- Put icons on menu links (via `micon_menu`).
- Put icons on link-field values, including Linkit autocomplete links (via `micon_link` / `micon_linkit`).
- Show a content type's or vocabulary's icon in its admin list (via `micon_content_type` / `micon_vocabulary`).
- Give paragraph bundles icons in the Paragraphs type list and add widget (via `micon_paragraphs`).
- Render Micon icons inside social-media-links blocks (the module ships a Social Media Links iconset plugin).
- Restrict which packages a menu-link or link-field author may choose from (per-widget or global config).
- Cache all resolved icons permanently (tag `micon.icons`) and invalidate on package or icon-definition change.
