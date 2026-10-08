# Function Filter — manual setup guide

**Function Filter** (`function_filter`) adds a **text-format filter** that replaces
`[function:*]` tokens in your content with the result of a PHP function. It lets
content embed dynamic values that are computed at render time — for example a token
like `[function:current_date]` could print today's date, or `[function:site_name]`
the site name.

Importantly, this is **not** arbitrary code execution. Only functions that a module
has explicitly registered through `hook_filter_functions()` can be called. The
function name in the token is sanitised (anything outside `a-z`, `0-9`, and `_` is
stripped) and looked up in that registry; an unknown name simply does nothing. So a
content author cannot invoke arbitrary PHP — they can only trigger functions a
developer has deliberately allow-listed.

That said, whatever functions you register become callable from any content that
runs through a text format where this filter is enabled. **Enable the filter only on
trusted text formats**, register only safe functions, and remember that the people
who can use those formats are effectively trusted to run the registered functions.

The module works on Drupal 8 through 11 and depends only on core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and turn on the filter for a text format.

This module has **no dedicated settings page** — you enable it per text format and
register functions in code, as described below.

## How to use it

**1. Enable the filter on a text format.** Go to **Configuration → Content authoring
→ Text formats and editors** (`/admin/config/content/formats`), edit a *trusted*
format, and enable the **Function filter** filter, then save. (Where filter order
matters, position it appropriately relative to your other filters.)

**2. Register the functions you want to expose.** In a custom module, implement
`hook_filter_functions()` to allow-list each function and whether its result is
cacheable:

```php
function mymodule_filter_functions() {
  return [
    'current_date' => [
      'function' => 'mymodule_current_date',
      'cache' => FALSE,
    ],
  ];
}

function mymodule_current_date($format = 'r') {
  return date($format);
}
```

**3. Use the token in content.** In text using that format, write
`[function:current_date]`, or pass an argument with a colon, e.g.
`[function:current_date:d.m.Y]`. At render time the token is replaced with the
function's return value.
