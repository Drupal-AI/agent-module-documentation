# Configuration

Using Advanced Help Block is a two-part job: author the help content as entities,
then place it as blocks on the admin pages where it belongs. There is no single
settings form.

## Assign the permissions first

The module splits its permissions three ways — **view**, **add**, and **edit** of
the help block entities — so you can let editors write guidance without giving
them the power to configure blocks. On **People → Permissions**
(`/admin/people/permissions`):

- Grant **view** to the roles that should *see* the help (your editors).
- Grant **add** and **edit** to the roles that will *maintain* the help.

## Create a help block entity

Authors with the add/edit permission create help block entities and fill in the
guidance text (the entities are fielded, so you enter the help content as normal
field values). Write for the specific page and audience — the value of this
content is that it is site-specific and appears exactly where it is needed.

Because the content is trusted by the people who read it, give each piece of
guidance an **owner** and a **review point**. Out-of-date help is worse than no
help.

## Place it on the right admin pages

Show a help entity by placing it as a block via **Structure → Block layout**
(`/admin/structure/block`). Use the block's **visibility** settings to **scope it
to the administrative routes** where the guidance applies — for example a specific
node-edit form. Avoid site-wide placement: it risks exposing internal
instructions on public pages, and guidance shown where it does not apply teaches
people to ignore it.

## Review

Because help content is maintained by the team, revisit it periodically — when a
content type's rules change, the guidance attached to its form should change too.
