<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Access / Content View Access (content_view_access) — agent index

**Maps node/term bundle × role to a canonical-page action (403 / 404 / front redirect / blank) via a kernel REQUEST subscriber.**

- **Version:** 1.0.x
- **Core:** ^10.4 || ^11.1
- **Dependencies:** node, taxonomy, user
- **Route:** `content_view_access.settings` → `/admin/config/people/content-view-access` (requires permission `administer content view access`).
- **Permission declared:** `administer bundle access` (NOTE: mismatches the route requirement above → form reachable only by user 1 until fixed).
- **Service:** `content_view_access.subscriber` (`ContentViewAccessSubscriber`, `KernelEvents::REQUEST` priority 32) — acts only on `entity.node.canonical` and `entity.taxonomy_term.canonical`.
- **Config:** `content_view_access.settings:access[entity_type][bundle][role]`.
- **Security:** NOT a real access control layer — no `hook_node_access` / node access grants / entity access handler. It only blocks two HTML canonical routes; content stays reachable via JSON:API, REST, Views, search, RSS, edit/revision routes. See finding in report. Use for presentation/redirects, not data protection.

See [configure/access-rules.md](configure/access-rules.md)
