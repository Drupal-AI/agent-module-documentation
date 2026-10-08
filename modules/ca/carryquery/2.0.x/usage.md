<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query carry

## What it is / when to use

- Preserves (carries forward) selected URL query-string parameters as users navigate the site.
- Use to keep campaign/UTM or state parameters across internal links, GET forms, and generated URLs — without hand-writing JavaScript.
- Also exposes `[link:route:…]` / `[link:path:…]` tokens for links placed in CKEditor content, and integrates with the Token and Token Filter modules.

---

## Install & configure

- Requires `filter`, `token`, and `token_filter`.
- Configure at `admin/config/carryquery` (route `carryquery.config`, permission `administer site configuration`).
- In the settings form, list the query-parameter keys to carry (one per line; a line may use `key|…` extra fields). Optionally enable **Add via javascript** to carry parameters client-side after render instead of server-side.
- For links authored in CKEditor (which the server-side processor does not rewrite), use the link tokens through Token Filter.

---

## Usage & API notes

- 2.0.x is a Drupal 11-compatible major (`core_version_requirement: ^8 || ^9 || ^10 || ^11`), a bump from the 8.x-1.x branch.
- Server-side carrying is done by an outbound path processor (`CarryQueryPathProcessor`, tag `path_processor_outbound`) that appends configured params to internally generated URLs.
- A path-processor-manager decorator (`CarryQueryPathProcessorManager`) supplies the current request to the outbound processor; it is autowired with `#[AutowireIterator]` attributes — the D11-era wiring introduced in this major.
- `hook_form_alter` injects configured params as hidden fields on GET-method forms so submissions keep them.
- Optional JS (`js/carryquery.js`) appends configured params to same-host `<a>` hrefs when the "Add via javascript" option is enabled; keys are passed via `drupalSettings`.
- Link tokens: `[link:route:<route.name>,id=,class=,text=]` and `[link:path:<internal/path>,id=,class=,text=]` render an HTML anchor via `Link::fromTextAndUrl()`; `text=` is the mandatory visible text, multiple CSS classes are pipe-separated.
- Config is stored in the `carryquery.settings` config object (schema provided); keys `carryqueryconfig`, `js`, `keys`, `info`.
- The config form runs `Html::escape()` on the saved textarea value.
- Reflected values are URL-encoded in generated hrefs and HTML-escaped in hidden form fields; `url.query_args` cache context is added where params are reflected.
- No custom permissions — the only endpoint is the admin settings form gated by `administer site configuration`.
- No external services or network calls.
- Menu link provided via `carryquery.links.menu.yml` under Configuration » Search and metadata.
- Parameters are read from the current request's query string; only keys listed in configuration are carried.
- Includes a PHPUnit test for the outbound path processor under `tests/`.
- Uninstall removes the `carryquery.settings` config.
- Server-side (path processor) and JS modes are mutually exclusive — the path processor short-circuits when JS mode is on.
