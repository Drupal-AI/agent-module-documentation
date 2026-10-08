<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Link Sync helps keep per-language menus in the same shape by mirroring a translated node's menu-link position from its source translation.

---

It targets sites that maintain separate menus per language (e.g. "Main Menu - French", "Main Menu - English") rather than translating a single menu. On a translated node's edit form it adds a "Synchronize" button to the Menu link settings: pressing it calculates the parent and relative tree position that most closely matches the source-translation link, then updates the parent and weight selects on the form via an AJAX call. It relies on the Menu Link Weight module so the *relative* position within the tree is matched instead of just copying a raw numeric weight.

The module is a form/UX helper on standard node edit forms; it has no routes, no permissions and no configuration of its own — access follows the node edit form's own access control. Requires the contributed Menu Link Weight module (and the `menu_link` dependency declared in info.yml) to compute relative positions.
---
- Mirror a menu link's parent from the source translation to a translated node.
- Match the relative tree position of a link across per-language menus.
- Add a Synchronize button to the Menu link settings on translated node forms.
- Update parent/weight selects via AJAX without a full page reload.
- Keep separate per-language menus structurally aligned.
- Avoid manually re-parenting translated menu items.
- Support sites with distinct "Main Menu - <language>" menus.
- Use relative (not absolute) weight matching via Menu Link Weight.
- Reduce editorial effort when adding a translation of an existing node.
- Keep navigation consistent between language versions of a page.
- Recalculate position on demand rather than on every save.
- Work with any content type that exposes menu link settings.
- Complement content_translation where full menu translation is inadequate.
- Sync structure when menu trees are similar but not identical across languages.
- Let editors confirm the proposed parent/weight before saving.
- Apply to newly created translations to place their menu link automatically.
- Fix drifted menu positions after editing the source-language tree.
