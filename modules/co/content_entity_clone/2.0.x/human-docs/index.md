# Content Entity Clone — manual setup guide

**Content Entity Clone** (`content_entity_clone`) adds a **Clone** action to content
entities — nodes, taxonomy terms, media, comments, and custom content entity types —
so editors can duplicate an existing item and use it as the starting point for a new
one. "Cloning" here means pre-filling a fresh entity **creation form** with the source
entity's field values; the copy is not saved automatically, so the editor reviews and
saves it like any new entity.

You enable cloning **per bundle**, and for each bundle you decide how each field is
handled — copied as-is, skipped, or transformed by a **field processor**. The module
ships several processors out of the box: copy values, append " [CLONE]" to the label,
deep-clone referenced entities (paragraphs, references), and copy a Layout Builder
layout (deep-cloning its inline content blocks so copies are independent). Developers
can add their own field processors, since they are a real plugin type.

The module needs a little configuration before anything appears: you turn on cloning
for the bundles you want on its overview page, then a **Clone** local task / operation
link shows up on entities of those bundles for users who have permission. It requires
no modules outside Drupal core, and it works with any content entity type that has a
creation form. Two permissions govern it: one to administer cloning configuration, and
one (separate) to actually perform clones.

This 2.0 major requires Drupal `^11.4 || ^12` and PHP `>=8.5`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable cloning per bundle, choose field
   processors, and set permissions.

## Where it lives in the admin menu

The cloning **overview** — which lists the entity types and bundles and lets you
configure each — is at **Configuration → Content Entity Clone**
(`/admin/config/content_entity_clone`). Once a bundle is enabled, the **Clone** action
appears on individual entities of that bundle (as a local task tab and/or an entity
operation link) for users with the *Clone content entities* permission.
