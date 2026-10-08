<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Block exposes Drupal's block layout to the front end, so blocks placed in regions reach the decoupled site.

---

Block layout is how a Drupal site assembles the furniture around content: a promo in a sidebar, a notice in a header, a language switcher, a menu block. A decoupled front end that ignores it forces all of that into front-end code, which means a site builder can no longer place anything without a deployment.

This submodule keeps the block layer working. Blocks placed in regions, with their visibility conditions evaluated server-side, are rendered as custom elements and delivered to the front end, which maps regions onto its own layout.

Two things follow that are worth planning. **Visibility conditions are evaluated in Drupal**, which is correct — a block restricted by role or path should not be sent to a browser that should not see it — but it also means responses vary by those conditions, so caching has to account for it. And the front end needs a **region mapping**: Drupal's region names are the theme's, and the front end's layout is its own, so the two have to be agreed rather than assumed.

---

- Place a block and have it appear in the front end.
- Keep block layout available to site builders.
- Render a promo block in a sidebar region.
- Show a site-wide notice from a block.
- Evaluate block visibility conditions server-side.
- Restrict a block by role in a decoupled site.
- Restrict a block by path.
- Map Drupal regions to front-end layout.
- Avoid deploying to move a block.
- Render a menu block through the block layer.
- Cache region output correctly.
- Vary block output by visibility condition.
- Debug a block that does not reach the front end.
- Agree region naming with the front-end team.
- Keep furniture configurable in Drupal.