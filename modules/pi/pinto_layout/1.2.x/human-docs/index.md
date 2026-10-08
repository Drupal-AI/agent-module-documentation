# Pinto Layout — manual setup guide

**Pinto Layout** (`pinto_layout`) turns [Pinto](https://www.drupal.org/project/pinto)
objects into Drupal **layouts**. It automates the creation of Layout Discovery
layouts — the ones Layout Builder and other layout-aware features use — by
discovering your Pinto objects and mapping them to layout plugins for you, so you can
define a layout's regions in typed PHP rather than in a `*.layouts.yml` file.

In practice you write a Pinto object whose properties are marked as **regions** (with
a `#[Region]` attribute), pair it with a Twig template that outputs each region, and
after clearing the container the object becomes available as a layout you can use in
Layout Builder. The module also supports several variations: customising the layout
ID and label, using an interface instead of the `#[Region]` attribute (so you can
keep constructors private or custom), and even nominating an object you do not own as
a layout by supplying its regions and a factory method.

Pinto Layout is a **theming and site-building tool for developers**. It registers
layout plugins and has no content or access-control role. It depends on the base
`pinto` module and core's Layout Discovery. One setup detail is important: layouts
that use Pinto's `RegionAttributes` require you to allow certain classes in the Twig
sandbox via your `settings.php` — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and add the required `settings.php` line.

There is **no configuration page** — Pinto Layout is a code-first developer tool. You
define layouts by writing Pinto objects, not through an admin form.

## How to use it

Broadly:

1. Set up and configure a Pinto object as usual.
2. Mark the object's region properties with the `#[Region]` attribute, and include a
   `RegionAttributes` property.
3. Write the matching Twig template that outputs each region.
4. Add the required `twig_sandbox_allowed_classes` entries to `settings.php` (see
   [Installation](installation/index.md)).
5. Clear the container/cache (`drush cr`). The object is now available as a layout for
   Layout Builder.

The module ships example test code demonstrating custom layout IDs, custom labels,
the interface-based alternative to `#[Region]`, and wiring up objects whose code you
do not control. See the [official Pinto Layout documentation](https://www.drupal.org/project/pinto_layout)
for the full set.
