<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# carryquery — agent orientation

- Carries selected URL query-string parameters forward across a site so links/forms keep them; also exposes `[link:route:…]` / `[link:path:…]` tokens (integrates token + token_filter + filter).
- Four carry mechanisms: (1) server-side outbound path processor `src/PathProcessor/CarryQueryPathProcessor.php` appends configured params to internally generated URLs; (2) `hook_form_alter` injects configured params as hidden fields on GET forms; (3) optional client JS (`js/carryquery.js`) appends params to same-host `<a>` hrefs when the "Add via javascript" option is on; (4) link tokens in `carryquery.module`.
- Admin config form `src/Form/QredirectConfig.php` at `admin/config/carryquery` (route `carryquery.config`, `administer site configuration`); config object `carryquery.settings`.
- 2.0.x is a D11-compat major: adds `^11`, and a `path_processor_manager` decorator (`CarryQueryPathProcessorManager`) wired with `#[AutowireIterator]` attributes so the outbound processor receives the current request. See [agent/internals.md](internals.md).
- No anonymous or state-changing endpoints; carried values are URL-encoded in hrefs / HTML-escaped in hidden fields; `url.query_args` cache context is added where params are reflected. No security finding.
- Has tests/, JS, services.yml, menu link, config schema.
