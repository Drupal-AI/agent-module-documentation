# ECK Status Field — manual setup guide

**ECK Status Field** (`eck_status_field`) adds a **status / published base field**
to [Entity Construction Kit](https://www.drupal.org/project/eck) (ECK) entities,
so your custom ECK entity types can have a publish/unpublish status just like
core content entities. That's what enables a draft‑versus‑published distinction on
custom entities.

Once enabled, you turn the status field on per entity type: visit the ECK entity
type's edit page and tick the **Published field** checkbox. From then on, entities
of that type carry a status you can set to published or unpublished.

There's an access angle worth understanding. Adding a published status only *marks*
entities as unpublished — it does not, by itself, hide them. For the status to be
meaningful, the ECK entity type's access handling has to actually respect it, so
that users without the right permission can't view unpublished entities. Confirm
that on your site; otherwise unpublished entities may still be viewable. The module
has no access‑control role of its own. It depends on ECK and supports Drupal 8, 9,
10 and 11.

> **Upgrading to ECK 2.0?** This functionality has been merged into the ECK module
> itself, so ECK Status Field is no longer strictly necessary on ECK 2.0. If you
> upgrade, follow the project's documented steps carefully to avoid data loss —
> in short: upgrade ECK and run database updates on a dev copy, replace the
> `published` key with the `status` key in your ECK type configs, deploy, then
> uninstall this module and remove its Composer dependency, deploying between each
> step. See the project page for the exact sequence.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECK.

There is **no dedicated configuration page** for this module. You turn the status
field on per entity type via a checkbox on the ECK entity type edit page; see
"How to use it" below.

## Where it lives in the admin menu

ECK Status Field adds no admin page of its own. You enable the status field from
each ECK entity type's edit page under ECK's admin section (**Structure → ECK
entity types**), by ticking the **Published field** checkbox.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → ECK entity types** and edit the entity type you want to
   give a status field.
3. Tick the **Published field** checkbox and save. Entities of that type now carry
   a published/unpublished status.
4. Confirm that the entity type's access handling hides unpublished entities from
   users who shouldn't see them — a status field is only meaningful if access
   checks respect it.
