<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Token Filter renders node entity tokens by the current URL's entity.

---

Node Token Filter provides a **text filter that replaces node (or group) entity tokens using the entity of
the current URL** — so `[node:…]`-style tokens in content resolve against the entity of the page being viewed,
letting shared/block content reference "the current node" dynamically. It depends on core Filter and Token.

Use it to make content reference the current-URL entity via tokens. It is a content-display/filter feature.
Security note: it resolves tokens against the **entity in the current URL** (the page the viewer is already on,
which they can access) and uses Drupal's token replacement (which sanitizes token values), so it doesn't reach
arbitrary entities; still, place it on **trusted text formats** (token-rendering filters generally belong on
editor-controlled formats). It has no access-control role. Enable the filter on a text format.

---

- Replace node/group tokens by current URL entity.
- Resolve [node:…] against the current page.
- Reference the current node dynamically.
- Depend on core Filter and Token.
- Serve shared/block content.
- Use Drupal token replacement.
- Resolve against the current-URL (accessible) entity.
- Not reach arbitrary entities.
- Place it on trusted text formats.
- Have no access-control role.
- Enable the filter on a format.
- Handle node tokens.
- Replace tokens.
- Configure the filter.
- Render tokens.
- Handle the filter.
- Resolve tokens.
- Add token replacement.
- Enable the filter.
- Provide node token filtering.
