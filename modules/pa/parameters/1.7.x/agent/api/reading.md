<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading parameters: tokens, Twig and the PHP API

All three front-ends resolve through `ParameterRepository` (service `parameter.repository`), so the
context-and-fallback rules are identical.

## Resolution and fallback (`ParameterRepository`)

`getParameter(string $name, ...$context)` builds an **ordered** collection list, then returns the
first match:

1. Any `ParametersCollectionInterface` passed in `$context` (explicit target).
2. A collection named in the name itself: `collection_id:param_name` (the part before `:` is loaded
   as a collection id, e.g. `node.article:max_capacity`).
3. The bundle collection of an `EntityInterface` in `$context` — `<entity_type>.<bundle>`.
4. The `global` collection (always appended last unless already present).
5. Anything added by subscribers to `CollectionsPreparationEvent`.

Within each collection the dotted name is walked **longest slug first**, popping trailing segments;
leftover segments are resolved as **properties** on `PropertyParameterInterface` plugins (YAML, HTTP,
Icon) via `getProperty()`. A missing parameter throws `ParameterNotFoundException`.

Disabled collections (`status = false`) are skipped. The first successful read auto-locks the
collection (see `agent/config/collections.md`).

## Tokens (`parameters.tokens.inc`)

Token type `parameter`. Tokens are auto-registered from every collection's parameters
(`hook_token_info`). Forms:

- `[parameter:global:name]` / `[parameter:node.article:name]` — explicit collection.
- `[node:parameter:name]` — chained: reads the node's bundle collection, falls back to `global`.
- `[parameter:name]` — contextual; behaves like `[node:parameter:name]` when a node is available,
  else falls back to `global`.
- Dotted tails address sub-properties: `[parameter:endpoint:foo.bar]`, and Icon supports
  `[parameter:coll:iconname:100:100:#676767]` (width:height:fill).

Rendering: a `RenderableInterface` parameter (Icon) is rendered through the renderer; otherwise the
processed string is emitted as `Markup::create($string_value)`. The parameter plugin is responsible
for producing safe output (e.g. `Text` runs through `processed_text` with a filter format). Cache
metadata (collection list tags + the parameter's own cacheability, e.g. HTTP max-age) bubbles into
the render context.

## Twig `p()` (`ParametersTwigExtension`)

```twig
{{ p('max_capacity', node) }}          {# rendered (renderable for Icon, else markup) #}
{{ p('max_capacity', node, 'value') }} {# raw processed value — use in conditions #}
{{ p('logo')|set_attribute('fill', '#000') }}  {# Icon is a render array, so filters apply #}
```

Passing the literal `'value'` in the context returns `Parameter::value(...)` directly. The function
attaches the collection list cache tags and any cacheable context dependencies to the build.

## PHP API (`Drupal\parameters\Parameter`)

```php
use Drupal\parameters\Parameter;

// Graceful: returns a NullObject plugin when the parameter does not exist.
$p = Parameter::get('max_capacity', $node);
$value = $p->getProcessedData()->getValue();

// Shortcut straight to the processed value.
$value = Parameter::value('max_capacity', $node);

// Strict: throws Drupal\parameters\Exception\ParameterNotFoundException when missing.
$p = Parameter::get('max_capacity', $node, 'strict');
```

`$context` is variadic: pass an entity (its bundle collection is consulted), an explicit
`ParametersCollectionInterface`, and/or the flags `'strict'` / `'value'`. `Parameter::get()` never
returns null — on failure (non-strict) it returns a `NullObject`, whose processed value is an empty
string, so token/Twig callers get a clean empty replacement rather than an error.

## Property-bearing types

- **`yaml`** — decoded nested structure; `getProperty('a.b.c')` returns a `string` parameter for a
  scalar leaf or a nested `yaml` parameter for a subtree (via `NestedArray::getValue`).
- **`http`** — fetches and caches the endpoint; JSON object responses expose keys as properties the
  same way; scalar/array bodies are typed accordingly.
- **`icon`** — properties `value` (raw SVG), `contents` (inner markup), `attributes` (YAML of the
  `<svg>` attributes), or `width.height.fill` to render a sized/filled copy.
