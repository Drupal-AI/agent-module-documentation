# Twig Blocks — manual setup guide

**Twig Blocks** (`twig_blocks`) is a small developer/theming module that adds a
`render_block()` Twig function, so a theme template can drop a configured block into
an exact spot in your markup — no theme region required. It is for front-end
developers building component-driven themes who want to compose blocks directly in
Twig rather than through the Block layout / regions system.

With it you can render an existing placed block (a menu, branding, search form,
custom block, views block, language switcher, contact form, and so on) by its
machine ID from inside any template — a page, node, paragraph, Layout Builder
component, or a hand-built hero or footer partial. You can optionally override the
block's label or other settings inline as a second argument.

The module also ships a companion service, `twig_blocks.block_view_builder`, for
custom PHP: it renders a block *plugin* by ID (rather than a placed config block),
running the plugin's own access check and applying runtime contexts and
cacheability. There is no admin UI, no permissions, no configuration schema, and no
dependencies beyond Drupal core.

> **One thing to watch.** When you pass an overrides array to `render_block()`, those
> values are **merged into the block's saved settings and written to the database**
> as the block renders. That is fine for a fixed label, but do **not** feed
> per-request or dynamic values there — they would become the block's permanent
> saved settings. For non-persistent rendering, use the `block_view_builder`
> service instead.

This guide is written for a **human** working in templates and code. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no settings page, so there is no separate configuration guide —
usage is covered in *How to use it* below.

## Where it lives in the admin menu

Nowhere — Twig Blocks has no admin pages, permissions, or settings. Once enabled,
the `render_block()` function is simply available in every Twig template.

## How to use it

### Render a placed block in a template

```twig
{# Render a placed block by its config Block entity ID #}
{{ render_block('block_id') }}

{# Override the label (or any block plugin setting) inline #}
{{ render_block('block_id', {label: 'Example'|t, some_setting: 'example'}) }}
```

`block_id` is the machine ID of a **placed block** (a `block` config entity), such
as your theme's block machine name — not a bare plugin ID. If the ID does not load,
the function simply renders nothing. The output is treated as safe HTML (it is not
auto-escaped). Remember the database-write caveat above when passing overrides.

### Render a block plugin from PHP

When you want to render a block **plugin** by ID with no placed config entity and no
config write, call the service:

```php
/** @var \Drupal\twig_blocks\View\BlockViewBuilder $builder */
$builder = \Drupal::service('twig_blocks.block_view_builder');
$build = $builder->build('system_powered_by_block', ['label' => 'Powered by'], TRUE);
```

The builder instantiates the plugin, injects runtime contexts for context-aware
blocks, runs the plugin's `access()` check (only building content when allowed),
handles title blocks, wraps the output with the standard block theming when you ask
for a wrapper, and attaches the right cacheability.
