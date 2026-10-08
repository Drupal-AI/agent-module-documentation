# Fluent — manual setup guide

**Fluent** (`fluent`) is a developer‑experience library that makes reading values out
of fieldable Drupal entities — nodes, media, taxonomy terms, paragraphs, and the like
— much more concise. Instead of long `->get(0)->value` chains, you resolve a value with
a single "dot notation" path, and multi‑value fields come back as Laravel‑style
collections you can map and filter over.

The headline feature is **dot notation**. A path like `field_media.uid.email` walks the
hierarchy for you: `field_media` is the field, `uid` is recognised as a reference to a
User entity (Fluent loads it automatically from the field definition), and `email`
reads that user's address. Fluent also handles **data‑type conversion** so you get
values in their natural form — booleans as `true`/`false`, dates as `DateTime` /
`DrupalDateTime` objects, integers as integers, links as easy‑to‑read objects, and
lists as arrays or collections. Under the hood it is built on two pluggable resolver
plugin types, so you can teach it how to resolve custom field types.

This is a **code‑only** module. It has no routes, no permissions, no admin UI, and
nothing to configure — you use it by calling its helper (`using($node)->value('title')`)
or its services from your own module, theme preprocess, controller, or migration code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `illuminate/collections` library) and enable the module.

There is **no configuration page** for this module — it is a developer library with no
settings. You use it directly in code, as shown below.

## How developers use it

Read single values with a dot path:

```php
using($node)->value('title');
using($node)->value('body.value');
using($node)->value('body.summary');
using($node)->value('field.link.uri');
```

Traverse references in one call:

```php
// Load the referenced user and read its email.
using($node)->value('field_media.uid.email');
```

The services `fluent.service`, `fluent.field_resolver`, and `fluent.field_item_resolver`
are available for injection, and you can register your own `FluentFieldResolver` /
`FluentFieldItemResolver` plugins to support custom field types. A `fluent_test`
submodule ships purely for the module's test suite — you do not need to enable it.
