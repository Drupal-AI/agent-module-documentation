Cache Debugger is a one-checkbox admin tool that turns Drupal's render/Twig cache debug output on or off without hand-editing `sites/default/services.yml`.

---

Cache Debugger adds a single settings form at `/admin/config/development/cache-debugger` (permission `administer cache debugger configuration`). Saving with the box checked creates `sites/default/services.yml` from `default.services.yml`, flips `debug: false` to `debug: true`, and flushes all caches; unchecking it deletes `sites/default/services.yml` and flushes again. With debug enabled, Drupal's Twig/render layer wraps every rendered element in HTML comments that list its cache tags, contexts, keys and max-age, so you can inspect why a fragment is (or is not) cached. It is a development-only convenience — the form itself warns it should never be enabled on production because cache debugging carries a significant performance cost. The module ships no schema, no services, no plugins, no Drush commands, and no submodules; it only stores the boolean `cache_debugger.settings:cache_debug` and manages the one YAML file.

---

- Turn render-cache debug output on for a local/dev site without editing `services.yml` by hand.
- Inspect the cache tags attached to a rendered block, node, or view.
- Inspect the cache contexts (per-user, per-permission, per-URL, etc.) that vary a render array.
- See the cache keys and max-age of a cached element in the page source.
- Diagnose why a fragment is not being cached (missing keys, `max-age: 0`).
- Diagnose why a fragment is over-cached or stale (wrong or missing cache tags).
- Debug custom block plugins whose `#cache` metadata you are unsure about.
- Verify that a custom render element bubbles the cache metadata you expect.
- Teach or demonstrate Drupal's cache-metadata system using real page output.
- Toggle debug on, reproduce a caching bug, then toggle it off — all from the UI.
- Quickly restore a clean `services.yml` state by unchecking the box (removes the file).
- Confirm a `cache_tags` invalidation is reaching the element you changed.
- Check whether a theme override or preprocess hook is stripping cache metadata.
- Investigate Views caching by reading the emitted cache-context comments.
- Compare cache behavior before/after a config change by flipping the toggle.
- Onboard a new developer to render caching without walking them through YAML edits.
- Keep cache debugging out of version control (the file is created/removed on the fly, not committed).
- Audit that anonymous vs. authenticated renders differ only where cache contexts say they should.
- Support a dev workflow where `services.yml` is normally absent and only appears while debugging.
- Restrict who can toggle debug output by granting the module's dedicated permission to trusted roles only.
