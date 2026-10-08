<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds per-language "Add content" links under each content type in the Admin Toolbar, for content types whose default language is "Interface text language selected for page".

---

Administration Toolbar - Content languages extends the Admin Toolbar's *Content → Add content → {type}* tree with one extra child link per enabled language, so an editor can start creating a node of that type directly in a chosen language (each link points at `node/add/{type}` with the corresponding language URL prefix). It only adds these links for content types configured with the *"Interface text language selected for page"* default-language option (`language.content_settings.node.{type}:default_langcode = current_interface`), because those are the types whose new-content language follows the URL/interface language. It is a menu-links-only convenience module — a port of *Administration menu - Content languages* for the Admin Toolbar — and does nothing unless the site has more than one enabled language. It depends on Admin Toolbar, Admin Toolbar Tools and core `language`, defines no config, no permissions and no routes of its own.

---

- Start creating an Article in French directly from the toolbar via *Content → Add content → Article → Article (French)*.
- Give editors one-click access to language-specific node-creation forms without visiting the language config or manually editing the URL.
- Speed up multilingual content entry on sites where content language follows the interface/page language.
- Automatically list every enabled language under each eligible content type in the Add-content menu.
- Show the create link with the correct language URL prefix (e.g. `/fr/node/add/article`) so the new node starts in that language.
- Only surface the extra links for content types set to *"Interface text language selected for page"*, keeping the menu clean for single-language types.
- Keep the toolbar unchanged on sites with only one enabled language (the hook returns early).
- Label each link as "{Type} ({Language native name})" using the language's native name for clarity to multilingual editors.
- Preserve the same ordering as the Languages configuration page via per-link weights.
- Reduce mistakes where editors create content in the wrong language by making the target language explicit up front.
- Complement the standard Admin Toolbar Tools *Add content* shortcuts with language-aware variants.
- Help translation workflows by exposing the "create in language X" entry points where translators expect them.
- Work automatically after enabling the module and clearing caches — no configuration screen to fill in.
- Rebuild the links whenever the menu is rebuilt (cache clear) so newly added languages or content types appear.
- Support any node bundle, since the links are generated for every eligible content type.
- Pair with content_translation and language negotiation for a complete multilingual authoring toolbar.
- Provide a lightweight alternative to custom menu-link code for per-language add-content shortcuts.
