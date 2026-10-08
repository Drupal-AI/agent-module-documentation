# Data Structures — manual setup guide

**Data Structures** (`data_structures`) is a developer utility for replacing
loosely‑typed PHP arrays in your code with proper, type‑safe objects. It gives you
two toolsets: **Drush generators** that scaffold value‑object classes for you, and
a set of ready‑made **classes and interfaces** for typed sequences and set
operations that you can use or extend directly.

The motivation is both correctness and performance. Swapping ad‑hoc associative or
indexed arrays for structured objects makes your code more robust and
self‑documenting, and the project's own benchmarks (a million small structures)
found that public/readonly‑property objects were meaningfully faster and used far
less memory than the equivalent associative arrays. Typed sequences trade a little
of that for a reliable, enforced element type.

Concretely you get: a `data-structures:map` generator (a typed key/value class with
public or readonly properties), a `data-structures:typed-sequence` generator (a
typed sequence class with utility methods), immutable sequence base classes for the
common types (`IntImmutableSequence`, `FloatImmutableSequence`,
`StringImmutableSequence`, `ObjectImmutableSequence`, `CallableImmutableSequence`),
and a `Set` class/interface for unique‑element collections with set operations.

This is purely a developer library — it has **no admin UI, no content, and no
access‑control role**. It runs on Drupal 10 and 11, and because it is driven by
Drush generators it requires **Drush 13 or higher**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Drush 13+ required).

There is **no configuration page** for this module — it has no settings form. You
use it from Drush and from your own code, as described below.

## How to use it

**Generate classes with Drush:**

```bash
drush generate data-structures:map              # a typed key/value class
drush generate data-structures:typed-sequence   # a typed sequence class
```

The `map` generator asks whether you want public or readonly properties; the
`typed-sequence` generator produces a sequence class with utility methods. The
generated classes live in your codebase for you to use and adapt.

**Use the shipped classes directly:** extend one of the immutable sequence base
classes (for example `IntImmutableSequence` or `StringImmutableSequence`) to
enforce a typed collection, or extend the `Set` class/interface where you need a
collection of unique elements with set operations.
