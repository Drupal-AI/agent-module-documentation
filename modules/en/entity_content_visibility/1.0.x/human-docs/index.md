# Entity Content Visibility — manual setup guide

**Entity Content Visibility** (`entity_content_visibility`) is a developer building
block. It provides a **field type and matching field widget** so that other modules
can attach Drupal **block-style visibility conditions** to their own content
entities — the same conditions the core block UI uses (request path, user role,
node/content type, language, and so on).

The problem it solves is narrow but real: core lets you gate *blocks* by condition
plugins through the block visibility UI, but it offers no reusable way to store and
evaluate that same set of conditions against an arbitrary content entity. This module
fills that gap. Its widget renders every context-appropriate condition plugin as
vertical tabs — exactly the form the core block UI builds — and stores the chosen
condition configuration on a single field. Helper classes then let a dependent module
evaluate whether an entity should be shown (all conditions must pass — AND logic) and
expose the correct cache contexts, tags, and max-age so the host entity bubbles
accurate cacheability.

Crucially, **this module has no UI, no routes, no permissions, and no services of its
own.** It is meant to be installed **only as a dependency of another module** — for
example [`popup_entity`](https://www.drupal.org/project/popup_entity) — that actually
attaches the field and acts on it. On its own it does nothing visible. Because the
stored value governs whether an entity is displayed, only editors trusted to edit the
host entity should be able to set this field; access is entirely governed by the host
entity's own edit access. It targets **Drupal 9 and 10** (the last release is from
2023).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (as a dependency).

There is **no configuration page** — the module deliberately exposes no UI, routes,
or permissions.

## Where it lives

Entity Content Visibility adds nothing to the admin menu. It provides a field type and
widget for other modules to use; you interact with it only through whichever module
depends on it (which decides where the visibility-conditions form appears).

## How to use it

- **If you are installing a module that requires it** (such as `popup_entity`), simply
  make sure this module is enabled — the dependent module will place and act on the
  visibility field. When you edit the host entity, you'll see the block-style
  visibility conditions rendered as vertical tabs; set the conditions you want and
  save.
- **If you are a developer**, attach the `entity_content_visibility` field to your
  bundle from your module's install/config, use the `entity_content_visibility`
  widget, and call the module's checker to evaluate visibility and its cache helper to
  bubble cacheability. Note that on Drupal 10 the helper classes reference the removed
  `entity.manager` service, so runtime use may require patching.
