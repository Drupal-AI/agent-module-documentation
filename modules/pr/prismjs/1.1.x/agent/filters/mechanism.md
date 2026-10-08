<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# prismjs — filter mechanism

Single filter plugin: `\Drupal\prismjs\Plugin\Filter\PrismJs` (`src/Plugin/Filter/PrismJs.php`),
`id: prismjs`, title "Prism Js", `type: TYPE_TRANSFORM_REVERSIBLE`, `weight: 100`. No filter
settings. Implements `ContainerFactoryPluginInterface` and `TrustedCallbackInterface`
(`trustedCallbacks()` returns `[]`). Injects `renderer` and `plugin.manager.ckedito5_prismjs`
(neither is actually used in `process()` in this version).

## The rewrite (`process($text, $langcode)`)
1. `preg_match_all('/(?<code><prism-js.*?<\/prism-js>)/si', $text, $matches)` — find every
   `<prism-js …>…</prism-js>` block. If none match, return `new FilterProcessResult($text)`
   unchanged.
2. Read `prismjs.settings`; `$theme = $config->get('theme') ?? 'tomorrow-night'`;
   `$library = 'prismjs/prismjs.' . $theme`.
3. For each matched block `$code`:
   - `$source_code = $this->getStringBetween($code, 'data-plugin-config="', '"')` — a plain
     `strpos`-based substring extraction of the attribute value (stops at the **first** `"` after the
     marker, so the stored value cannot contain a literal double-quote; the CKEditor writes the JSON
     with `&quot;`-encoded quotes).
   - If non-empty: `$source_code = html_entity_decode($source_code); $source_code =
     json_decode($source_code);` → `{ text, language }`.
   - `$text_content = $source_code->text ?? ''; $language = $source_code->language ?? '';`
   - `$text_content = htmlspecialchars($text_content);` — **the code text is escaped.**
   - Build the replacement by **string concatenation**:
     ```php
     $replace = '<pre data-src="prism.js" class="language-' . $language . '">'
              . '<code class="language-' . $language . '">' . $text_content . '</code></pre>';
     $text = str_replace($code, $replace, $text);
     ```
   - Wrap in `FilterProcessResult` and `addAttachments(['library' => [$library, 'prismjs/prismjs.custom']])`.
4. Return the `FilterProcessResult`.

## Output markup
```html
<pre data-src="prism.js" class="language-LANG"><code class="language-LANG">ESCAPED_CODE</code></pre>
```
`ESCAPED_CODE` is the code text passed through `htmlspecialchars()`. `LANG` is the `language` value
from the decoded `data-plugin-config` JSON, written into the two `language-…` classes. Prism's client
JS then tokenises based on the `language-LANG` class.

## Attached assets
- `prismjs/prismjs.{theme}` — theme CSS + JS, where `{theme}` is the `prismjs.settings` `theme`
  value (defaults to `tomorrow-night`). Bundled themes: default, dark, funky, okaidia, twilight, coy,
  solarized-light, tomorrow-night. All local to the module.
- `prismjs/prismjs.custom` — `css/prism-custom.css`.

## Notes for agents
- **Reversible filter.** Being `TYPE_TRANSFORM_REVERSIBLE`, the original `<prism-js>` element is what
  is stored; the `<pre><code>` is generated at render time, so double-clicking a block in CKEditor
  re-opens the dialog with the stored language/text.
- The rewrite is produced at **weight 100** (late), and it runs `html_entity_decode` on the extracted
  attribute before rebuilding the markup.
- The `getStringBetween` helper only extracts the **first** `data-plugin-config` per block and returns
  `''` if the marker is missing (that block is then left untouched).
