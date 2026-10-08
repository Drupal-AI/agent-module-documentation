<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A ready-to-run classified-ads marketplace: it defines a `smallad` content entity (with bundle `smallad_type`) for matching offers and wants, organised by a category taxonomy and an optional "types" dimension, and ships the views, blocks and breadcrumbs to browse them.

---

Smallads is aimed at LETS and timebank communities that need to match unused resources with unmet needs, but works as a generic classifieds engine. Enabling it creates two vocabularies — `categories` (hierarchical, yellow-pages style) and `smallads_types` (offers/wants/notices, surfaced as tabs) — and generates three views (all offers, all wants, and each user's own ads). Each ad carries a *visibility scope* and an *expiry date*: after expiry an ad reverts to private scope, visible only to its owner and users with elevated permission. A nested-categories navigation block supports drilling into a hierarchical vocabulary, and a custom search plugin indexes ads.

Access is permission-driven: `view smallad`, `post smallad` (create and manage one's own ads) and `edit all smallads` (moderate/prune the catalogue) — all marked `restrict access`. Admin routes under `/admin/structure/smallads` (settings, type add/edit/delete) require `administer site configuration`. The entity has its own access-control handler and a `SmalladIsVisible` validation constraint. The module is explicitly "plug in and go" and not meant to be built on or heavily overridden. It has hard dependencies on contrib `shs`, `chosen` and `taxonomy_entity_index`, and pulls in `contact` via `hook_install`. Submodules extend it: `smallads_group` (Group integration), `smallads_mcapi` (Community Accounting / mutual-credit), and `smallads_murmurations` (Murmurations network publishing). A Devel Generate plugin and a D7 migration source are included.

---
- Stand up a community offers-and-wants marketplace with one enable
- Let members post their own small ads (`post smallad` permission)
- Organise ads under a hierarchical category vocabulary
- Add a second classification dimension via the `smallads_types` vocabulary (tabs)
- Browse all offers and all wants through the generated views
- Show each user their own ads listing
- Give ads a visibility scope (public/private/…) per ad
- Auto-expire ads to private scope after their expiry date
- Moderate or prune the whole catalogue with `edit all smallads`
- Add the nested-categories navigation block to a region
- Search ads through the provided smallad search plugin
- Configure module behaviour at `/admin/structure/smallads/settings`
- Create and manage smallad types (bundles) as content-type-like buckets
- Bulk delete ads with the "Delete smallad" action plugin
- Bulk unpublish ads with the "Unpublish smallad" action plugin
- Generate sample ads for testing via Devel Generate
- Migrate legacy Smallads from a Drupal 7 site
- Attach comments to ads (comment dependency)
- Add group-scoped ads with the smallads_group submodule
- Publish ads to the Murmurations network with the smallads_murmurations submodule
- Wire mutual-credit / community-accounting pricing via smallads_mcapi
- Use tokens in ad-related text via the token dependency
