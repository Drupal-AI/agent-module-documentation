<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generates a fixed set of standard DSFR-styled menus (social, footer columns, institutional, legal) as real Drupal menu entities and optionally places them as blocks in the matching DSFR theme regions.

---

DSFR Menus is a helper module in the DSFR (Systeme de Design de l'Etat, the French State Design System) suite. It exposes one admin form at `/admin/dsfr/import/menus` where you tick which of the predefined DSFR footer/social menus you want, and on submit it creates the corresponding `menu` config entities plus their `menu_link_content` links from templates hardcoded in the `Drupal\dsfr_menu\Menus` service. Where the current theme actually declares the matching DSFR region, it also creates a `system_menu_block` block for each imported menu and places it into that region so the DSFR footer renders correctly. It is not a generic import tool: there is no file upload or pasted data — the menu set, item labels and the institutional links (legifrance.gouv.fr, service-public.fr, numerique.gouv.fr, data.gouv.fr) are all shipped by the module. It depends on `dsfr_core` (for theme/region detection via the `dsfr_core.tools` service) and on core `block`, `menu_link_content` and `text`. After import you edit the menus and links normally at Structure -> Menus and adjust placement at Structure -> Block layout.

---

- Bootstrap a DSFR-compliant footer for a French public-sector site without hand-building each menu.
- Create the DSFR "social" menu (Facebook, Twitter-X, Instagram, LinkedIn, YouTube, Mastodon, Slack, Telegram, TikTok, Dailymotion, GitHub, Snapchat, Twitch, Threads, Vimeo) as menu links.
- Create up to six "Footer Top" column menus (`footer-top-1` .. `footer-top-6`) with placeholder items to fill in.
- Create the mandatory "institutional" menu pre-populated with the four official gouv.fr links.
- Create the mandatory legal "last" footer menu (Sitemap, Accessibility, Legal mention, Personal data, Cookies management).
- Import several of these menus at once by selecting multiple checkboxes on the import form.
- Automatically place each imported menu as a block in its DSFR region (`follow_social`, `footer_top_1..6`, `footer_menu_first`, `footer_menu_last`) when the theme declares that region.
- Target a DSFR child/sub-theme: the form imports blocks against whatever DSFR theme is currently the default.
- Get warned at import time when the DSFR theme is missing from the theme list, or when a selected menu's region is absent in the current theme (the option is suffixed with `(*)`).
- Skip re-importing a menu that already exists: already-present menus and already-placed blocks are reported back and left untouched.
- Provide a starting DSFR footer structure, then edit item titles and URLs afterwards at Structure -> Menus.
- Re-run the form later to add menus you did not select the first time.
- Gate menu creation behind a dedicated `administer dsfr_menu settings` permission, separate from core's menu-administration permissions.
- Reach the form from the DSFR Core admin section (the tab lives under `dsfr_core.settings`).
- Use the `dsfr_menu.config` service (`Menus` class) programmatically to fetch the region list, labels, descriptions and default item templates.
- Call `Menus::manageMenu()` from custom code to create a menu + links + block placement in one step.
- Standardise footer navigation across multiple DSFR sites by importing the same template set on each.
- Keep menu content editable through Drupal's standard menu UI once imported (the module only seeds it).
- Combine with `dsfr_core` and a DSFR theme to deliver an out-of-the-box compliant government footer.
