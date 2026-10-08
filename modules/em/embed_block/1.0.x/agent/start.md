<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Embed Block (embed_block) — agent index

One text filter that replaces `{block:PLUGIN_ID}` with a rendered block. No config beyond enabling
the filter on a text format, no permissions, no schema, no Drush. Requires core `filter`.
Installed release **8.x-1.0-alpha4**.

- **The filter plugin, syntax, per-format enable, and how `process()` works** →
  [plugins/filter.md](plugins/filter.md)

Key facts:
- Filter plugin `@Filter(id = "embed_block", title = "Embed Block")` —
  `EmbedBlockFilter extends FilterBase`, injecting `plugin.manager.block`, `renderer`,
  `current_user`.
- Syntax: `{block:PLUGIN_ID}`. The regex is `/{block:(?<plugin_id>[^}].*)}/` — greedy, so a line
  containing two placeholders can mis-capture; keep one placeholder per line.
- Per match:
  - `createInstance($plugin_id)` with **no configuration** — blocks requiring configuration render
    with their defaults;
  - `if ($block_plugin->access($this->currentUser))` → render; **else replace with `''`**
    (silently empty, not a visible placeholder);
  - `PluginException` (unknown id) → caught, placeholder **left in the text**;
  - repeats of the same id are replaced in one pass (`$processed` map).
- `$response->addCacheableDependency($block_plugin)` — the block plugin is added as a cacheable
  dependency of the filter result.

Enable per format:

```bash
drush cget filter.format.basic_html filters.embed_block
drush php:eval '
$f = \Drupal\filter\Entity\FilterFormat::load("basic_html");
$f->setFilterConfig("embed_block", ["status" => TRUE, "weight" => 0]);
$f->save();'
```

Find plugin ids to embed:

```bash
drush php:eval '
print implode("\n", array_keys(\Drupal::service("plugin.manager.block")->getDefinitions()));' | head -40
```

Notes:
- Any user who can write in a filter-enabled format can embed **any** block plugin; the guard is
  the viewer-side access check, so choose which formats get the filter carefully.
- Because rendering happens inside the filter, blocks with heavy build logic run on every
  uncached text render.
