# Feeds Extensible Parsers XML Mapping — manual setup guide

**Feeds Extensible Parsers XML Mapping** (`feeds_ex_xml_mapping`) is a small
add‑on for the **Feeds Extensible Parsers** (`feeds_ex`) module. It solves one
specific problem: normally a Feeds XML feed *type* defines a single set of XPath
expressions, and every feed of that type is stuck using them. This module lets you
override those XPath mappings **on each individual feed** instead — so many feeds of
the same type can each point at differently structured XML.

That's handy whenever you import from several sources whose XML looks different but
maps to the same content. Instead of cloning the feed type for every vendor, you
keep one feed type as the default and let each feed diverge: a different context
query here, a different XPath for the title there. Non‑developers can even adjust
their own feed's XPaths from the feed edit form, and you can fix one misbehaving
feed without touching the others.

The module is pure "glue" on top of `feeds_ex`. It adds no settings page, no
permissions, no Drush commands, and no routes of its own. It works by adding two
checkboxes to the feed type's *Mapping* page, adding an override form to each feed,
and quietly injecting each feed's stored mappings back into the parser at import
time. Per‑feed overrides are saved on the feed entity, so they travel with the
feed rather than the type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. Everything happens on existing Feeds screens:

- **Feed type:** the *Override mapping per feed* checkboxes on
  `admin/structure/feeds/manage/{feed_type}/mapping` (only for feed types that use
  the **XML** parser).
- **Individual feed:** a *Context* field and an *XPath Parser Settings* table on
  each feed's add/edit form, once overrides are turned on.

## How to use it

### 1. Turn on per‑feed overrides for a feed type

Go to **Structure → Feeds → *(your feed type)* → Mapping**
(`admin/structure/feeds/manage/{feed_type}/mapping`). The feed type must use the
**XML** parser — the options only appear then. In the **Override mapping per feed**
section you'll find two checkboxes:

- **Override source mapping** — enables per‑feed XPath overrides. This is the main
  switch.
- **Override source mapping configuration** — additionally exposes each target's
  configuration subform (for example entity‑reference match settings) and a
  per‑property **Unique** checkbox on the feed form. It's only relevant when the
  first box is checked.

Save the mapping form to store these choices on the feed type.

### 2. Override the mapping on a specific feed

With overrides enabled, each feed's add/edit form gains:

- **Context** — the base XPath query that selects each item in the document
  (required).
- **XPath Parser Settings** — one row per mapped field, each with a textfield for
  that field's XPath. A brand‑new feed is pre‑filled from the feed type's current
  mappings as a starting point; an existing feed shows its own saved values.

If you enabled *Override source mapping configuration*, you'll also see a
*Configure* column and a *Unique* checkbox per field. Fields that aren't XPath‑based
(for example `parent:*` sources) are shown read‑only and passed through unchanged.

Save the feed. From then on, imports of that feed use its own XPaths, while feeds
without an override fall back to the feed type's shared mappings.
