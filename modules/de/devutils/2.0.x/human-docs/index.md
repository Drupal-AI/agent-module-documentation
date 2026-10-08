# DevUtils — manual setup guide

**DevUtils** (`devutils`) is a small collection of development utility helpers
for people building Drupal sites. It doesn't add anything your visitors will see
— instead it gives developers a few convenience tools for the kinds of chores
that come up during development: listing the UUIDs of entities (with various
filters), cleaning up unused files, and importing specific module configuration
from code (handy from an `update` hook, for example).

Think of it as a developer's aid rather than a site feature. There is no content
type, no block, and no access-control role to manage. It targets Drupal 11 and
has no third-party dependencies.

Because it exists to help during development, treat it as a **development-only
tool** — enable it in your local and staging environments while you work, and
keep it off production sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it in your development environment.

There is **no configuration page** for this module — it provides developer
helpers rather than a settings form. See the project's README for how to call
each utility.

## Where it lives in the admin menu

DevUtils adds no admin settings page. You use its helpers from code (for example
its configuration-import service, called from an `update` hook) or through the
utilities described in the module's README.
