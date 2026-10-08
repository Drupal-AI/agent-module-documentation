# Sequences — manual setup guide

**Sequences** (`sequences`) is a small developer utility that gives you back a
database-driven, named ID generator. Drupal used to offer this through
`Connection::nextId()` and a `sequences` database table, but both were deprecated
in Drupal 10 and removed in Drupal 11. This module reinstates the capability as a
proper service with a simple API.

The idea is straightforward: you ask a named sequence for its next value and get a
unique, sequential integer — handy whenever you need gap-free or steadily
increasing identifiers, such as invoice numbers. In code it is a single call:

```php
$next_id = \Drupal::service('sequences.generator')->nextId('my_sequence');
```

You can also configure per-entity-type offsets, which helps avoid ID collisions
when you are syncing entities between separate instances.

This is a **developer building block**, not an end-user feature: it ships no
content, no visible UI, and no admin pages you need to click through — you enable
it and then call its service from your own custom code. It has no module
dependencies and runs on Drupal 10.3 through 11. One thing to keep in mind:
sequential IDs are **predictable by nature**, so do not use them anywhere
unguessability matters for security — reach for random tokens when you need a
secret.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, call the `sequences.generator` service from your custom module and
ask a named sequence for its next value (see the code snippet above). Each named
sequence keeps its own running count. Because this is an API-only module, there is
nothing to configure through the admin interface for basic use — the behaviour
lives in your code.
