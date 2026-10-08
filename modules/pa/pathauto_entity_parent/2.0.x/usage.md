<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pathauto entity parent adds a "parent" node reference to nodes and prepends the parent's existing URL alias to the child's Pathauto pattern, producing nested aliases like `/parent-node/child-node`.

---

URLs that mirror a site's structure are worth having: `/services/planning/apply` tells a visitor where they are, gives search engines a signal about relationships, and lets a section be recognised at a glance in analytics and logs. Drupal's own tools do not produce this for nodes — Pathauto builds an alias from tokens and a node has no parent to reference, menus express hierarchy for navigation but are not available to the alias pattern, and taxonomy produces `/category/subcategory/title`, a different statement. Core's **Book** module models parents but brings navigation and printing assumptions most sites do not want. This module's answer is narrow and node-only: it installs a single **`pathauto_entity_parent`** entity-reference base field (target: node) on every node, and a settings form at `/admin/config/search/parent` picks which content types show it. The mechanism is not a token — it is a `hook_pathauto_pattern_alter` that, when a node in an enabled bundle has a parent set, looks up the **parent's already-stored alias** in the `path_alias` table and prepends it to the pattern, so the generated alias becomes `{parent-alias}/{normal-pattern}`. Nesting works N levels deep only because each parent's stored alias already embeds its own parent's. Two consequences follow directly. Because the child reuses the parent's *stored* alias, the parent must have an alias before the child is generated, and **changing a parent's alias does not automatically regenerate its children** — the module tracks no dependency, so you bulk-regenerate aliases after moving a page. And because moving a page changes its URL and every descendant's, automatic redirects (the **`redirect`** module) are effectively a prerequisite rather than an optional companion. Version **2.0.0** targets `^11` (Drupal 11 only) and requires `pathauto`, core `node`, and `path`.

---

- Build node URLs that reflect a site's structure.
- Nest a page under a section: `/services/planning/apply`.
- Give a node an explicit parent node.
- Build a handbook or documentation URL hierarchy.
- Reflect page structure in analytics paths.
- Model content hierarchy without adopting the Book module.
- Nest guidance or policy-library pages several levels deep.
- Generate hierarchical aliases from a chosen parent.
- Improve SEO signals carried by the URL path.
- Build a knowledge base's nested paths.
- Nest landing pages under a campaign parent.
- Structure a large brochure site's paths.
- Restrict nesting to specific content types only.
- Relocate the parent picker into the URL-alias section of the node form.
- Tie the parent field to Pathauto's "generate automatic alias" checkbox.
- Clear parent values automatically when a content type is de-selected.
- Produce breadcrumb-like URLs from node relationships.
- Compose a department's page tree.
- Reflect a course outline in its URLs.
- Keep child aliases hierarchical after a bulk alias regeneration.
