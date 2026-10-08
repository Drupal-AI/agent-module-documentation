<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Short-link redirect routes

`simple_social_share.routing.yml` + `src/Controller/ShortLinkController.php` (extends
`ControllerBase`). Two GET routes that give nodes and taxonomy terms short, clean shareable URLs.

## Routes

- `simple_social_share.node_short_link` — path `/n/{node}`, controller
  `ShortLinkController::redirectNode`, permission `access content`.
- `simple_social_share.taxonomy_term_short_link` — path `/t/{taxonomy_term}`, controller
  `ShortLinkController::redirectTaxonomyTerm`, permission `access content`.

Both use route parameter upcasting: `{node}` / `{taxonomy_term}` are loaded as entities by the entity
converter (invalid/missing id → 404 from the parameter converter).

## Behavior

- `redirectNode(EntityInterface $node)` → `$this->redirect('entity.node.canonical', ['node' => $node->id()], [], 302)`.
- `redirectTaxonomyTerm(EntityInterface $taxonomy_term)` → `$this->redirect('entity.taxonomy_term.canonical', ['taxonomy_term' => $taxonomy_term->id()], [], 302)`.

Each is a plain 302 redirect to the entity's canonical page — read-only, no state change, no user
input beyond the entity id. The block's `build()` generates these short URLs as the value it hands to
the social-platform share links, so shared links read `/n/123` rather than a long alias.

## Notes

- The `access content` permission is the standard gate for viewing content; it does not itself enforce
  per-entity view access, but since the target is only a redirect to the canonical route, the canonical
  page applies its own entity access on load. The short-link route leaks only whether an id exists to
  users who can access content.
- No config, no CSRF token (safe GET, no mutation), no cache tags added by the controller.
