# Webform Views Extras — manual setup guide

**Webform Views Extras** (`webform_views_extras`) extends the Webform Views
integration so that, in Views, you can join webform submissions to **any** content
entity type they were submitted from — not just nodes. That means users, taxonomy
terms and your own custom content entities become valid join targets, letting you
build reports like "all submissions submitted to this user profile" or "submissions
grouped by the term page they came from".

Out of the box, Webform Views can relate submissions to the node they were
submitted from. This module removes the node-only limitation. You register which
content entity types you care about through a small admin list, and for each one it
adds an `entity_id_<entity_type>` base field to the webform-submission entity,
back-fills that field from the submission's built-in "submitted from" source (both
for existing submissions on install and for new ones on save), and exposes a Views
**relationship** — "Submitted to: &lt;entity_type&gt;" — plus a matching field,
filter, contextual-filter argument and sort.

The module has no global settings page and adds no permissions of its own; the
admin list is gated by core's **Administer site configuration** permission. It
requires the **Webform**, **Webform Views** and **Views** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The relationships you register are managed at **Structure → Webform submission
relationships** (`/admin/structure/webform_submission_relationships`), which
requires the **Administer site configuration** permission. You then build the
actual reports in the **Views UI** (*Structure → Views*).

## How to use it

**1. Register a relationship.**

1. Go to **Structure → Webform submission relationships**.
2. Click **Add** and choose the **content entity type** the submissions were
   submitted from — node, user, taxonomy term, a custom entity, and so on. Only
   entity types that have a webform-reference field and are not already configured
   are offered, so each type is set up at most once.
3. Save. This stores a `webform_submission_relationships` config entity and wires
   up the base field and Views data for that entity type.

**2. Build a view.**

1. Create a view of **Webform submissions** (via Webform Views).
2. Add the **"Submitted to: &lt;type&gt;"** relationship.
3. Add fields from the joined entity to pull its data into your results, or use the
   `entity_id_<type>` field, filter or argument directly — for example a contextual
   filter on a user page that lists that user's submissions.

To stop targeting an entity type, delete its relationship from the admin list. Note
that the entity type cannot be changed once a relationship is created — only added
or deleted — so to retarget you delete and re-add.
