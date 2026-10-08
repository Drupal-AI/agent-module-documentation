<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Quicklink loads (mechanism)

No services or classes of note — the logic is three hooks in `quicklink.module` plus a config
form. This doc is the runtime behavior an agent needs.

## Library source: local or CDN

`hook_library_info_build()` defines the `quicklink` library dynamically:

- If `DRUPAL_ROOT/libraries/quicklink/dist/quicklink.umd.js` exists → serve that local copy.
- Otherwise → external `https://unpkg.com/quicklink@3.0.1/dist/quicklink.umd.js`.

So dropping the library under `web/libraries/quicklink/dist/` switches it from CDN to local
automatically; no config toggle. Weight `-20`.

## Attach + decision logic (`hook_preprocess_html()`)

On every HTML page the module:

1. Loads `quicklink.settings` and adds its cache tags (config edits apply immediately).
2. Always seeds the ignore list with `user/logout`.
3. Builds ignore lists from `url_patterns_to_ignore`, `ignore_selectors`, `allowed_domains`,
   `prefetch_only_paths` (each `explode(PHP_EOL)`-split and `\r`-trimmed).
4. Adds `#` to ignores when `ignore_hashes`; adds `/admin` + `/edit` and a set of admin-link
   container selectors when `ignore_admin_paths`.
5. Decides `$load_library`:
   - `no_load_content_types` — if the current route's node bundle is opted out → don't load.
   - `no_load_when_authenticated` + user is logged in → don't load.
   - `no_load_when_session` → adds `session.exists` cache context; if a session exists → don't
     load.
6. If loading (or if debug), attaches `quicklink/quicklink_init` and pushes each option into
   `drupalSettings.quicklink` (`ignore_admin_paths`, `ignore_ajax_links`, `ignore_file_ext`,
   `total_request_limit`, `concurrency_throttle_limit`, `idle_wait_timeout`, `viewport_delay`,
   and the non-empty lists/selector/domains/prefetch-only). The actual `quicklink/quicklink`
   library is attached only when `$load_library` is true; `quicklink/quicklink_debug` is added
   when `enable_debug_mode` is on, along with a `debug_log` array explaining each decision.

## Consequences an agent should know

- Prefetching is purely a front-end / perceived-performance feature — it never changes rendered
  markup or server behavior.
- Debug mode still attaches the init + debug library even when `$load_library` is false, so you
  can see *why* nothing was prefetched.
- The `session.exists` cache context is added whenever `no_load_when_session` is on, so page
  cache varies by whether a session is present.
- `help.page.quicklink` renders `README.md` (via the Markdown module if enabled) — not relevant
  to prefetch behavior.
