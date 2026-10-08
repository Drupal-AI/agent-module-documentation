# Skillset Inview — manual setup guide

**Skillset Inview** (`skillset_inview`) displays a list of skills with proficiency
levels as animated bar graphs, aimed at portfolio and CV/résumé pages. Its party
trick is the "in view" animation: the bars animate into place when the block
scrolls into the visitor's view, and reset again when it scrolls out.

You get at the feature in two ways. There is a **Skillset** field type (with a
matching widget and two formatters — a standard bar and a meter/gauge variant)
that you can add to a content type or user profile, and there is a configurable
**block** you can place in any region. An admin colour form lets you theme the
bars to match your design, and an overview page lets you add, reorder (via a drag
table), review, and delete skills. Everything on the admin side is gated by a
single **Administer skillset inview** permission (`administer skillset inview`).

The module depends on the core **Block** and **Serialization** modules. It is a
presentational, admin-driven tool — skill data is authored by editors through the
field or block config, and it carries no access-control role. Note that on Drupal
10 the animation and colour picker rely on a few front-end JavaScript libraries
you need to place yourself (see Installation).

> **Upgrading from version 2?** There is no update path from v2 to v3 — the v3
> field is a brand-new custom field. Uninstall v2 before updating to v3.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and place the required JavaScript libraries.
2. [Configuration](configuration/index.md) — add and reorder skills, choose
   colours, and place the block.

## Where it lives in the admin menu

- **Manage skills:** the overview/reorder page at
  `/admin/content/skillset-inview` — add, weight (drag table), review, and delete
  skills. This is the module's main configure route.
- **Colours:** the Skillbar colour form, where you customise bar colours through
  the UI to match your theme.
- **Place the block:** **Structure → Block layout**
  (`/admin/structure/block`) — place the Skillset Inview block in a region.
- **Help:** with the core Help module enabled, see
  `/admin/help/skillset_inview`.
