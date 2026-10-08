<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Menu Access applies Domain Access Entity's per-domain model to Drupal core menu links: on menus you opt in, each menu link is only shown on the affiliate domain(s) it is assigned to.

---

This submodule of Domain Access Entity brings domain scoping to `menu_link_content` links. Installing it ships a `domain_access` entity-reference field (target `domain`, unlimited cardinality) on the `menu_link_content` entity, so every custom menu link can carry affiliate domains. You then enable control per menu from the settings form at `/admin/config/domain/menu/access/settings` — each menu gets a checkbox, and ticking it stores a `third_party_settings.domain_menu_access.access_enabled = true` flag on that `system` menu config entity. For an enabled menu two things happen: the menu-link edit form reveals a "Domain" group so editors can pick the link's domains, and `hook_block_alter` swaps the menu's `system_menu_block` derivative for the module's `DomainMenuAccessMenuBlock`, whose `DomainMenuLinkTreeManipulators::checkDomain()` marks any link whose `domain_access` value does not include the active domain as forbidden (a link with no domain value is treated as available on all domains). Access is cached per `url.site` (per domain) and per permissions. Field visibility on the form is further gated by the Domain Access `publish to any domain` / `publish to any assigned domain` permissions.

---

- Show a menu link only on the specific affiliate domain(s) it belongs to.
- Build a shared main menu whose items differ per domain in a multi-domain install.
- Give each brand/region domain its own footer links from one Drupal menu.
- Opt individual menus in to domain control while leaving others global.
- Assign a menu link to several domains at once (unlimited-cardinality domain field).
- Treat a menu link with no domain set as visible on all domains (fallback behavior).
- Let editors pick a menu link's domains from a "Domain" group on the menu-link edit form.
- Automatically render an enabled menu through a domain-aware menu block, no theme changes.
- Filter menu trees at render time so cross-domain links never appear for the wrong domain.
- Cache menu access per domain (`url.site`) so different domains get correctly varied menus.
- Restrict who can set a link's domains via the Domain Access publish permissions.
- Combine with Domain Access Entity so nodes, entities, and menus all follow one per-domain model.
- Enable domain control on the Main navigation menu for a franchise site.
- Keep an "admin/tools" menu global while scoping the main menu per domain.
- Provide per-domain navigation without duplicating menus for each domain.
- Turn domain control on or off per menu at any time from a single settings form.
- Hide inaccessible links entirely (replaced by an InaccessibleMenuLink) rather than showing dead entries.
- Support translated menu links, checking the domain on the current-language translation.
- Migrate existing menu links into per-domain visibility by assigning domains to them.
- Use the shipped `domain_access` field on `menu_link_content` to store affiliations in config/exports.
