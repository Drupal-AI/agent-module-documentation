<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Asymmetric Menu Trees lets one translated menu render a genuinely different tree in each language — different ordering, different parents, different enabled links and different link URLs — instead of forcing every language to share the single structure Drupal core stores.

---

Drupal core stores exactly one structure per menu: a menu link has one parent, one weight and one enabled flag, shared across every language, and translation only swaps the label text. That is fine when the languages are faithful translations of each other, but many multilingual sites are not — a section may exist in one language and not another, or belong under a different parent, or need a different order or destination URL per audience. The historical workaround is a separate menu per language plus a language condition on each block, which duplicates every shared item. This module removes the constraint by making the relevant `menu_link_content` base fields translatable and reading them per language at render time. In its config form (`/admin/config/asymmetric_menu_trees`, gated by *administer site configuration*) an admin ticks which capabilities to enable: **link** (different URL per language), **order** (different weight *and parent* per language), and **enabled** (a link switched on for some languages and off for others). `hook_entity_base_field_info_alter()` then marks the corresponding fields (`link`, `weight`, `parent`, `enabled`) translatable. Every `menu_link_content` link's plugin class is swapped to `AsymmetricMenuLinkContent` (via `hook_menu_links_discovered_alter()`, `hook_install`, `hook_entity_insert` and an update hook that rewrite the `menu_tree` table's `class` column), whose `isEnabled()`, `getWeight()`, `getUrlObject()` and `getParent()` read the translated entity values when the site is multilingual. A `restructureTree` menu-tree manipulator is unshifted to the front of the system, menu-form and Superfish manipulator lists; it re-parents and re-depths the flat tree according to each link's per-language parent, caching the result per menu, language and tree shape (invalidated by the `config:system.menu.<name>` tag). A `removeDisabledLinks` manipulator supports Superfish menus. The module changes structure only — core's own access-filtering manipulator still runs afterward, so access-restricted links stay hidden. Requires no modules beyond core's `menu_link_content`; runs on Drupal 8 through 11. Because a link to an untranslated page is the exact failure this exists to prevent, the value is realised only if the per-language structures are actually curated — an uncurated asymmetric menu is just a symmetric menu with extra configuration.

---

- Give each language its own menu tree structure while keeping one menu.
- Show a menu section in one language and hide it in another.
- Re-parent a menu link differently per language.
- Order menu links differently per language (different weight per translation).
- Enable a menu link for some languages and disable it for others.
- Point a menu link at a different URL depending on the language.
- Serve international applicants and domestic students different navigation on one site.
- Expose a minority-language subset of services without a duplicate menu.
- Vary a product or footer menu by regional market.
- Avoid linking to pages that do not exist in the current language.
- Replace the "separate menu per language + block language condition" workaround.
- Keep shared menu items defined once instead of duplicated across per-language menus.
- Choose granularly (link / order / enabled) which properties become per-language.
- Make menu-link `enabled`, `weight`, `parent` and `link` fields translatable.
- Restructure the rendered tree from per-language parent relationships.
- Provide asymmetric navigation to a Superfish-rendered menu.
- Curate navigation as an editorial decision owned per language.
- Support a bilingual site whose two languages offer different content.
- Reflect a government language policy that ships fewer services in a minority language.
- Give a university's English and national-language sites distinct menu structures.
- Let a company's regional language sites carry different top-level sections.
- Keep the block/menu placement unchanged while the structure diverges underneath.
