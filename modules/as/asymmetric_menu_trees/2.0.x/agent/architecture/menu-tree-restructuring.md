<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: plugin swap, manipulators, caching

Two mechanisms combine: (1) menu links use a subclass that reads **translated** values, and (2) a
tree manipulator **re-parents** the rendered tree per language.

## 1. The menu-link plugin class swap
`AsymmetricMenuLinkContent` (`src/Plugin/Menu/AsymmetricMenuLinkContent.php`) extends core
`MenuLinkContent`. When `languageManager->isMultilingual()`, each override reads the current
translation of the entity instead of the (language-neutral) plugin definition:
- `isEnabled()` → `getEntity()->isEnabled()`
- `getWeight()` → `getEntity()->getWeight()`
- `getUrlObject()` → `getEntity()->getUrlObject()`
- `getParent()` → `getEntity()->getParentId()`
- plus helper `getMenuLinkEntity()` → `getEntity()`

On a single-language site every override falls back to `pluginDefinition[...]`, i.e. core behaviour.

The swap onto this class is applied to the `menu_tree` table's `class` column in four places
(`.module` + `.install`):
- `hook_menu_links_discovered_alter()` — rewrites the discovered `class` for any link whose
  `provider == 'menu_link_content'`.
- `hook_install()` and `hook_update_8101()` — bulk `UPDATE menu_tree SET class=… WHERE class=<core>`.
- `hook_entity_insert()` — on **any** new `menu_link_content` entity, re-runs the same bulk UPDATE
  (a broad, whole-table update fired per insert; correctness-safe, just not surgical).

## 2. The tree manipulators (`src/Menu/MenuLinkTreeManipulators.php`)
Service `asymmetric_menu_trees.menu_tree_manipulators`
(`arguments: ['@language_manager', '@cache.default']`).

**`restructureTree(array $tree)`** — the core of the module. Registered at the **front** of the
manipulator chain by `hook_system_menu_tree_manipulators_alter()`,
`hook_menu_form_menu_tree_manipulators_alter()` and inside `hook_superfish_manipulators_alter()`
(all via `array_unshift`). It:
1. Flattens the nested tree into a keyed `$allTrees` map by an explicit stack walk (no recursion).
2. For each element whose `link instanceof AsymmetricMenuLinkContent`, reads
   `link->getParent()` (the **current-language** parent). Empty parent → promote to top level,
   `depth = 1`; otherwise detach from its old parent and attach under `$allTrees[$parent]`, setting
   the parent's `hasChildren = TRUE` and this node's `depth = parent depth + 1`.
3. Recomputes `hasChildren`: FALSE if a node's subtree is empty, else TRUE only if a child's menu-link
   language is in the current language's fallback candidates
   (`languageManager->getFallbackCandidates()`), else FALSE.

Because core stores one parent/weight per link, only this pass makes the **rendered** tree reflect
per-language parents. Runs before core's other manipulators (which then still sort and access-check).

**`removeDisabledLinks(array $tree)`** — recursively `unset()`s elements whose
`link instanceof MenuLinkBase && !link->isEnabled()`. Appended to the manipulator list in
`hook_superfish_manipulators_alter()` (for the contrib **Superfish** menu renderer, which does not
otherwise honour the asymmetric enabled flag).

## Caching
`restructureTree` caches its output in `cache.default` under
`asymmetric_menu_tree:{menuName}:{langcode}:{md5(serialize(array_keys($tree)))}` — keyed by menu,
current language and the **shape** (set of keys) of the incoming tree. Stored `Cache::PERMANENT`
with tag `config:system.menu.<menuName>`, so editing that menu invalidates it. The cache id is
derived only from menu name, language and existing tree keys — **no request/user input** — so it is
not an injection or poisoning surface.

## What it does NOT do
No entities, fields (beyond flipping core base fields translatable), permissions, REST/routes
besides the settings form, external calls, or template output. It reorders an in-memory tree and
reads already-access-controlled menu-link entities; core's access manipulator still filters the
result.
