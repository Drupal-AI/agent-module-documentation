<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sub Site provides very basic multi-site-like grouping by reusing the core Book module: a book's top node becomes a "subsite" that can carry its own theme, branding, social-media links and navigation blocks.

---

The module adds a `subsite` field to node types, a plugin system (`Drupal\subsite\Plugin\Subsite\*`) for per-subsite features (theme, branding, book, social media), a theme negotiator that switches the active theme when browsing pages inside a subsite, and a `subsite` cache context so rendered output varies per subsite. An admin overview lives at `/admin/structure/subsite` (permission `administer subsite settings` — note the routing uses that string while permissions.yml declares `administer subsite configuration`/`maintain subsite`) and settings at `/admin/structure/subsite/settings` (`administer site configuration`). Blocks include subsite social links, footer links and a book main-navigation block.

Editors with `administer subsite configuration` (or `maintain subsite` for allowed node types) get the subsite field on the node form. Operationally it is an admin/editor tool with no anonymous or mutating public endpoints; all routes are permission-gated.
---
- Group a set of book pages into a branded subsite
- Assign a distinct theme to a subsite via the theme plugin
- Override site branding (name/logo) per subsite
- Attach social-media links to a subsite
- Render a book main-navigation block for the subsite
- Show subsite footer links block
- Show subsite social links block
- List all subsites at /admin/structure/subsite
- Configure allowed node types for subsites
- Grant editors the "maintain subsite" permission for specific types
- Add the subsite field to a content type
- Switch active theme automatically when viewing subsite pages
- Vary page cache per subsite using the subsite cache context
- Build microsites without a full multisite install
- Use book hierarchy as the subsite page tree
- Expose a printer-friendly view of a book subsite
- Add custom subsite plugins by implementing SubsitePluginInterface
- Restrict subsite administration to trusted roles
- Provide per-subsite navigation to end users
- Combine branding + theme + social plugins for a cohesive microsite
