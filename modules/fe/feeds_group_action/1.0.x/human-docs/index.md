# Feeds Group Action — manual setup guide

**Feeds Group Action** (`feeds_group_action`) bridges the
[Feeds](https://www.drupal.org/project/feeds) and
[Group](https://www.drupal.org/project/group) modules, so that importing content
can also create **Group relationships** (memberships) as part of the same feed.
Import a batch of nodes or users and, in one pass, place them into the right
groups.

It provides a single Feeds **target** plugin called **Group Membership**. On your
feed type's mapping you point a source at this target and choose two things: the
**Group relationship type** (the relation plugin) to create, and an **add method**
that controls what happens when a relationship already exists — *skip if already
in group*, *always add*, or *update if already in group*.

During processing the target doesn't write immediately; it **stages** the
requested relationships on the entity so they can be created after the entity is
saved. The actual group content is then written through the
[Group Action](https://www.drupal.org/project/group_action) API, so the create/
update behaviour follows that layer's own logic and access rules. A typical
pattern is to combine this target with an **Entity Finder** tamper on the source
field, which looks up a group by some value in your source file (for example a
name) and returns the group ID that the membership is created against.

This is a pure import‑pipeline feature — it has no routes or permissions of its
own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Feeds, Feeds Tamper, Group and Group Action.

There is **no separate settings page** for this module. The target is configured on
a feed type's mapping, described in "How to use it" below.

## Where it lives in the admin menu

Feeds Group Action adds no admin page of its own. Its target appears on the
**Mapping** tab of a feed type at **Structure → Feed types**.

## How to use it

1. On your feed type's **Mapping** tab, add a mapping and choose the **Group
   Membership** target for it.
2. Set the **relationship type** for the content you're importing (based on its
   relationship to the group), and pick the **add method** — *skip existing*,
   *always add*, or *update existing*.
3. Point the mapping's source at the value that identifies the group. A common
   approach is to add an **Entity Finder** tamper on that source: search by
   whatever field your source file matches on (for example a group name) and have
   it return a **group ID**.
4. Run the import. As each entity is saved, the staged membership is created for it
   through the Group Action API. A source that provides multiple group IDs (an
   array) can place an item into several groups at once.
