# Glint — manual setup guide

**Glint** (`glint`) is a **developer toolkit** that makes it much easier to get at
**entity field values** — especially the awkward ones, like file and media
references. Anyone who has written a preprocess hook to pull a file's URL, name,
size, and MIME type out of a reference field knows how much boilerplate that
takes. Glint collapses that into a single call.

Where you would traditionally load the referenced entity, read its URI, generate a
URL, and gather metadata by hand, Glint lets you write:

```php
use Drupal\glint\Glint;

$file = Glint::service()->get('field_document', $variables['node']);
```

and get back a clean, ready‑to‑use value. The same works for **media
references**, and Glint provides **entity helpers** for pulling many values out of
an entity concisely. For multi‑value reference fields it returns an **entity
helper collection** — an iterable with convenience methods like `first()`,
`second()`, `index(n)`, and `harvest('field_name')` to gather one field's value
across all referenced entities at once.

This is a code‑facing utility, not a site‑builder feature. There is nothing to
configure in the UI — you enable it and then use its API from your theme
preprocess functions or module code. The project's **README** is the fullest and
highest‑quality reference for the API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. Its
value is entirely in the API it exposes to your code.

## Where it lives in the admin menu

Glint adds no admin page. Once enabled, its `Drupal\glint\Glint` service and
helper classes are available to your module and theme code.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. From a preprocess hook or module code, call the Glint service or helper to read
   field values:

   ```php
   use Drupal\glint\Glint;

   $media  = Glint::service()->get('field_featured_image', $node);
   $helper = Glint::helper($node);
   $body   = $helper->get('body');
   ```

3. For multi‑value reference fields, use the returned collection's methods —
   `first()`, `second()`, `index(9)`, or `harvest('body')` to collect one field
   across all referenced entities.

See the module's **README** for the complete set of methods and examples.
