<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Freelinking (freelinking) — agent index

**A text-format filter that converts wiki-style `[[indicator:target]]` markup into links via a pluggable set of indicator plugins.**

- **Version:** 4.0.x
- **Core:** ^10.3 || ^11 · **Depends on:** filter · **Configure:** `filter.admin_overview`
- **Filter plugin:** `Freelinking` (`src/Plugin/Filter/Freelinking.php`), enabled per text format.
- **Service:** `freelinking.manager` (`FreelinkingManager`) — cached plugin manager; add plugins via `#[Freelinking]` attribute / `freelinking.api.php`.
- **Bundled plugins:** Builtin, NodeTitle, Node, User, PathAlias, Search, GoogleSearch, Wiki, DrupalOrg, External, File. Submodule: `freelinking_prepopulate`.
- **Security:** Filter output is gated by text-format access (who may author). The **External** plugin's `scrape` option (default ON) fetches the linked URL server-side via Guzzle (`External::getPageTitle`, `src/Plugin/freelinking/External.php`) to derive a link title. User/email disclosure is permission-checked. No unauthenticated or mutating endpoints.

See [plugins/indicators.md](plugins/indicators.md)
