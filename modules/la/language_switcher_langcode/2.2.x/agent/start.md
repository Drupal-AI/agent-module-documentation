<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Switcher: Language Code — agent index

One-hook module. Implements `hook_language_switch_links_alter()` to turn the core Language
Switcher block's link text from the language **name** into the uppercased **langcode**
(English → EN), moving the name to each link's `title` (tooltip) attribute. No config, no
admin route (`configure: null`), no permission, no plugin, no schema. Depends on core
`language`.

- **What the hook does, exact behavior, how to reproduce/override it** →
  [api/hook.md](api/hook.md)

Key facts:
- The whole module is `language_switcher_langcode.module` (one function).
- `$link['attributes']['title'] = $link['title']` (name kept as tooltip), then
  `$link['title'] = strtoupper($langcode)`.
- To *see* it, place the core **Language switcher** block (needs ≥2 configured languages with
  URL/interface negotiation). There is nothing to configure on this module itself.
