<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block In Page Not Found — agent index

Adds one block **visibility condition**, "Page not found" (`page_not_found_request`), so any
block can be shown only on 404 responses. No settings page (`configure: null`), no
permissions, no services, no Drush.

- **Place a block on the 404 page: the condition id, the config key, UI + config steps** →
  [configure/place-block.md](configure/place-block.md)

Key facts:
- Condition plugin id `page_not_found_request` (label "Page not found"); one setting
  `page_not_found` (boolean, checkbox "Show in page not found").
- Stored on the block config entity at
  `visibility.page_not_found_request.page_not_found: true`.
- `evaluate()`: if `page_not_found` is truthy, returns TRUE only when the request has a 404
  `exception`; if falsy, returns TRUE always (no restriction). Adds cache context
  `url.path`. Supports core's `negate`.
- Depends on core `block`. Config schema: `condition.plugin.page_not_found_request`.
