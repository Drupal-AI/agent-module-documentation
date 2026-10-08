# Subgroup — manual setup guide

**Subgroup** (`subgroup`) extends the [Group](https://www.drupal.org/project/group)
module so your groups can be arranged into a **hierarchical tree** — Organisation →
Department → Team, or Franchise → Region → Location — with roles that inherit up or
down that tree. Group on its own gives you flat, independent groups; Subgroup lets
you nest them and have membership in one group automatically grant a role in its
ancestors or descendants.

The idea comes in two layers. First you build a **group-type tree**: you declare
which group types may sit above or below which (for example, a "Team" type is a
child of a "Department" type). Then you configure **role inheritances** on top of
that structure: a rule such as "anyone who is a lead in a Department also gets the
manager role in every Team beneath it." At runtime, Subgroup walks each member's
place in the tree and folds the inherited role's permissions in automatically, with
correct cache handling so access stays accurate as memberships, roles, and the tree
itself change.

A few important rules keep the hierarchy honest. Inheritance flows only between
ancestors and descendants — never sideways between siblings — and it **does not
chain** (an inherited role doesn't itself trigger a further inheritance), which is
why circular links between two types (A→B and B→A) are actually allowed. Subgroup
also enforces strong structural integrity: you can't delete a group type that still
has children, can't delete a group that still has live subgroups, and can't create
a subgroup-typed group at the site root — it must be created as a subgroup of its
parent.

Typical uses include franchise/affiliate structures where access flows down a
corporate tree, course → module → cohort hierarchies for e-learning, and
multi-tenant setups where each tenant is a subtree with its own inherited staff
roles. It requires Group 3.x and Drupal 10.3 or 11, and all configuration is gated
behind a single restricted permission.

This guide is written for a **human** setting the module up through the UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the entity handler API, the
permission calculator, and the Leaf events in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — build a tree, link actual groups, and
   set up role inheritances, step by step.

## Where it lives in the admin menu

The settings form sits at **Group → Subgroup** (`/admin/group/subgroup`). Access is
controlled by the restricted **Administer subgroup** permission — grant it only to
trusted administrators.

## How to use it

Setting up Subgroup is a three-part process, all documented on the
[Configuration](configuration/index.md) page:

1. **Build a group-type tree** on the settings form — declare which group types may
   be parents and children of one another.
2. **Link individual groups** through each parent group's normal relationship UI
   (this part is *not* done on the settings form — a `subgroup:<child>` relation is
   added to the parent group type automatically when a child type joins the tree).
3. **Configure role inheritances** — map a source group role to a target group role
   between two vertically related group types.
