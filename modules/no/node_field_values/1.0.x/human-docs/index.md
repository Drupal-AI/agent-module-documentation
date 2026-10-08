# Node Values — manual setup guide

**Node Values** (`node_field_values`) is a small **developer utility**. It provides a
service that grabs **all of a node's field values** programmatically, with the
referenced entities for those fields already loaded — saving you the repetitive work
of walking each field by hand. It's aimed at developers who do a lot of preprocessing
on nodes or a lot of "massaging" of node data in code or templates.

There's nothing to click here: the module adds no admin pages, no fields, and no
configuration. Its value is the helper service it exposes for use in your own module
or theme code (for example in a `hook_preprocess_node()` or a controller), where you
hand it a node and get back its field values in one call. It reads field values, so
when you use it you should still respect Drupal's normal field access as appropriate
for the context. It works across Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this is a code‑level helper, described below.

## Where it lives

Node Values adds no admin page or settings. It provides a **service** you call from
PHP — typically from a theme preprocess function, a controller, or another module —
to collect a node's field values (with referenced entities loaded) in one step.

## How to use it

1. Enable the module so its service is registered in the container.
2. In your own module or theme code, obtain the service and pass it a loaded node to
   get its field values back. Consult the sibling [`agent/`](../agent/start.md) docs
   and the project's README for the exact service name and method signature.
3. Use the returned values in your preprocessing or data‑massaging logic, keeping
   normal field access in mind for the context you render them in.
