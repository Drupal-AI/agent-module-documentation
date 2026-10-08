Blocache adds a **Cache Settings** section to every block's configuration form, letting an administrator override that individual block's cacheability metadata — max-age, cache contexts, and cache tags — instead of relying on the defaults set in code.

---

Blocache does not add a settings page; it alters the block configuration form (`block_form`) via
`hook_form_FORM_ID_alter()`, but only for users with the `administer block cache` permission. The
added UI has an **"Override cacheability metadata"** checkbox plus three vertical tabs: **Max-Age**
(a number; `-1` = cache forever, `0` = not cacheable, positive = seconds), **Contexts** (a checkbox
per available `cache_context.*` service, each with an optional argument for parameterised contexts
like `url.query_args:key`), and **Tags** (an add-as-many-as-you-need list of cache tag strings). The
chosen values are stored as **block third-party settings** under the `blocache` namespace:
`overridden` (bool) and `metadata` (`max-age`, `contexts`, `tags`) — validated by the shipped schema
`block.block.*.third_party.blocache`. At render time the module swaps the block entity's view builder
to `BlocacheViewBuilder` (via `hook_entity_type_build()`), which — for blocks where `overridden` is
TRUE — merges the overridden max-age/contexts/tags into the block's `#cache` metadata (using
`Cache::mergeContexts`/`mergeTags`), and triggers the `page_cache_kill_switch` whenever the block's
max-age is `0` so the page it sits on is not fully page-cached. If the `token` module is installed,
cache **tags** may contain tokens, which `BlocacheViewBuilder` replaces per request via the
`blocache.token` service. Services: `blocache` (facade), `blocache.metadata` (reads/writes the
third-party settings), and `blocache.token` (optional token replacement).

---

- Make a specific block not cacheable by setting its max-age to `0`.
- Cache an expensive custom block for a fixed number of seconds (e.g. 3600) regardless of its default.
- Cache a block "forever" (max-age `-1`) so it only invalidates via cache tags.
- Add a `url.path` or `url.query_args` cache context so a block varies per URL/query parameter.
- Vary a block per user role by enabling the `user.roles` cache context.
- Vary a block per language with the `languages:language_interface` context.
- Add a custom cache tag (e.g. `node:5`) so a block is invalidated when that entity changes.
- Attach a config cache tag (e.g. `config:system.site`) to a block that depends on site settings.
- Fix a block that shows stale content by tightening its max-age or adding the right cache tag.
- Fix a block that shows personalised content to the wrong user by adding a missing cache context.
- Force pages containing a real-time block to skip the page cache (max-age 0 → page_cache_kill_switch).
- Use tokens in a block's cache tags (with the token module) to build dynamic, entity-specific tags.
- Tune cacheability of a third-party block that hard-codes unsuitable cache metadata.
- Give a role fine-grained control over block caching via the `administer block cache` permission.
- Standardise cacheability across placed blocks by overriding each block's metadata explicitly.
- Debug caching problems by overriding a block's contexts/tags without editing module code.
- Reduce server load by lengthening the max-age on blocks that rarely change.
- Increase freshness on blocks that change often by shortening their max-age.
- Export a block's overridden cache metadata as config for deployment across environments.
- Combine per-block max-age with contexts and tags to precisely express a block's cacheability.
- Enable/disable an override quickly with the "Override cacheability metadata" checkbox.
