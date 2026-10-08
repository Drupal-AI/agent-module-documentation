# Generated Content — manual setup guide

**Generated Content** (`generated_content`) is a framework for **programmatically
generating content** — nodes, taxonomy terms, users, media, and other entities —
that developers declare in code. Unlike random content generators, it lets you
define *exactly* what to create (and clean up afterwards), so the same content is
produced every time. That reproducibility makes it well suited to demos, automated
tests, local development, and visual‑regression testing where consistency matters.

The module itself does not ship any generators — it provides the harness. You add
generators as small PHP classes with a `#[GeneratedContent]` attribute in your own
module's `src/Plugin/GeneratedContent/` directory, and the module discovers them,
runs them, and tracks the entities they create in a repository so later generators
can reference earlier ones (for example, articles that reference generated tags).

> **This is a developer tool — do not run generation on production.** Generation is
> code authored by developers and meant for dev, test, and CI contexts. Access is
> gated by permission and the Drush/CLI context. The module can also *remove* the
> content it generated, which is how you reset state between runs.

How does it differ from Devel Generate? Devel Generate is about quick, *random*
dummy content; Generated Content is about *specific, reproducible* content you
control — the same known content every time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no traditional settings form — the admin page is an action screen for
running and clearing generation. See "How to use it" below.

## How to use it

- **From the UI:** go to **Configuration → Development → Generated content**
  (`/admin/config/development/generated-content`) to run the generators your
  modules provide, or to remove previously generated content.
- **From Drush:**
  `drush generated-content:create-content {entity_type} {bundle}`.
- **On module install:** if the `GENERATED_CONTENT_CREATE` environment variable is
  set to `1`, content is generated when a module is enabled — for example
  `GENERATED_CONTENT_CREATE=1 drush pm-enable my_module`. You can narrow this to
  specific types with `GENERATED_CONTENT_ITEMS` (a comma‑separated list of
  `{entity_type}-{bundle}` values, e.g.
  `media-image,taxonomy_term-tags,node-page`).

To write your own generator, create a class in your module's
`src/Plugin/GeneratedContent/` directory, add the `#[GeneratedContent]` attribute
(with an `id`, `entity_type`, `bundle`, and optional `weight`), and implement its
`generate()` method. The bundled example submodules
(`generated_content_example1` / `2`) show this in practice, and
`hook_generated_content_plugin_alter()` lets you adjust plugin definitions at
runtime.
