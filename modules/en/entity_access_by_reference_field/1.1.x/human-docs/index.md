# Entity Access by Reference Field — manual setup guide

**Entity Access by Reference Field** (`entity_access_by_reference_field`) lets you
control who can view, edit, or delete an entity based on the user's access to a
**different** entity it points to through an entity-reference field. This captures
a very common relational access rule: a user may see a document if they can see the
project it belongs to; a user may edit a page if they belong to the group it
references. Rather than writing custom access code, you express the rule in the
field's configuration and the module delegates the decision to the referenced
entity's own access check — the correct, idiomatic Drupal approach.

You turn the check on per entity-reference field. There you define a **permission
matrix** mapping each host operation (view, view unpublished, edit, delete) to the
access that must hold on the referenced entity, and — when a field references more
than one entity — you choose **ANY** (or) versus **ALL** (and) behaviour. There is
also an *"is referenced user"* option for user-reference fields (note it grants
access both when the current user *is* the referenced user and when they hold
delete access on that user, which is slightly broader than the label suggests). A
global **bypass** permission lets trusted roles skip the check entirely.

This module has **no central admin page** — all configuration lives on individual
fields (see below). It works on Drupal 10.2 and later and has no module
dependencies of its own.

**The single most important thing to understand — it fails open by default.**
When the reference check does not grant access, the module returns the field's
configured **fallback**, and that fallback **defaults to Neutral**. A neutral
result does not deny; it simply lets core and other modules decide, and core's
`access content` permission (which everyone effectively has) then grants view
access. In other words, enabling the check on a field, by itself, does **not**
restrict anything — it can only *add* access, never remove it. To actually lock a
host entity down to users with reference access, you must set that field's fallback
to **Forbidden**. This Neutral default is technically correct behaviour for a
Drupal access hook (a hook that returned Forbidden by default would break sites),
but the module's name invites the wrong assumption, so it is worth stating plainly:
**no fallback of Forbidden means no restriction.**

One documented limitation for Views: the module calculates access dynamically via
`hook_entity_access()` and does not alter the underlying database query. Views can
therefore list entities that are "access denied" for the current user, which in
some setups leaks information such as a label the user should not see. If you hit
this, the maintainers suggest looking at the
[Views Entity Access Check](https://www.drupal.org/project/views_entity_access_check)
module until the related Drupal core issue is resolved.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You configure it directly on
each entity-reference field, as described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure it from **Structure →
(entity type) → Manage fields → (your reference field) → Edit**, where its settings
appear on the field's configuration form.

## How to use it

1. Add or pick an **entity-reference field** on the host entity type (for example a
   *Project* reference on your *Document* content type).
2. Edit that field. In its settings, enable Entity Access by Reference Field and
   define the **permission matrix** — for each host operation (view / view
   unpublished / edit / delete) choose which access on the referenced entity should
   grant it.
3. If the field can hold more than one reference, choose **ANY** (grant if the rule
   holds for any referenced entity) or **ALL** (require it for every referenced
   entity).
4. Set the **empty behaviour** — what to do when the host entity has no referenced
   entity at all (allow, neutral, or deny).
5. **Set the fallback to Forbidden** if your goal is to *restrict* the host entity.
   Leaving it at Neutral means the field only ever grants extra access and never
   takes any away.
6. Optionally grant the global bypass permission
   (`bypass entity_access_by_reference_field permissions`) to roles that should skip
   the check, at **People → Permissions**.

> **Heads-up on shared settings:** the module stores these settings on the field
> **storage** as third-party settings. That means multiple instances of the *same*
> field (across bundles) share one configuration — changing it on one instance
> changes it for all of them.
