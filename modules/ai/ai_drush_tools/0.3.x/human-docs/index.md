# AI Drush Tools — manual setup guide

**AI Drush Tools** (`ai_drush_tools`) is a set of Drush commands for developers
working on module maintenance and upgrades. It helps you run module upgrade
checks, inspect Drupal.org project metadata, and support upgrade workflows from
the command line — optionally with AI assistance.

It is purely a developer / CLI tool. It has no content of its own, no settings
page, and no access role beyond its permission. You reach for it when you are
assessing whether modules are compatible with a target Drupal version, or
inspecting project information as part of an upgrade effort.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — AI Drush Tools has no admin page or settings form. You use it entirely
through Drush on the command line.

## How to use it

Once enabled, the module adds Drush commands for upgrade checks and Drupal.org
project inspection. To see the exact commands available on your version, run:

```bash
drush list --filter=ai
```

Then run the relevant command against the module or project you are assessing.
The tool is standalone — it has no other Drupal module dependencies — so it is a
lightweight addition to a developer's upgrade toolkit.
