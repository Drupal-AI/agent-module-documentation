# Tamper — manual setup guide

**Tamper** (`tamper`) is a generic plugin system for transforming — "tampering" —
data values as they pass through a pipeline. Each Tamper plugin takes an input
value, manipulates it (trim, find/replace, cast, encode, do math, and dozens more),
and returns an output value. It is most famously used by the **Feeds** module to
clean up imported data field by field, but any module can consume it.

On its own, Tamper has **no user interface and nothing to configure** — it is a
developer toolkit that other modules build on. When you install Feeds, for example,
Feeds uses Tamper to let site builders chain transformations onto each source field
of an import (strip HTML, then trim, then convert case, and so on). Tamper simply
provides the catalogue of transformations and the machinery to run them.

Out of the box it ships around 45 ready-made plugins covering text (trim,
find/replace, regex, strip tags, truncate, sprintf, case conversion,
transliteration), numbers (math, number formatting, cast to int), encoding (URL and
HTML entity encode/decode, hashing, base64), arrays (explode, implode, unique,
filter, aggregate), and control-flow helpers (required, skip on empty, default
value). Each plugin is configurable, and plugins can throw special exceptions to
skip a single value or an entire item mid-pipeline.

Tamper has no dependencies beyond Drupal core (10.2 or 11), no permissions, and no
config of its own. Developers extend it by writing a new plugin in the **Tamper**
plugin type. This guide is written for a **human**, but because Tamper is developer
infrastructure with no admin screen, the practical detail lives in the sibling
[`agent/`](../agent/start.md) docs — an AI coding agent should read those directly.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (usually as a companion to Feeds).

## Where it lives in the admin menu

Tamper adds **nothing to the admin menu** — there is no settings page. You never
interact with Tamper directly; you interact with it *through* a consuming module.
The most common one is **Feeds**, where each source field of a feed type gets a
"Tamper" section for adding and ordering transformations.

## How to use it

There are two audiences:

**Site builders** use Tamper through Feeds. After installing both modules, edit a
Feed type's mappings and, on any source field, add one or more Tamper plugins to
build a cleaning pipeline — for example *Strip tags → Trim whitespace → Truncate to
255 characters*. The plugins run in order, each receiving the output of the last.

**Developers** either write a custom Tamper plugin or apply tampers in their own
code. To add a transformation, create a plugin in your module's `Plugin/Tamper/`
directory extending `Drupal\tamper\TamperBase` and implementing `tamper()`. To run
a tamper programmatically, use the `plugin.manager.tamper` service to create an
instance (passing a `SourceDefinition`) and call its `tamper()` method:

```php
$manager = \Drupal::service('plugin.manager.tamper');
$plugin = $manager->createInstance('find_replace', [
  'source_definition' => new \Drupal\tamper\SourceDefinition([]),
  'find' => 'foo',
  'replace' => 'bar',
]);
$result = $plugin->tamper('foo baz'); // -> 'bar baz'
```

See the [`agent/`](../agent/start.md) docs for the full list of built-in plugin ids,
the plugin interface contract, the manager API, and the control-flow exceptions.
