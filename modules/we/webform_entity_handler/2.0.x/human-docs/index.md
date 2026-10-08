# Webform Entity Handler — manual setup guide

**Webform Entity Handler** (`webform_entity_handler`) lets a webform **create or
update a content entity** from the values people submit. It adds an "Entity"
handler you attach to a webform, and in that handler you map each field of the
target entity — a node, a user, a taxonomy term, or any custom content entity — to
a submitted value, a token, or a fixed value. When a submission comes in, the
handler builds or updates the entity for you, with no custom code.

Typical uses include turning a "Submit a story" form into Article nodes, creating
user accounts from a signup form, building lead or support-ticket entities for a
CRM-style workflow, or letting people update their own profile through a webform.
It can create brand-new entities, or update an existing one — either by storing the
entity's ID in a hidden element, or by looking one up by matching properties (for
example finding a user by email address). It can skip creating a duplicate when a
match already exists, create a new revision on update, and append to multi-value
fields instead of overwriting them.

You also control **when** it runs: only on completed submissions by default, but
optionally on drafts, updates, or deletions too. Because tokens are supported
throughout, you can compute values like the current user's ID. A webform can carry
several Entity handlers at once, so a single submission can create more than one
entity.

There is no site-wide settings page — everything is configured per webform, on the
handler you add. That is why this guide has no separate configuration page; the
how-to below covers it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full settings
and mapping syntax — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure the Entity handler from
a specific webform, under **Structure → Webforms → (your form) → Settings →
Emails / Handlers** (`/admin/structure/webform`).

## How to use it

1. Go to **Structure → Webforms** and edit the webform you want.
2. Open **Settings → Emails / Handlers** and click **Add handler**, then choose
   **Entity** (listed under the "External" category).
3. Under **Entity settings**, choose:
   - the **Entity operation** — *Create a new entity*, *Update the entity whose ID
     is stored in an element*, or *Update a custom entity ID*;
   - the **Entity type** and bundle (for example `Content: Article`);
   - optionally a **Load by properties** map to find an existing entity when you
     do not have its ID (for example match on email);
   - **Skip if exists**, to avoid creating duplicates.
4. When you pick an entity type, the **Entity values** area reloads with a group
   for each of the target's fields. For each one, choose a **submission element**
   to copy from, **Null** to clear it, or type a **custom/token value**. On
   multi-value fields you can tick an option to **append** rather than overwrite.
5. Under **Additional settings → Execute**, tick which submission states should
   trigger the handler. The default is when a submission is **completed**.
6. Save the handler.

> **Tip:** install the optional **Token** module for a friendly token browser when
> filling in custom values.

To create several entities from one submission, add more than one Entity handler —
the handler's cardinality is unlimited.
