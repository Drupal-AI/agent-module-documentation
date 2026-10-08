<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Related Content (drutopia_related_content) — agent index

**Shows content related to the current node based on shared taxonomy terms, by wrapping the Similar By Terms module in a Views block.**

- **Version:** 2.0.x (dev checkout, branch `2.0.x`)
- **Core:** `^10.2 || ^11 || ^12`
- **Package:** Drutopia (config-only base feature)

Installs a `related_content` view (`views.view.related_content`) and an optional block placement (`block.block.views_block__related_content_block_related_content`) shown via Block Visibility Groups. Relatedness is computed by the contributed `similarterms` module from taxonomy terms held in common.

**Requires:** `similarterms`, `drutopia_core`, `block_visibility_groups`, core `node`/`views`.

**Security:** No PHP code, routes, controllers, services or `permissions.yml` — ships only Views/block configuration. Related items respect core node access via the view. No anonymous or mutating endpoints, no dangerous sinks. No security findings.
