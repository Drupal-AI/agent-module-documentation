# Allow Only One — manual setup guide

**Allow Only One** (`allow_only_one`) stops duplicate content by enforcing that a
chosen combination of field values is **unique** across a content type or a
taxonomy vocabulary. When someone tries to save a second node (or term) with the
same combination, the save is blocked and the editor is shown a link to the
existing item.

You configure it by adding a special **Allow Only One** field to the content type
or vocabulary. That field stores nothing meaningful on its own — it exists only to
carry the uniqueness rule. In its field settings you tick which fields together
must be unique. You can add a single field (say, an SKU), combine several fields
into a composite key, and optionally fold the node title / term name into the key
with case-sensitive or case-insensitive matching. There is also an option to
check only published entities, so drafts don't count.

Only **nodes** and **taxonomy terms** are supported. There is no admin settings
page, no Drush command, and no permissions of its own — the whole configuration
lives in that one field's settings.

One thing to be aware of: the uniqueness check runs without an access filter, so
the "this already exists" message can, in edge cases, link to content the editor
would not otherwise be able to see (for example an unpublished or restricted
item). It is low impact, but worth knowing when the matched content may be
private.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You work entirely on **Structure → Content
types → (your type) → Manage fields** (or the equivalent for a vocabulary), where
you add the Allow Only One field and set the uniqueness rule in its field
settings.

## How to use it

1. Go to **Manage fields** for the content type or vocabulary and **add a field**
   of type **Allow Only One**.
2. In the field's settings, under **Unique field combinations**, tick every field
   that together must be unique.
3. Optionally tick **Title** to include the node title / term name in the key
   (then choose case-sensitive or case-insensitive matching), and/or **Limit
   validation to published entities** so drafts are ignored.
4. Save. From now on, saving a node or term whose selected values match an
   existing one is blocked, with a link to the conflicting content.

To relax the rule later, edit the field settings and untick fields; to change the
key, tick a different combination.
