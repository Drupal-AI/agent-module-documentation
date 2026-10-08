# Group relationship inheritance — manual setup guide

**Group relationship inheritance** (`group_relationship_inheritance`) extends the
[Group](https://www.drupal.org/project/group) module so that when a piece of group
content references other entities, those referenced entities are automatically
related to the *same* group(s). It keeps a web of related content together under
one group's access rules, without you having to attach each referenced item to the
group by hand.

The classic case is a course made of parts. Imagine a group used as a "Course"
that has Chapters, and each Chapter references Resources (perhaps created inline
with an entity form). Normally you'd have to create each Resource first and add it
to the Course group yourself. With this module, after you save a Chapter in the
course's context, it tries to relate each referenced Resource to the same Course
group for you.

Under the hood the module adds a computed field with a widget that decides the
behaviour: relate the referenced entities, or don't. By default it does nothing
until you enable that widget on a content type's form display and choose to turn
inheritance on — so it never changes your content silently.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Group.

There is **no central settings page** for this module. You configure it per
content type on the *Manage form display* (and optionally *Manage display*)
screens, described below.

## How to use it

First get the groundwork in place: you need Group set up with at least one group
type, and a "group relation type" installed (for example the `gnode` module from
Group core) so that your content type can belong to groups. Create a group type at
**Structure → Group types**, use its **Set available content** operation to
install the relation for the node type you care about, and configure it.

Then turn on the inheritance behaviour for that content type:

1. Go to **Structure → Content types**, and click **Manage form display** for the
   content type (for example *Article*).
2. The module provides a computed field, **Set group to referenced entities**,
   which is **disabled by default**. Drag it up into the enabled region.
3. Choose the appropriate widget and, optionally, click the gear icon to configure
   the default behaviour.
4. Save. Repeat for any other form modes you use.

There is also a matching **Groups** computed field available on **Manage display**
if you want to *show* the inherited group relationships when viewing the content.
By default it uses the label "Groups"; you can adjust labels and descriptions with
a field‑label module if you need to.
