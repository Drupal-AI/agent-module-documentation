<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# llms.txt (llmstxt) — agent index

Serves an `/llms.txt` file from a single Drupal config string. `llms.txt` is a proposed
convention (see llmstxt.org) for giving LLMs a curated Markdown map of a site — same spirit
as `robots.txt`, aimed at AI consumers. This module is a fork of RobotsTxt: an admin types
the file body into a textarea, and a controller serves it at `/llms.txt` as `text/plain`.
There is **no crawling of nodes/entities** — the body is whatever the admin (or the one-time
install seed, or `hook_llmstxt()`) puts there.

No dependencies. Core `^9.3 || ^10 || ^11`. **Newest release is 1.0.0-alpha1 — alpha, no
stable exists; not covered by a security advisory policy.**

Configure route: `llmstxt.settings` → `/admin/config/search/llmstxt` (permission
`administer llmstxt`). Public serving route: `llmstxt.content` → `/llms.txt`.

- **Edit the file body / set it via drush or PHP / install-time default** → [configure/settings.md](configure/settings.md)
- **Who may edit it** → [permissions/permissions.md](permissions/permissions.md)
- **How `/llms.txt` is assembled + add lines programmatically (`hook_llmstxt()`)** → [api/serving.md](api/serving.md)

## Key facts
- Config object: `llmstxt.settings`, single key `content` (type `string`). Install value is `''`.
- Serving route `llmstxt.content` is `_access: 'TRUE'` (public) with `_disable_route_normalizer: 'TRUE'`; controller `\Drupal\llmstxt\Controller\LlmsTxtController::content()`.
- Output is `text/plain`, cache tag `llmstxt`, cache context `url.site`. Saving the form calls `Cache::invalidateTags(['llmstxt'])`.
- Extension hook the module invokes: `hook_llmstxt()` (via `invokeAll('llmstxt')`) — returns an array of strings appended after the config body.
- Permission: `administer llmstxt`. Form: `\Drupal\llmstxt\Form\LlmsTxtSettingsForm` (extends `ConfigFormBase`).
- No drush commands, no plugin types, no services. Implements `hook_help()`, `hook_install()`, `hook_requirements()`.
- Runtime requirements: Clean URLs mandatory (else `REQUIREMENT_ERROR`); a physical `llms.txt` in the docroot shadows the route (`REQUIREMENT_WARNING` — delete it).
