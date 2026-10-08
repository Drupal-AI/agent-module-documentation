# Entity Template — manual setup guide

**Entity Template** (`entity_template`) lets you create entities from **reusable
templates**. An administrator defines a "builder" with one or more template
blueprints — including tokenised values driven by parameters — and a build UI then
walks a user through choosing parameters, selecting a blueprint, and landing on an
entity edit form that is pre‑filled from the template. It's a fast way to stamp out
new content that follows a consistent shape.

Think of it as a blueprint system for content: define the skeleton once, with
tokens for the bits that vary, and produce new entities from it on demand rather
than copying an existing one by hand each time. It depends on the contributed
**Typed Data** (`typed_data`) module and supports Drupal 9.1+, 10 and 11.

This is a pre‑release module (`1.0.0‑alphaNN`) and is not covered by Drupal's
security advisory policy. Review it against your own requirements before relying on
it in production, and decide deliberately which users should be able to configure
templates and run the build flow.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Typed Data dependency.
2. [Configuration](configuration/index.md) — defining builders and blueprints and
   running the build flow.

## Where it lives in the admin menu

Builders and their template blueprints are defined through the module's admin UI.
The build flow that creates entities from a template lives under
`/entity_template/build/*` (see [Configuration](configuration/index.md)).
