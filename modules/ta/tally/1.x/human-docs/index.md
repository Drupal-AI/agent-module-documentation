# Tally — manual setup guide

**Tally** (`tally`) adds a field that calculates a simple **count per referenced
entity**. In plain terms, it lets an entity display a tally — a number showing how
many times something is referenced, or how many related items an entity has —
without writing any custom code. It is handy for surfacing counts such as votes,
references, or related content directly on your entities.

Tally is a **field / computed-value provider**: you add its field to a content type
(or other entity type) and it produces the count for you. It has no content or
access-control role of its own, and it requires no other Drupal modules. It supports
Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, Tally works like any other field, configured per entity type rather
than from a central settings screen:

1. Go to the entity type's field administration (for example **Structure → Content
   types → *your type* → Manage fields**).
2. **Add a field** and choose the Tally field type.
3. Configure it to produce the count you need, then place and format it on the
   entity's **Manage form display** / **Manage display** tabs as appropriate.

The field then displays the calculated count on that entity.
