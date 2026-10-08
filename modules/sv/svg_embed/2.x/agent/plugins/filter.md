<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SVG Embed filter (`svg_embed`)

The module's entire behavior is one filter plugin plus one helper service. There is no settings
form, no config object, no routing, and no permission.

## Install / enable

1. `composer require drupal/svg_embed` (pulls `enshrined/svg-sanitize`; needs `ext-dom`,
   `ext-simplexml`), then enable the module (`drush en svg_embed`).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`admin/config/content/formats`), edit a format, and tick **"Embed and translate SVG images"**.
3. Put the SVG Embed filter **last** in that format's filter processing order so no later filter
   rewrites the emitted `<svg>` markup.
4. Upload SVGs as normal managed files (field upload, media library, CKEditor embed, etc.).

## The filter plugin

`src/Plugin/Filter/SvgEmbed.php`, class `SvgEmbed extends FilterBase implements
ContainerFactoryPluginInterface`.

- `@Filter` metadata: `id = "svg_embed"`, title *"Embed and translate SVG images"*,
  `type = TYPE_TRANSFORM_IRREVERSIBLE` (output is not stored; recomputed each render).
- Dependencies injected via `create()`: `entity_type.manager` and `svg_embed.process`.
- `process($text, $langcode)` returns a `FilterProcessResult`. It only does work when the text
  contains `data-entity-type="file"`, `data-entity-type="media"`, or a `[svg:` token.

### Three reference syntaxes

1. **CKEditor / inline file embed** — `Html::load()` + XPath
   `//*[@data-entity-type="file" and @data-entity-uuid]`; a node is handled only if its
   `tagName === 'svg'`. The node is replaced with a `<svgembed>UUID</svgembed>` placeholder.
2. **Media embed** — XPath `//*[@data-entity-type="media" and @data-entity-uuid]` limited to
   `drupal-media` nodes. Loads the media by UUID, reads `getSource()->getConfiguration()
   ['source_field']`, resolves that field's `target_id` to a `File`, and **skips unless the
   file's `filemime` contains `svg`**. Then placeholder as above.
3. **Text token** — `while (mb_strpos($text, '[svg:'))` extracts the id: numeric → `File::load($id)`,
   otherwise `entityTypeManager->getStorage('file')->loadByProperties(['filename' => $id])`.
   Missing file ⇒ placeholder value is the literal string *"SVG not found"*.

Each distinct file UUID is resolved exactly once (`$processed_uuids` cache), then every
`<svgembed>UUID</svgembed>` placeholder is `str_replace()`d with the produced SVG and set via
`$result->setProcessedText()`.

## The processor service (`svg_embed.process`)

`src/SvgEmbedProcess.php` (`SvgEmbedProcessInterface::translate(string $uuid, string $langcode):
string`). Constructed with `entity_type.manager`, `module_handler`, `database`
(`svg_embed.services.yml`).

- `loadFile($uuid)` — `loadByProperties(['uuid' => $uuid])` on file storage, then
  `file_get_contents($file->getFileUri())`. The raw file content is passed through
  `enshrined\svgSanitize\Sanitizer::sanitize()` **before** it is parsed into a
  `SimpleXMLElement`. Only managed-file URIs are read — nothing from the request or config.
- `translate()` — calls `loadFile()`; if `moduleHandler->moduleExists('locale')`, runs
  `embedTranslate()`, then returns `substr($svg, strpos($svg, '<svg'))` (drops any leading XML
  declaration/comments).
- `embedTranslate($xml, $langcode)` — recurses the SVG DOM; for each `<text>`/`<tspan>` string it
  looks up a translation with a parameterized query joining `locales_source`/`locales_target`
  filtered by `s.context = 'svg_embed'` and `t.language = $langcode`, substituting the translated
  string when one exists.

## Translating SVG strings

Strings inside embedded SVGs are collected into interface translation under the **`svg_embed`**
string context. Translate them through core locale's interface-translation UI / PO import for
each enabled language; on render, `embedTranslate()` swaps each matching string for its
translation in the current `$langcode`.

## Operational notes

- Because the filter is `TYPE_TRANSFORM_IRREVERSIBLE`, the inline SVG is produced on every
  uncached render — translation always reflects the current language and current file contents.
- Keep the filter last in the order; other HTML filters can otherwise mangle the SVG markup.
- No admin UI beyond the per-format filter checkbox — nothing to configure or export.
