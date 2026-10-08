FontAwesome Menu Icons lets you attach a Font Awesome icon to any Drupal menu link, so the rendered menu shows an icon before, after, or in place of the link text.

---

The module adds a "FontAwesome Icon" fieldset to both the custom menu-link form (`menu_link_content`) and the generic module-defined menu-link edit form. Each link stores four values — the icon class (`fa_icon`), a style/version prefix (`fa_icon_prefix`, e.g. `fa`, `fas`, `fa-solid`), the wrapper HTML tag (`fa_icon_tag`, `i` or `span`), and the placement (`fa_icon_appearance`: `before`, `after`, or `only`/without text). For custom menu links these values live in the entity's `link` field `options` array; for module-defined links they are written to the `menu_tree` table and mirrored into the `fontawesome_menu_icons.settings` config object under `menu_link_icons` so they survive cache rebuilds (re-applied via `hook_menu_links_discovered_alter`). At render time `hook_link_alter` and `hook_preprocess_menu` inject the `<i class="prefix icon">` (or `<span>`) markup around the link text, adding `aria-hidden`/`aria-label`/`sr-only` for accessibility when the icon replaces the text. A jQuery iconpicker widget (optional `fontawesome-iconpicker` front-end library) enhances the text field on the form. The module ships no admin settings form and no configure route — configuration happens per menu link. It depends on the Font Awesome (`fontawesome`) module to load the actual icon font and on core Menu UI.

---

- Add a home icon before the "Home" link in the main navigation menu.
- Show a user/account icon on a "My account" menu link.
- Put an icon after a link's text (e.g. an external-link arrow) using the "after" appearance.
- Render an icon-only social menu (Twitter/X, Facebook, GitHub) with links that show no text.
- Give a footer menu compact icons next to each link.
- Brand a login/register menu link with a lock or key icon.
- Add a cart icon to a "Checkout" link in a commerce menu.
- Decorate admin/custom toolbar-style menus with recognizable glyphs.
- Use Font Awesome 6 solid icons by choosing the `fa-solid` prefix and `fa-` prefixed names.
- Use legacy Font Awesome 4 icons by choosing the `fa` prefix (no `fa-` on the name).
- Mix brand icons (`fab` / `fa-brands`) for social links with solid icons for content links.
- Wrap the icon in a `span` instead of an `i` tag for themes that style spans.
- Provide accessible icon-only links (the module adds `aria-label` and an `sr-only` title automatically).
- Add icons to a mega-menu built from custom menu links.
- Set icons programmatically on `menu_link_content` entities during a migration or install hook.
- Bulk-assign icons to menu links via `drush php:eval` by writing the `fa_icon*` link options.
- Add a search icon to a "Search" menu link that points to a search page.
- Highlight a "New" or "Featured" section link with a star or bolt icon.
- Give language-switcher-style menu links flag or globe icons.
- Add a phone or envelope icon to "Contact" links.
- Keep icons in sync across cache clears for module-defined links (config-backed storage).
- Remove an icon from a link by clearing the icon field (config entry is unset automatically).
- Theme a sidebar navigation block with leading icons per item.
- Add RSS/feed icons to syndication menu links.
- Decorate breadcrumb-like custom menus with directional chevron icons.
