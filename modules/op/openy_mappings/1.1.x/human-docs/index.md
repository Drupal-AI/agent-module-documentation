# Open Y Mappings — manual setup guide

**Open Y Mappings** (`openy_mappings`) provides a **Mapping entity type** and the
features around it. It is a building block from the Open Y (YMCA Website Services)
distribution, where it is important infrastructure for the various *syncers* that
import and export data to and from third-party systems such as Personify, Mindbody,
and Daxko — the mapping entity is how the distribution relates its own content to
records in those external systems.

This is infrastructure rather than a feature you switch on and see. On an **Open Y
site** it plays its part in the distribution's data model and is pulled in as a
dependency of the modules that need it. On an **unrelated site** it is simply a
generic mapping-entity primitive — its value depends entirely on what you build on
top of it. It has no notable security surface of its own; the entity type is
governed by standard Drupal entity access.

If you are not building on Open Y, install this only if you specifically need the
mapping-entity primitive it provides and are prepared to build the rest yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form** — it provides an entity type and its features,
not a configuration page. Any use of it happens either through the Open Y syncers
that depend on it or through custom code you write against the mapping entity.

## Where it lives in the admin menu

Open Y Mappings adds no dedicated configuration page. It contributes a Mapping
entity type to the site's data model; on an Open Y site the distribution's syncers
use it, and its entities are governed by standard entity access.

## How to use it

- **On an Open Y site:** it is a dependency of the syncers and other components
  that need to relate Drupal content to external system records — you generally do
  not interact with it directly; it works because those components rely on it.
- **On any other site:** treat it as a low-level mapping-entity building block.
  Enable it only if you have a specific need for that primitive and intend to build
  the surrounding functionality yourself. It has no ready-made UI of its own.
