# Pinto Block — manual setup guide

**Pinto Block** (`pinto_block`) connects the [Pinto](https://www.drupal.org/project/pinto)
theme-object system to Drupal's custom **content blocks** (`block_content`), so that
the inline blocks you place with **Layout Builder** are built and rendered through a
typed Pinto object instead of the default block build. It gives you a clean, single
place to gather everything needed to display a block's data — while still receiving
the context of the Layout Builder entity the block sits on.

The idea is to move block rendering logic out of scattered preprocess hooks and into
one component object. You declare a bundle class for your content block type, write a
Pinto theme object that assembles the render array against that bundle class's
accessor methods, and link the two with a PHP attribute. At render time, a Layout
Builder event subscriber notices the link and delegates the build to your Pinto
object's `__invoke()` / `pintoBuild()` pipeline.

This is a **developer-facing module with no UI**: no admin pages, no permissions, no
configuration entities. It ships only a small set of PHP building blocks — an
autowired event subscriber, an attribute class, a couple of interfaces, and a context
helper. Because it defines no routes or endpoints of its own, it adds no
request-facing surface: access to blocks remains entirely governed by Layout Builder
and core's Block Content module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — setup is entirely in code. See the developer API
notes in [`agent/api/objects.md`](../agent/api/objects.md) for a full worked example.

## How to use it

The setup is three code steps (all in your own custom module):

1. **Define a bundle class** for your `block_content` bundle — the usual way, via
   core's `hook_entity_bundle_info_alter()`, or with the BCA `#[Bundle]` attribute,
   or a Hux `#[Alter('entity_bundle_info')]` hook. Add accessor methods for the
   fields you want to render.
2. **Create a Pinto theme object** that implements `BlockBundleObjectInterface`
   (using `DrupalObjectTrait` and a `#[ThemeDefinition]` describing its variables).
   Its `create()` factory receives the block, the host entity, and the view mode; its
   `__invoke()` returns the build via `pintoBuild()`.
3. **Link them** by adding the `#[PintoBlock(objectClassName: YourObject::class)]`
   attribute to the bundle class.

After adding or changing these classes, clear the cache (`drush cr`) so Drupal picks
up the attribute. From then on, matching Layout Builder blocks render through your
Pinto object. See the [official Pinto Block documentation](https://www.drupal.org/project/pinto_block)
for more.
