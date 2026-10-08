# Harmonize — manual setup guide

**Harmonize** (`harmonize`) is a developer framework that preprocesses your
Drupal entities into one clean, predictable Twig variable called `harmony`.
Drupal already hands your content to templates, but reaching individual field
values — especially values buried inside nested entities such as paragraphs or
referenced media — often means wading through deep render arrays. Harmonize does
that work up front: once you enable preprocessing on a bundle, every rendered
entity of that bundle arrives in the template with a tidy `{{ harmony }}` array
you can read straight through.

It is aimed squarely at development teams, and it was originally built to make
collaboration between back-end and front-end developers smoother — everyone
works against the same consistent data shape. Alongside the `harmony` variable
it adds reusable field-render **Styles**, an **Entity Processing Rules** admin
UI, an event system so other modules can reshape the harmonized output, a Twig
extension, a dedicated cache bin, and a **Visualizer** for inspecting the
structure it produces.

One important caveat, straight from the module's own README: Harmonize is
**nearing end-of-life**. Version 4.2 is planned as the final release (focused on
performance), and the maintainers now steer new projects toward a successor
called *Glint*. The module also warns that heavy use can add a meaningful
performance cost because it strays from standard Drupal rendering practices.
Weigh that before adopting it on a new build.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus any optional submodules).
2. [Configuration](configuration/index.md) — turning on preprocessing per
   bundle, defining Styles and Entity Processing Rules, and the cache settings.

## Where it lives in the admin menu

Harmonize adds an administration area under **Configuration → Harmonize**
(`/admin/config/harmonize`). From there you reach its global settings, the
Entity Processing Rules add/edit screens, the cache configuration form, and the
Visualizer. Per-bundle preprocessing is switched on from each content type (or
other entity bundle) via a **Harmonize settings** section on the bundle edit
form and a **Manage preprocessing** tab. Every one of these admin surfaces
requires the core **Administer site configuration** permission.

## How to use it

The everyday workflow is: enable preprocessing on the bundles you care about,
choose which fields are harmonized on the **Manage preprocessing** tab, then read
the resulting `{{ harmony }}` array in that bundle's Twig template instead of
digging through the default render arrays. Developers can also define reusable
**Styles** for how particular fields render, subscribe to Harmonize's events to
alter the output from custom code, and call the `harmonize` service directly. See
[Configuration](configuration/index.md) for the details.
