<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Embed Block text filter (`embed_block`)

The entire module is one filter plugin:
`src/Plugin/Filter/EmbedBlockFilter.php`, class `EmbedBlockFilter extends FilterBase implements
ContainerFactoryPluginInterface`.

Annotation:

```php
@Filter(
  id = "embed_block",
  title = @Translation("Embed Block"),
  description = @Translation("Allows to place blocks into content."),
  type = Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE,
)
```

`TYPE_TRANSFORM_IRREVERSIBLE` means the substitution is not reversible into the source text (the
placeholder is replaced by rendered markup on output).

## Install & enable

```bash
composer require drupal/embed_block
drush en embed_block -y
```

Only dependency is core **`filter`** (`dependencies: - drupal:filter` in
`embed_block.info.yml`). No submodules, no permissions of its own, no config objects, no config
schema, no `.module`/`.install`, no routes, no services file, no Drush commands, no libraries.
Installed release documented here: `8.x-1.0-alpha4`; `core_version_requirement: ^9 || ^10 || ^11`.

## Enable the filter on a text format

It is an ordinary text-format filter, so it is turned on per format at
**`/admin/config/content/formats`** (edit a format → check *Embed Block*). This is also the only
access control the module offers: whoever may write in a format that has the filter enabled may use
the `{block:…}` placeholder.

Config equivalent:

```bash
drush php:eval '
$f = \Drupal\filter\Entity\FilterFormat::load("basic_html");
$f->setFilterConfig("embed_block", ["status" => TRUE, "weight" => 0]);
$f->save();'
drush cr
```

The filter has **no settings form** (`FilterBase` default; the class overrides only `process()`),
so the per-format config is just `status`/`weight`/empty `settings`.

## Syntax

Place `{block:PLUGIN_ID}` in the formatted text, where `PLUGIN_ID` is a **block plugin id** (not a
`block` config-entity id). List available ids:

```bash
drush php:eval '
print implode("\n", array_keys(\Drupal::service("plugin.manager.block")->getDefinitions()));'
```

Derivative blocks use the `base:derivative` form, e.g. `system_menu_block:main`,
`views_block:myview-block_1`, `block_content:UUID`.

## How `process($text, $langcode)` works (lines 87-125)

1. Creates a `FilterProcessResult`.
2. `preg_match_all('/{block:(?<plugin_id>[^}].*)}/', $text, $match, PREG_SET_ORDER)` collects every
   placeholder. The pattern is **greedy** (`.*`), so two placeholders on one line can be
   mis-captured into a single match — keep one placeholder per line.
3. For each distinct id (a `$processed` map dedupes repeats so each id is handled once and
   `str_replace` swaps all its occurrences):
   - `$block_plugin = $this->blockPluginManager->createInstance($found[1]);` — instantiated with
     **no configuration**, so a block that normally relies on placement configuration renders with
     its defaults.
   - `if ($block_plugin->access($this->currentUser))` → `$build = $block_plugin->build();` then
     `$block_content = $this->renderer->render($build);`. The block's own access is thus checked
     **against the viewer** (`current_user`), not the author.
   - **Access denied** → `$block_content = ''`; the placeholder is replaced with an empty string
     (silently gone, not shown as a placeholder).
   - `$text = str_replace($found[0], $block_content, $text);`
   - `$response->addCacheableDependency($block_plugin);` — the block **plugin** is recorded as a
     cacheable dependency of the filtered result.
   - **Unknown id** → `createInstance()` throws `PluginException`, which is caught; the raw
     placeholder is **left untouched** in the output.
4. Returns `$response->setProcessedText($text)`.

Injected services (via `create()`): `plugin.manager.block` (`BlockManagerInterface`), `renderer`
(`RendererInterface`), `current_user` (`AccountInterface`).

## Behaviour summary

| Situation | Result |
|---|---|
| Viewer may access the block | Block is built and rendered in place |
| Viewer may **not** access the block | Placeholder replaced with `''` |
| Plugin id does not exist | `PluginException` caught, placeholder left verbatim |
| Same id used several times | Instantiated/rendered once, replaced everywhere |

## Operational notes

- Rendering happens inside the filter, so a block with heavy `build()` logic runs on every uncached
  text render; size embeds accordingly.
- Because it is a text filter, ordering relative to other filters matters (e.g. run before/after
  HTML-restricting filters as appropriate for your format).
- The placeholder is opaque to the editor UI; there is no CKEditor widget — authors type the
  `{block:…}` string directly.
