<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consuming a snippet

A snippet is always referenced by its **machine ID**. Three consumer paths, all reading the same
stored value.

## 1. PHP API

```php
// Single value (string) or NULL if the id is unknown/empty.
$text = content_snippets_retrieve('out_of_hours_notice');

// All values, keyed by id.
$all = content_snippets_retrieve_all();

// Raw config access (equivalent, discouraged vs the helper):
$text = \Drupal::config('content_snippets.content')->get('snippets')['out_of_hours_notice'];
```

`content_snippets_retrieve()` returns the **raw stored string** — no filtering. When you print it
yourself, escape/handle it as appropriate for the context (Drupal render arrays and Twig escape by
default; only `#markup`/`|raw`/`Markup::create()` would emit it unescaped, which is on the caller).

## 2. Token

A custom token type `content_snippets` is declared, with one token per defined snippet:

```
[content_snippets:out_of_hours_notice]
```

`content_snippets_tokens()` returns the raw value; core's `Token::replace()` wraps non-Markup
replacements in `HtmlEscapedText`, so the emitted token output is **HTML-escaped** (safe). This
means a `text_format` snippet's markup appears escaped when read through a token — use Twig for
formatted output.

## 3. Twig variable

`hook_template_preprocess_default_variables_alter` publishes a `contentSnippets` map to **every**
template:

```twig
{{ contentSnippets.out_of_hours_notice }}
```

- Plain snippet types (`number`, `textfield`, `textarea`) are plain strings — Twig auto-escapes
  them on print.
- `text_format` snippets are wrapped in `\Drupal\content_snippets\RenderableSnippet`, which
  Twig renders as `#type => processed_text` with the snippet's configured format — i.e. run
  through the text format's filters (safe within that format's trust boundary).

Do not add `|raw` to `{{ contentSnippets.* }}`: for formatted snippets it is unnecessary (already
a renderable), and for plain snippets it would bypass escaping.

## 4. Menu local-task title

`ContentSnippetLocalTask` (a `LocalTaskDefault` subclass) returns
`content_snippets_retrieve($this->pluginDefinition['snippet'])` as its tab title, letting a local
task's label be an editor-controlled snippet. Point a local task definition's `class` at it and
add a `snippet:` key with the snippet id.

## Which path to use

| Need | Use |
|------|-----|
| Output in a template | Twig `{{ contentSnippets.id }}` |
| Formatted (WYSIWYG) output | Twig (token/PHP give escaped source) |
| Inside any token-aware field/setting | `[content_snippets:id]` |
| Custom PHP / services | `content_snippets_retrieve('id')` |
| Editor-controlled tab title | `ContentSnippetLocalTask` |
