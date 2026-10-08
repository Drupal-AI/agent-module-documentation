# Using Dbug::debug()

The module is one class, `Drupal\dbug\Dbug`. There is no service, route, or config.

## Signature

```php
Dbug::debug(mixed $var, string $forceType = "", bool $bCollapsed = FALSE): string
```

- `$var` — the variable to dump.
- `$forceType` — force interpretation: `"array"`, `"object"`, or `"xml"`. Anything else is
  ignored and the real type is auto-detected. **Required when passing an XML string or file**
  (`Dbug::debug($xmlString, "xml")`), because a string is not otherwise parsed as XML.
- `$bCollapsed` — when `TRUE`, tables render collapsed (rows hidden, header italic) so you
  click to expand.

Returns a `Markup` string of nested HTML tables. It **returns** — it does not print. You can
also `new \Drupal\dbug\Dbug($var)` directly, but `Dbug::debug()` is the intended entry point.

## Typical use in a render array

```php
$output['dump'] = [
  '#type' => 'markup',
  '#markup' => \Drupal\dbug\Dbug::debug($someVariable),
  '#attached' => ['library' => ['dbug/dbug']],
];
```

Attach the `dbug/dbug` library so `css/dBug.css` styles the tables and `js/dBug.js` provides
the click-to-toggle behavior (`dBug_toggleTable` / `dBug_toggleRow`). Without the library the
markup still renders, just unstyled and non-collapsible.

## How each type renders (what to expect in the output)

| Input type | Output |
|---|---|
| array | `<table … class="dBug_array">`; one row per key; scalar values printed inline; `[empty string]` for blanks |
| object | `class="dBug_object"`; one row per property, then each method listed as `[function]` |
| boolean | the literal text `TRUE` or `FALSE` |
| NULL | the literal text `NULL` |
| resource (db / gd / xml) | a specialized `class="dBug_resource…"` table (rows/fields, image width/height/colors, or parsed XML) |
| scalar (string/int/float) | a simple one-cell table |

Nested arrays/objects recurse; a value already seen on the current branch is shown as
`*RECURSION*` (or `*RECURSION* -> $ClassName` for objects) instead of infinite-looping.

## Notes / gotchas

- The variable-name label in the header only resolves when you use the `new dBug($var)` form
  from a file it can read; via `Dbug::debug()` the header is typically just the type name.
- XML dumping uses PHP's `xml_parser_*` extension and `eval()` internally — pass a valid XML
  string/file and always with `$forceType = "xml"`.
- This is a dev tool: don't leave `Dbug::debug()` output in production render code.
