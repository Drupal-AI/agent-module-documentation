<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Custom Tag cache on a view

There is **no admin settings form and no `configure` route** for this module. You configure it
per view display, inside the view itself.

## In the Views UI
1. Edit the view at `/admin/structure/views/view/{view_id}`.
2. In the display, open **Advanced → Other → Caching** and click the current value.
3. Choose **"Custom Tag based"** (this is the `custom_tag` plugin) and Apply.
4. In the plugin settings:
   - **Custom tag list** — one cache tag per line (e.g. `my_module:report`). These are merged
     onto the view's cache tags; the view stays cached until one of them is invalidated.
     Twig is allowed here (see tokens below).
   - **Rendered output** — TTL for the rendered HTML: *Unlimited (tag-based only)*, a preset
     interval (1 min → 6 days), or **Custom**.
   - **Custom expression** (only when *Custom* is chosen) — a `strtotime()` string evaluated to
     a TTL relative to now (e.g. `+1 hour`, `tomorrow 6am`). Must resolve to a future time.
5. Save the view.

## What ends up in view config
The display's `cache` section (in `views.view.{id}` config) looks like:

```yaml
display:
  default:
    display_options:
      cache:
        type: custom_tag
        options:
          custom_tag: "my_module:report"        # newline-separated list
          custom_tag_output_lifespan: !!str '0' # Cache::PERMANENT ("0") = tag-only; or seconds; or "custom"
          custom_tag_output_lifespan_expression: ''  # strtotime() string when lifespan == "custom"
```

- `custom_tag_output_lifespan` is `Cache::PERMANENT` (`"0"`) for tag-based-only, or one of the
  preset second counts (`60`, `300`, `1800`, `3600`, `21600`, `518400`), or the literal
  `custom` when a `strtotime()` expression is used.
- Setting it on **default** applies to all displays unless a display overrides caching.

## Set it with Drush (instead of the UI)
Edit the view config directly, then rebuild:

```bash
drush php:eval '
  $v = \Drupal::configFactory()->getEditable("views.view.my_view");
  $v->set("display.default.display_options.cache", [
    "type" => "custom_tag",
    "options" => [
      "custom_tag" => "my_module:report",
      "custom_tag_output_lifespan" => "0",       // tag-based only (Cache::PERMANENT)
      "custom_tag_output_lifespan_expression" => "",
    ],
  ])->save();
'
drush cr
```

## Tokens (Twig) in the tag list
The tag list is run through the view style's `tokenizeValue()`, so **contextual filter
(argument) values** can be interpolated to produce per-argument tags:

- `{{ arguments.FIELD }}` — the argument's *title* (validated/label) value.
- `{{ raw_arguments.FIELD }}` — the argument's *raw input* value.

Example: a view with a `type` contextual filter and tag list `node:type:{{ raw_arguments.type }}`
caches each `.../type/article` and `.../type/page` request under its own tag. Twig can also emit
several lines to turn one multi-value argument into multiple tags.

## Behavior notes
- The plugin removes the entity-type **list** cache tags (e.g. `node_list`) that core's Tag
  plugin would add, so unrelated saves of that entity type no longer flush the view. Only your
  custom tags (plus non-list tags) trigger invalidation. You must bust the cache yourself — see
  [../api/cache-invalidation.md](../api/cache-invalidation.md).
- With lifespan *Unlimited*, invalidation is purely tag-driven. A TTL adds a time safety net.
