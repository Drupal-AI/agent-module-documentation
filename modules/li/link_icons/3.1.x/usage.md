<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Icons is a field formatter for core's Link field that renders a Font Awesome icon for the service a link points to — a Facebook glyph for a facebook.com URL, an envelope for a mailto: link, a phone for tel:, and a generic globe for anything unrecognised — optionally shown with or instead of the link text.

---

Install it with `drupal/fontawesome` (`^2 || ^3`) and core's **Link** field, then make sure Font Awesome's icon library actually loads on your pages (via the Font Awesome module) or the icon markup renders as nothing. On a content type's **Manage display** screen, set a Link field's format to **"Link with service icon"** and use the settings cog to choose the eight display options: what text to show beside the icon (`text`), whether to hide the URL scheme (`hideURLscheme`), icon-vs-text order (`order`), icon `size`, fixed/variable `width`, `coloured` vs uncoloured, the preferred `shaped` variant (square/circle/natural), and an optional stacked `background`. Which domains map to which icon is stored as **`link_icon_service`** config entities, managed at **Configuration » Search and metadata » Link icon services** (`/admin/config/search/link_icon_service`), gated by the `administer link icon services` permission — each service holds one or more trailing hostnames plus a Font Awesome icon id, style, optional square/circle variants, colour and CSS class. The base module ships no services; enable the **`link_icons_brands`** submodule to import ~100 ready-made brands (Facebook, X, LinkedIn, GitHub, Spotify, …). You can also switch on icons for a menu's external links per menu, from the menu edit form.

---

- Show a Font Awesome icon for a social/service link.
- Render a Facebook icon for a facebook.com URL.
- Render brand icons for X, LinkedIn, GitHub, Spotify and more.
- Show an envelope icon for a mailto: link.
- Show a phone icon for a tel: link.
- Fall back to a generic globe for unrecognised domains.
- Set the "Link with service icon" formatter on a Link field.
- Choose whether to show the link title, the URL, both, or neither.
- Hide the http:// or https:// scheme from displayed URLs.
- Put the icon before or after the text.
- Enlarge icons with Font Awesome sizes (1x–5x).
- Use fixed-width icons for tidy vertical alignment.
- Colour icons with each service's brand colour, or turn colour off.
- Prefer squared or circled icon variants where available.
- Wrap icons in a stacked background shape (circle, square, heart, …).
- Manage domain → icon mappings as config entities in the admin UI.
- Add a brand the module does not ship out of the box.
- Override or delete a shipped brand mapping.
- Match several hostnames (e.g. facebook.com and fb.watch) to one icon.
- Import ~100 popular brands via the link_icons_brands submodule.
- Restrict who can manage services with the administer link icon services permission.
- Add service icons to a menu's external links, toggled per menu.
- Reuse the formatter across many content types and fields.
- Style the rendered icons further with your own theme CSS.
- Export the service mappings with your site configuration.
