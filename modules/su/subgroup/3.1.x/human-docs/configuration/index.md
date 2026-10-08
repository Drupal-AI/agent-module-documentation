# Configuration

Everything is driven from one page: **Group → Subgroup**
(`/admin/group/subgroup`), reachable by users with the restricted **Administer
subgroup** permission. Setting up a working hierarchy takes three steps: build a
group-type tree, link the actual groups, and define role inheritances.

## Step 1 — Create and grow a group-type tree

A tree describes which *group types* may sit above or below one another. It does
**not** yet link any specific groups — it is the blueprint.

- **Create a new tree.** Choose a **Parent** group type and a **Child** group type,
  then create the tree. (You need at least two group types that aren't already part
  of a tree.) The parent becomes the root; the child becomes a leaf beneath it.
- **Add another group type.** Pick an existing node in the tree as the parent and a
  free group type as the new child leaf. This is how you extend the hierarchy to
  three or more levels (Organisation → Department → Team).
- **Remove a leaf group type.** The remove option only appears for extremities
  (types with no descendants), and it only succeeds if that group type has **no
  actual groups** yet. Removing the last leaf removes the tree entirely.

Some rules the form enforces so the structure stays valid:

- A group type can belong to at most one tree.
- A group type can't leave a tree while it still has groups.
- Only the outer extremities (leaves) can be removed — you can't yank a type out of
  the middle.

Behind the scenes, when a group type joins a tree the module installs the bookkeeping
fields on its groups and adds a `subgroup:<child type>` **Group relation** plugin to
the parent group type — that relation is what you'll use in Step 2.

## Step 2 — Link individual groups

Linking one real group as a subgroup of another is **not** done on the Subgroup
settings form. Instead, use the parent group's own relationship UI:

1. Open the parent **group** (an actual group, not the group type).
2. Add a relationship using the **`subgroup:<child type>`** relation plugin that was
   created for you in Step 1. (The tree overview also offers a "Configure plugin"
   link, where you can adjust things like cardinality per child type.)
3. Pick the child group. The module wires it into the correct position in the tree
   automatically.

Repeat to attach as many subgroups as your structure needs.

Structural safeguards apply here too: you can't delete a group that still has live
subgroups, you can't delete the subgroup relationship directly while the child group
exists, and you can't create a subgroup-typed group at the site root — such a group
must be created *as* a subgroup of a parent.

## Step 3 — Set up role inheritances

This is where the hierarchy starts granting access. On the settings form, under a
given tree, choose **Set up a new inheritance** and pick:

- A **source** group role — the role a user already holds in one group.
- A **target** group role — the role they should also receive elsewhere in the tree.

Eligible roles are the individual group roles plus the classic "member" role
(authenticated insiders) of any group type in that tree. The form requires that the
source and target roles are different, and that their two group types are
**vertically related** (one an ancestor or descendant of the other).

The meaning of a saved inheritance: *a user who holds the **source** role in a group
also inherits the **target** role in that group's ancestors or descendants that are
of the target role's group type.* So "Department lead → Team manager" gives every
department lead the manager role in the teams beneath their department, without you
adding them to each team by hand.

Two behaviors worth remembering:

- **Inheritances do not chain.** An inherited role never triggers a further
  inheritance. This is why you can safely set up circular links (A→B and B→A)
  between two types — they won't loop.
- **Siblings and cousins are excluded.** Inheritance only ever flows up or down the
  branch, never sideways.

You can create multiple independent inheritance rules within the same tree.

## How it takes effect

Once inheritances are configured, you don't have to do anything at runtime. When
Drupal checks whether a user has a permission in a group, Subgroup's permission
calculator walks that user's memberships and the tree, folds in the inherited roles'
permissions, and tracks the right cache tags — so access updates correctly as
memberships, roles, and the tree structure change.

There is no separate "settings" object to save on this page beyond the tree and the
inheritance entities themselves; both export as normal Drupal configuration
(inheritances are `subgroup_role_inheritance` config entities), so your hierarchy
deploys cleanly between environments. Developers who need to query ancestors,
descendants, children, or parents, or react to groups entering/leaving a tree, can
use the `subgroup` entity handler and the Leaf events documented in the
[`agent/`](../../agent/start.md) docs.
