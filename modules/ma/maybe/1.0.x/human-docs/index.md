# Maybe — manual setup guide

**Maybe** (`maybe`) is a small **developer utility** for Drupal. It provides a
wrapper class — loosely based on the "Maybe monad" but tailored to PHP and Drupal —
that lets you chain method calls, property reads, and array access across nested
Drupal entities **without risking a fatal exception**. If any step in the chain is
missing or `null`, the whole chain simply yields `null` instead of crashing.

It's aimed squarely at code that traverses related entities — the classic example
being a theme preprocess function that needs to reach from a paragraph, through a
referenced media item, to a file, to its URL. Normally that means a ladder of
`if ($entity->hasField(...))` checks; with Maybe it collapses to a single readable
chain. You wrap a value with `maybe($object)` (or `new \Drupal\maybe\Maybe($object)`)
and call methods on it as if it were the underlying object; a final `->return()`
extracts the result.

The class guards against the four common ways such traversal blows up: calling a
method on `null`, calling a method that doesn't exist, reading the first element of an
empty array, and accessing a field that isn't on an entity. In each case it yields
`null` rather than throwing. It even special‑cases entities — a `get('field_name')`
call checks `hasField()` first.

Being a pure code utility, Maybe declares **no routes, permissions, services, hooks,
or configuration**, and it never touches request data — the method names it dispatches
come from the developer's own code, not from user input, so there is no untrusted‑input
or web‑exposed surface to worry about.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — including the [API reference](../agent/api/maybe.md).

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings, routes, or admin UI.
It is used entirely from PHP code, as shown in "How to use it" below.

## Where it lives in the admin menu

Maybe adds nothing to the admin menu. It is a code library you call from custom
modules and theme preprocess functions.

## How to use it

Wrap a value, chain your calls, and end with `->return()`:

```php
use Drupal\maybe\Maybe;

// Full class, or the maybe() shorthand:
$output = maybe($entity)->method1()->method2()->return();
```

A real example — get the file URL from a paragraph → media → file chain in one
statement, safely:

```php
$variables['file_url'] = maybe($paragraph)
  ->get('field_media_file')
  ->referencedEntities()
  ->get('field_media_file')
  ->referencedEntities()
  ->url()
  ->return();
```

Besides passing calls through to the wrapped value, Maybe handles a few methods
itself: `->return()` (extract the result), `->property('name')` (read a property
safely), and `->array($key, ...)` (walk array keys with guards). Note that when the
wrapped value is an array and you *don't* use `->array(...)`, the next method applies
to the **first** element.
