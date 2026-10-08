# Sub Entity — manual setup guide

**Sub Entity** (`subentity`) is a framework for building *subentities* — content
entities that never exist on their own but always belong to a parent entity and
are managed through it. If you remember Field Collection from Drupal 7, or you know
Paragraphs, this is the same idea generalised: a way to model composite, "part of
something bigger" data on your own terms.

Drupal's usual answer to "entities that only exist as part of another entity" is
**Paragraphs**, and it is a good answer — but an opinionated one, with its own
paragraph types, its own widget, and revisions tied to the host. When a project
needs the *pattern* but not those opinions, the alternative has traditionally been
to hand-build a content entity type with all the boilerplate that implies. Sub
Entity supplies that framework for you instead: base entity classes, route
providers, an admin bundle list builder, Drush generator commands, and — crucially
— an access control handler that derives a subentity's access from its parent
rather than deciding it independently. That last piece is the important one: for
owned data, the child's access *should* follow the parent, and this framework does
that by default.

This is a **developer / site-builder tool**, not a point-and-click feature. You
create a new subentity type from the command line with a Drush generator, then
reference it from a parent entity through an entity-reference field. It has **no
module dependencies** beyond core, but it **requires Drush 12 or newer** (it
conflicts with anything older), so the Drush integration is effectively mandatory.
Administration of subentity bundles lives at `/admin/structure/subentities`, behind
**both** the *Administer subentities* and *Administer site configuration*
permissions.

> **Upgrading?** Note two breaking changes on this branch: since 3.0.0-rc3 the Twig
> template definitions for custom subentity types changed, and since 3.0.0-rc4 the
> CSS class naming for custom subentity types changed. If you defined custom
> subentity types on an earlier release, check the project's change records before
> updating.

This guide is written for a **human** developer setting the framework up. If you
are an AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (Drush 12+
   required) and enable the module.

## How to use it

Once the module is enabled, you generate a new subentity type from the command
line:

```bash
drush generate subentity
```

This works much like `drush generate content-entity`, but the type it produces is a
*subentity* — one that always attaches to a parent entity, so no new module is
created for it. You can then reference your subentity from any parent entity using
an **entity-reference** field. Manage the resulting subentity bundles at
**`/admin/structure/subentities`** (you need both *Administer subentities* and
*Administer site configuration*).

The behaviour that matters most when you extend the framework is the parent-derived
access model: a subentity's access is decided by the entity that references it. If
you write a custom access handler, keep that model — an access handler that ignores
the parent reintroduces exactly the leak the built-in handler prevents.

Reach for Sub Entity over Paragraphs when the Paragraphs widget, revision model, or
type system is the wrong shape for what you are building — not merely to avoid a
dependency, since Paragraphs is far more widely deployed and better documented.
Typical fits include order-line structures, survey question/answer sets, or
specification sheets — repeated structured data that belongs to one owner.
