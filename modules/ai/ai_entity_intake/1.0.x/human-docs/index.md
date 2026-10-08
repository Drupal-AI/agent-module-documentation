# AI Entity Intake — manual setup guide

**AI Entity Intake** (`ai_entity_intake`) turns a block of unstructured text —
something someone pasted in, an email, a report — into draft Drupal entities,
with a human reviewer approving each suggestion before anything is saved. It
uses the AI module to read the text, work out what entities it describes, and
propose values for the fields you allow it to fill.

The flow is built around a **review-to-draft** safety principle: the AI never
writes content on its own. A user pastes text into an intake, the module queues
it for background extraction, the AI produces suggestions, and a reviewer then
opens each suggestion and decides whether to use or dismiss it. When they choose
"use", Drupal's normal add form opens pre-filled with the AI's values, so the
reviewer saves an ordinary draft entity — and every standard entity access check
still applies.

You control exactly what the AI is allowed to touch through two config entities.
**Entity definitions** describe a target entity type, bundle and the fields the
AI may populate. **Intake profiles** scope which definitions a given profile may
create and mint a per-profile permission so you can decide which roles submit
intakes against it. A multi-pass extractor resolves which AI provider and model
to use (profile override, then module default, then the AI module's default) and
can optionally match against existing entities to catch duplicates.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and choose which optional submodules you need.
2. [Configuration](configuration/index.md) — the settings form, entity
   definitions, intake profiles, permissions and the full intake-to-draft
   workflow.

## Where it lives in the admin menu

- **Settings:** Configuration → AI → Entity Intake
  (`/admin/config/ai/entity-intake`).
- **Entity definitions:** `/admin/config/ai/entity-intake/definitions`.
- **Intake profiles:** `/admin/config/ai/entity-intake/profiles`.
- **Intakes (content):** `/admin/content/ai-intake`.

## How to use it

Once a definition and a profile exist, a user who holds that profile's
permission creates an intake and pastes in the source text. Cron runs the
extraction queue and the AI produces suggestions. A reviewer opens the intake's
review screen, dismisses suggestions they don't want, and uses the ones they do
— landing on a pre-filled add form where they save a draft. Failed or dismissed
intakes can be requeued for another attempt. Full details, including the
permission matrix, are in [Configuration](configuration/index.md).
