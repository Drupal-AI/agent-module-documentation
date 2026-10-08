<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advertisement JavaScript content (ad_content_js) — agent index

**Experimental / WIP** submodule adding a JavaScript advertisement type to `ad_content`. Package
`Advertisement`. Core `^11`. `lifecycle: experimental`. Depends on **`ad_content`, `text`**.
License GPL-2.0-or-later. Release 11.0.0-alpha12.

## What it provides (from source)

- **Bundle `javascript_ad`** ("JavaScript advertisement") for the `ad_content` entity, installed
  from `config/install/ad_content.ad_content_type.javascript_ad.yml`.
- **Field `field_javascript`** — a `string_long` field ("JavaScript code"; its help text tells
  editors *not* to include `<script>` tags), with storage/instance + default form and view displays
  in `config/install/`.
- **No PHP behavior yet.** `ad_content_js.module` is effectively empty: the intended
  `hook_ENTITY_TYPE_view` that would render the stored script into a `<script>` tag is **commented
  out** (marked `@todo` / WIP). So the type persists code but does not execute or output it as
  runnable script. No routes, services, permissions, hooks, or config schema.

## Notes

- Because the rendering hook is disabled, a `javascript_ad` currently displays its field via the
  default `string_long` formatter (escaped text), not as executing script.
- Creating/editing these ads is gated by the standard `ad_content` permissions
  (`create/edit … ads`, per-bundle `create javascript_ad ads`).
- Treat this module as a placeholder for a future network/JS-ad implementation rather than a
  production feature.

See the parent provider docs at `modules/ad_content/11.0.x/` for the entity, permissions, and
serving flow it builds on.
