# Multiple Definition Files — manual setup guide

**Multiple Definition Files** (`multiple_definition_files`) is a small developer
and theming helper. Out of the box, Drupal expects a theme or module to declare
all of its asset libraries in a single `*.libraries.yml` file and all of its
layouts in a single `*.layouts.yml` file. On a large project those files grow
unwieldy. This module lets you **split those definitions across several files**,
so you can organize a big set of libraries or layouts into smaller, maintainable
pieces instead of one sprawling file.

It changes only *how* those definition files are discovered and loaded — it adds
no content, no editor‑facing features, and has no access‑control role. It depends
on core's **Layout Discovery** module (which handles layout definitions).

There is nothing to configure and nothing to click: once the module is enabled,
you simply create the additional definition files following the naming pattern
your project adopts, and the module loads them all. This is a developer‑facing
build‑time convenience, so its "setup" is really just how you split your own
YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
"No configuration required," as the project itself notes. Once enabled, split
your `*.libraries.yml` and `*.layouts.yml` definitions into multiple files as
your codebase needs.

## How to use it

After enabling the module, organize a theme's or module's asset‑library and
layout definitions across multiple files rather than cramming everything into one
`NAME.libraries.yml` or `NAME.layouts.yml`. The module discovers and loads the
additional files for you, so large definition sets stay readable and easier to
maintain. This is done entirely in code — there is no admin UI involved.
