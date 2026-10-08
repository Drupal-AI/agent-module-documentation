Block Title Class lets editors pick a heading class (h1-h6) for an individual block's title from the block configuration form, storing it as a third-party setting and appending it to the rendered title's CSS classes.

---

Block Title Class is a small "User interface" utility module (depends only on core Block) that adds a "Title Class" select to every block's configuration form under Structure → Block layout. The available values mirror Bootstrap-style heading utility classes — None or h1 through h6 — and are saved on the block entity as the third-party setting `block_title_class.title_class`. On render, `hook_preprocess_block` appends the chosen value to the block title's `title_attributes` class list, so a block heading can visually match a different heading level (for example, an `<h2>` element styled with an `h4` class) without editing templates, changing the markup tag, or writing custom CSS per block. It requires that the active theme's block template print `{{ title_attributes }}` on the title element. There is no global settings page, no route, and no permission beyond core's normal block-administration access.

---

- Give a specific placed block's title an `h1`-`h6` visual style without editing its template.
- Make an `<h2>` block heading look like an `h4` to fit a sidebar's visual hierarchy.
- Apply Bootstrap-style heading utility classes (`h1`-`h6`) to block titles on a Bootstrap-themed site.
- Normalize inconsistent block heading sizes across regions by assigning the same class to each.
- Downsize the visual weight of secondary/aside block titles while keeping semantic markup intact.
- Emphasize a call-to-action block's title by bumping it to an `h1`-styled class.
- Keep the semantic heading tag chosen by the theme but override only its appearance per block.
- Let content editors adjust block title styling from the block form without touching CSS or Twig.
- Configure the title class per block instance so the same block type can look different in different placements.
- Set the title class as part of a config-exported block (`third_party_settings.block_title_class.title_class`) for deployment across environments.
- Clear a previously set class by choosing "None", which removes the third-party setting on save.
- Provide consistent heading styling for menu, views, or custom blocks placed via Block layout.
- Style system blocks (e.g. Search, Powered by Drupal) titles to match a design system's type scale.
- Support a design refresh by re-classing block titles in bulk without a theme rebuild.
- Align block titles with a typographic scale defined by an external CSS framework's `h*` classes.
- Differentiate primary vs. secondary sidebar blocks purely through their title class.
- Reduce the need for block-specific template overrides just to change title size.
- Adjust title styling on blocks placed in Layout Builder-independent Block layout regions.
- Keep title markup accessible (correct heading level) while decoupling its visual size.
- Roll the setting into version-controlled block config so title styling is reproducible per environment.
