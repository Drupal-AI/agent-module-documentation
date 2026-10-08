# Entity Fallback Value — manual setup guide

**Entity Fallback Value** (`entity_fallback_value`) gives you a **fallback
cascade** for entity field values: define a priority chain of fields once, and it
returns the value from the first field that isn't empty. Use field A; if it's
empty, use field B; if that's empty too, use field C.

The problem it solves is the little bit of custom logic you end up repeating
whenever a value could live in one of several optional fields. A classic example:
an entity has *Long description*, *Description*, and *Chapô* fields, and you want
to display whichever one is filled, in that order. Instead of writing PHP in every
template or preprocess hook, you declare the chain once and then read the resolved
"effective" value wherever you need it.

You define fallback chains through a **plugin API** — chains are structured,
reusable PHP plugins rather than a settings screen. Once a chain exists, the
resolved value is available in two convenient ways: as a **token** (so it works
anywhere tokens are supported) and via a **Twig method** (so you can pull it
straight into your templates). It resolves values from your existing fields. It
works on Drupal 8 through 11 with no module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — fallback chains are defined as code plugins,
not through an admin form. See "How to use it" below.

## How to use it

The workflow is developer-oriented:

1. Define a fallback chain by writing a plugin that lists the fields in priority
   order (first non-empty wins).
2. Read the resolved value where you need it — as a **token** (usable anywhere
   Drupal tokens are, such as in other field settings, Metatag, Pathauto, etc.)
   or through the module's **Twig method** in a template.

Because the value comes from fields that already exist on the entity, no extra
storage or migration is involved — the module simply picks the first field with
content each time the value is resolved. The [`agent/`](../agent/start.md) docs
have the compact reference.
