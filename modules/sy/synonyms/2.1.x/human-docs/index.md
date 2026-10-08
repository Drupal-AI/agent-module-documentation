# Synonyms — manual setup guide

**Synonyms** (`synonyms`) gives any content entity — taxonomy terms, nodes, users
and more — the notion of *synonyms*: alternate labels read from ordinary fields. A
country term labelled "United States" can also be known by "USA" and "US"; a catalog
item can be found by an alternate part number. Once entities have synonyms, the
suite can use them for autocomplete matching, select widgets, search indexing and
Views filtering — so people find content by the name they actually use, not just its
primary label.

The core module is a **framework**, and on its own it has no user-facing effect. It
defines a "synonyms provider" concept — plugins that know how to *read* an entity's
synonyms and *find* entities by a synonym — and ships two providers that pull
synonyms straight from a field you choose (a text field, an entity-reference field,
or a number/email/telephone field). You wire providers up as **Synonym**
configuration entities at *Structure → Synonyms configuration*: pick an entity type
and bundle, add a provider, and choose the field the synonyms live in. A second
concept, **behaviors**, are the actual integrations (autocomplete, select, search
and the Views pieces) contributed by the module's **submodules**; you turn them on
per entity type and bundle.

So the shape of a setup is: enable the base module, enable the submodule(s) for the
integrations you want, register a Synonym provider on the entity/field that holds
your alternate labels, and enable the relevant behavior. There are seven submodules,
each a distinct integration. The module is core-only (no contrib dependencies) and
adds an **Administer synonyms** permission. A neat production trick: once your
Synonym configs and behaviors are set, the admin/config forms can be uninstalled on
production while the synonyms themselves keep working through exported config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — register Synonym providers, set the
   global wording, and enable behaviors per entity type/bundle.

## Where it lives in the admin menu

The hub is **Structure → Synonyms configuration**
(`/admin/structure/synonyms`), gated by the **Administer synonyms** permission. From
there you reach the per-bundle provider and behavior forms, and the global settings
form (the settings and *Manage behaviors* forms instead require core's *Administer
site configuration*).

## How to use it

1. Enable the base module and the submodule(s) for the integrations you want (for
   example `synonyms_autocomplete` for synonym-aware autocomplete, or
   `synonyms_search` for search).
2. At **Structure → Synonyms configuration**, find the entity type/bundle you want
   to add synonyms to and add a **provider**, choosing the field the synonyms are
   read from.
3. On the same bundle's *Manage behaviors* form, enable the behavior(s) that match
   the submodules you turned on.
4. Test it — for example, an autocomplete on an entity-reference field should now
   match by synonym as well as by the primary label.
