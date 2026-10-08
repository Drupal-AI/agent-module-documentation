<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Classes adds three CSS-class text fields to every block placement form so you can attach arbitrary classes to a block's wrapper, its title and its content without touching Twig.

---

The module is a small alteration of core's Block module. It has no settings form and no configure route. On the block configuration form (`block_form`) it adds three 255-character textfields — **Block CSS class(es)**, **Title CSS class(es)** and **Content CSS class(es)** — under `third_party_settings.block_classes`, but only for users holding the `administer block css classes` permission. The values are saved as third-party settings on the `block` config entity (`block.block.<id>` → `third_party_settings.block_classes.{block_class,title_class,content_class}`), and `hook_block_presave()` unsets any key that is left empty so the config stays clean. At render time `hook_preprocess_block()` loads the block entity by `#id`, splits each stored string on spaces and pushes every token through `Html::cleanCssIdentifier()` before appending it to `attributes['class']`, `title_attributes['class']` and `content_attributes['class']` respectively. Because it works purely through the standard block template variables, any theme whose `block.html.twig` prints `attributes`, `title_attributes` and `content_attributes` picks the classes up automatically. Blocks rendered without an `#id` (for example Page Manager block widgets) are skipped. A config schema (`block.block.*.third_party.block_classes`) is shipped so the settings survive config export/import.

---

- Add a Bootstrap/Tailwind utility class such as `mb-4 text-center` to a single block placement.
- Give a hero block a `hero--dark` modifier class so the theme can style just that placement.
- Add a class to a block's `<h2>` title only, leaving the wrapper untouched.
- Add a class to the block's content wrapper to switch a listing between grid and list layouts.
- Style two placements of the same block plugin differently in different regions.
- Attach an animation trigger class (e.g. `js-animate-on-scroll`) to a block for a theme's JS.
- Tag blocks with analytics hook classes for front-end tracking scripts.
- Apply a background-colour utility class per block without creating a new block type.
- Namespace design-system classes onto blocks placed by site builders rather than developers.
- Restrict who can set block classes by granting `administer block css classes` only to themers.
- Export block class assignments with the rest of your configuration (`block.block.*` third-party settings).
- Set block classes in a deployment script via `$block->setThirdPartySetting('block_classes', 'block_class', '...')`.
- Add print-specific classes such as `d-print-none` to hide a block on printed pages.
- Add accessibility helper classes (e.g. `visually-hidden`) to a block title.
- Give menu blocks per-placement classes so the same menu renders differently in header and footer.
- Add layout classes to Views blocks without editing the view's advanced CSS class setting.
- Prototype styling quickly on a live site without a theme deployment.
- Add a `sticky` or `is-collapsible` class consumed by custom JavaScript behaviours.
- Apply a spacing scale class per block to fine-tune vertical rhythm in a region.
- Mark blocks for a CSS-only A/B variant by toggling one class value.
- Add container-query or grid-area classes to blocks inside a CSS Grid region.
- Give the block content wrapper a class so a theme can target only inner markup.
- Replace one-off `block--<id>` theme CSS with an explicit, editor-visible class.
- Combine several space-separated classes in one field; each is sanitised individually.
- Audit which placements carry custom classes with `drush config:get block.block.<id>`.
