# dBug for Drupal — manual setup guide

**dBug for Drupal** (`dbug`) is a small developer utility that dumps any PHP
variable as a colored, collapsible HTML table — a Drupal port of ColdFusion's
`cfdump`. Instead of squinting at raw `var_dump()` or `print_r()` output, you get
nested, clickable tables where arrays, objects, resources, and even XML are laid
out key by key and can be expanded or collapsed.

It exists to make on‑page debugging pleasant. Arrays and objects are shown
property by property (objects also list their methods), booleans render as a
clear `TRUE`/`FALSE`, recursive references are detected and labelled
`*RECURSION*` instead of looping forever, and database, GD image, and XML
resources get their own specialised tables. Unlike the original PHP dBug, it does
**not** echo — it *returns* the markup as a string, so you embed it in a render
array and it plays nicely with Drupal's rendering.

This is purely a code‑level tool for developers. It has **no settings page, no
permissions, no routes, no Drush commands, and no configuration** — the entire
module is one class plus a small CSS/JS asset library. It has no module
dependencies and ships no submodules. Naturally, it belongs only on development
environments; don't leave dump calls in production code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — dBug adds no admin pages, menu items, or settings. You use it entirely
from code.

## How to use it

Call the static helper `Dbug::debug()` and place its output in a render array,
attaching the `dbug/dbug` library so the tables get their styling and
expand/collapse behaviour:

```php
$output['dump'] = [
  '#type' => 'markup',
  '#markup' => \Drupal\dbug\Dbug::debug($someVariable),
  '#attached' => ['library' => ['dbug/dbug']],
];
```

The full signature is:

```php
Dbug::debug(mixed $var, string $forceType = '', bool $bCollapsed = FALSE): string
```

- **`$var`** — the variable to dump.
- **`$forceType`** — force how the value is interpreted: `"array"`, `"object"`, or
  `"xml"`. This is **required when dumping an XML string or file**
  (`Dbug::debug($xml, 'xml')`), since a plain string is not otherwise parsed as
  XML. Any other value is ignored and the real type is auto‑detected.
- **`$bCollapsed`** — pass `TRUE` to render the tables collapsed by default (handy
  for large structures), so you click to expand.

Without the `dbug/dbug` library the markup still renders — just unstyled and
non‑collapsible. See the [`agent/`](../agent/start.md) docs for how each data type
renders and a few gotchas.
