# Project Browser Extra Recipes — manual setup guide

**Project Browser Extra Recipes** (`extra_project_browser`) makes your site's own
`extra_*` recipes show up inside Drupal's **Project Browser**, so site builders can
discover and apply them from the same UI they'd use to find contributed projects.
A recipe is a packaged bundle of configuration and features; this module scans your
recipe locations for directories whose names start with `extra_`, reads their name
and description (from `recipe.yml`, plus package metadata from `composer.json` when
present), and adds them as a Project Browser **source**.

It's aimed at teams maintaining private or site-specific recipes in their own
codebase. Rather than remembering recipe names and applying them by command, your
custom `extra_*` recipes appear as browsable, applyable entries alongside
everything else. It complements Project Browser — it doesn't replace it or its
core sources.

There's nothing to configure. Once you enable the module, its **Extra recipes**
source is turned on automatically and your `extra_*` recipes appear in the Project
Browser list. It has no content or access role of its own and depends only on the
core **Project Browser** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That's the whole setup.

There is **no configuration page** — the recipe source is enabled automatically,
so there is no dedicated Configuration guide.

## Where it lives in the admin menu

The module adds no settings page. Its recipes surface in **Project Browser**
itself, where the automatically enabled **Extra recipes** source lists any
`extra_*` recipes found in your codebase.
