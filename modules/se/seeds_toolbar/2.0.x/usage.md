Seeds Toolbar restyles the Drupal core/Admin Toolbar into a vertical, mobile-first, RTL-aware admin navigation with light/dark modes, a quick "Add content" tray, an admin-menu search box, custom logos, and optional custom CSS.

---

Seeds Toolbar depends on core `toolbar` plus `admin_toolbar` + `admin_toolbar_tools`, and completely replaces their CSS/JS (`hook_library_info_alter` empties the toolbar/admin_toolbar libraries and attaches its own). It converts the toolbar into a vertical panel via theme overrides and preprocessors, adding: a **Seeds Add** tray with links to create content, taxonomy terms, media, and blocks (built by `SeedsManager::buildMenu`, access-filtered per entity type); a **Seeds Local Task** tray exposing the current route's local tasks; a **Support** tab linking to a configurable URL; a home/logo tab; and an admin-menu **search** box (rendered when the user has `use admin search` and search is enabled — `_seeds_toolbar_search_links` flattens the admin menu tree into searchable `data-search` links). It integrates opportunistically with `admin_toolbar_search`, `masquerade`, `responsive_preview`, and `devel`. Settings live in the `seeds_toolbar.settings` config object edited at `/admin/config/user-interface/seeds-toolbar` (route `seeds_toolbar.configuration`, permission `administer seeds toolbar`): `style` (light/dark), `compact`, `search`, `support` URL, `custom_style` CSS path, `dark_logo`/`light_logo`/`dark_icon`/`light_icon` paths, and experimental `fixed_elements`. Two permissions: `administer seeds toolbar` and `use admin search`. No Drush; no config schema shipped.

---

- Give the Drupal admin a modern vertical toolbar instead of the default horizontal bar.
- Switch the whole admin toolbar between light and dark mode.
- Provide a mobile-first admin navigation experience for editors on phones/tablets.
- Support RTL admin interfaces (Arabic and other RTL languages) out of the box.
- Add a one-click "Add" tray for creating content, taxonomy terms, media, and blocks.
- Show only the create links the current user actually has access to.
- Expose the current page's local task tabs in a dedicated toolbar tray.
- Add a Support link in the toolbar pointing at your helpdesk (or hide it by leaving it empty).
- Add a searchable admin menu box so editors can jump to admin pages by typing.
- Restrict who sees the admin search box via the `use admin search` permission.
- Swap the toolbar logo/icon for your brand, with separate images per light/dark mode.
- Load a custom CSS file only when the toolbar is active, for further styling.
- Collapse the toolbar to a compact (icon-only) state by default.
- Keep the expanded toolbar open by default and offset page content accordingly.
- Integrate a "switch back" affordance when using the Masquerade module.
- Play nicely with the Responsive Preview module's toolbar item.
- Reorder toolbar tabs into a consistent, opinionated order.
- Delegate configuration to trusted admins via the `administer seeds toolbar` permission.
- Replace core toolbar styling entirely without a custom admin theme.
- Provide quick-access "settings/overview" icons next to each content type in the Add tray.
- Offer a cleaner admin UX for a Drupal CMS/distribution kickstart.
