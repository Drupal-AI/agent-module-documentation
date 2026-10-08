# Configuration

There's no settings form to fill in. You "configure" this module entirely by
granting its generated permissions to the right roles. This page explains how the
permissions are structured and how to apply them.

## Before you start

This module only affects entities that Content Moderation treats as **moderated**.
So make sure you already have:

- Core **Content Moderation** enabled, and
- at least one **workflow** configured (under **Configuration → Workflows**) that
  is applied to the content types (or other entity types) you care about.

The permissions are generated from your live workflow configuration, so if you
have no workflows/states yet, there will be nothing to grant.

## Understanding the generated permissions

For **every state** in **every workflow**, the module creates three permissions —
one each for **view**, **update**, and **delete**. On the permissions page they
read like:

> **Workflow: Editorial - update entities in the Draft state**

So a site with an "Editorial" workflow that has *Draft*, *Published*, and
*Archived* states will show a set of view/update/delete permissions for each of
those three states. Because the list is derived from your configuration, these
permissions appear, change, or disappear automatically as you edit your workflows
and states.

## Granting the permissions

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the permissions provided by **Moderation state permissions** (they're
   grouped together and named by workflow and state).
3. For each role, tick the *view / update / delete in [state]* permissions that
   role should have, then **Save permissions**.

### How the check behaves

- When a user acts on a moderated entity, the module looks at the entity's
  **current** moderation state and requires the matching permission for that
  operation. For example, a user editing a node that's currently in *Draft* needs
  the *update entities in the Draft state* permission — regardless of what state
  they're trying to move it to.
- The module can only ever **deny** access, never grant it. It layers on top of
  Drupal's normal access checks as an extra restriction.
- **This means access is deny‑by‑default per state.** If you enable the module and
  grant *no* per‑state permissions to a role, moderated entities become
  inaccessible for that operation to that role. So plan to grant the permissions
  each role needs, rather than assuming existing access carries over.

## Worked examples

- **Only editors edit drafts:** grant *update entities in the Draft state* to your
  Editor role and withhold it from lower roles.
- **Lock published content:** grant *update entities in the Published state* only
  to a Publisher role, so others can't edit once content is live.
- **Restrict deletes:** grant *delete entities in [state]* only to administrators
  for the states that should be protected.
- **Hide rejected/archived content:** withhold *view entities in the Archived (or
  Rejected) state* from most roles.

## Caveats to keep in mind

- Because this is an entity‑access hook, it does **not** cover code paths that
  bypass entity access — for example a View without an access filter, or certain
  listing/render contexts. Don't rely on it as your only guard for those.
- It also doesn't govern *who can perform a transition* — that's handled by core
  Content Moderation's own transition permissions. You can combine the two to
  control both "who can edit in this state" and "who can move it to the next
  state."
