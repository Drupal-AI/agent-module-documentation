# Open Y Entity Reference Tweaks — manual setup guide

**Open Y Entity Reference Tweaks** (`openy_er`) is a small, developer-focused module
that supplies **entity reference selection plugins** that behave exactly like
Drupal's default handlers but **do not add a configuration dependency** on the
entities they reference. It comes from the Open Y (YMCA Website Services)
distribution, where it solves a real and painful problem, but it is useful on any
site that ships field configuration.

The problem is specific and instantly recognisable once you have hit it. When an
entity reference field's default value points at a node or a block, Drupal records
that entity as a **config dependency** of the field. Export that configuration and
deploy it to another environment where the entity does not exist, and the import
fails — or worse, deleting the referenced entity silently removes the field
configuration that depended on it. For a distribution that ships field
configuration to sites whose content it cannot know in advance, that is fatal.

The plugins here — `DefaultSelectionNoDependency`, `NodeSelectionNoDependency`,
`BlockSelectionNoDependency` (sharing a `SelectionNoDependencyTrait`) — provide the
same selection behaviour with the dependency calculation suppressed. The field
still references content at runtime; the configuration simply stops claiming it
cannot exist without that content. That makes field config portable across
environments and safe against content deletion.

> **Heads up — this release cannot be installed as shipped.** Its `info.yml`
> declares `drupal:plugin` as a dependency, but `plugin` is **not** a core module —
> it is the contrib project [`drupal/plugin`](https://www.drupal.org/project/plugin).
> The module ships no `composer.json`, so Composer never pulls it in, and `drush en
> openy_er` fails with *"missing its dependency module plugin."* The fix is to
> require `drupal/plugin` yourself before enabling — see
> [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `drupal/plugin` workaround) and enable the module.

This module has **no settings form**. You use it per field on the field's
configuration page, described in "How to use it" below.

## Where it lives in the admin menu

Open Y Entity Reference Tweaks adds no configuration page. You use it from any
entity reference field's settings under **Field UI** (for example **Structure →
Content types → *(type)* → Manage fields → *(reference field)***).

## How to use it

To switch an existing entity reference field to a dependency-free handler:

1. Open the field's configuration page (provided by Field UI).
2. Find the **Reference type** section, which has a **Reference method** selector
   and a set of bundle-limiting checkboxes. **Note which bundles are currently
   ticked.**
3. Change **Reference method** from *Default* to **Default (Open Y)** — the group
   of Open Y handlers this module adds.
4. **Re-tick the same bundles** (the checkbox set is labelled *Content types* for
   nodes, or *Bundles* for other entity types) and submit the form.
5. **Export the configuration** (or the whole feature). Verify the exported field
   config no longer lists dependencies on the individual bundle configs, and make
   sure the module now records a dependency on `openy_er`.

The field will keep working exactly as before at runtime — only the config-level
coupling to specific content is gone.
