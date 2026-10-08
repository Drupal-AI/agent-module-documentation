# Entity Term — manual setup guide

**Entity Term** (`entity_term`) keeps a strict one‑to‑one relationship between an
entity bundle and a taxonomy vocabulary. For every entity of a bundle you choose
(say, a "Person" content type), it automatically creates a taxonomy term whose
name matches the entity's label. When the entity is renamed, the term is renamed;
when the entity is deleted, the term is deleted. The classic use case is letting
you tag content with real content items — you keep your people, organizations, or
products as nodes (a single source of truth) while still referencing them through
taxonomy fields, facets, and anywhere else Drupal expects a term.

The module does more than mirror labels. To stop editors from breaking the link,
term edit forms for a synced vocabulary have their **name field disabled**, the
**delete action hidden**, and a validation guard that blocks label edits and
points editors back to the source entity. It also rewrites the term's canonical
URL and outbound term links so they lead to the corresponding entity's page
instead of the taxonomy term page — visitors always land on the real content.

Entity Term does **not** work on enable alone: after installing it you must define
one or more "entity term sets" — each maps an entity type and bundle to a target
vocabulary — before any syncing happens. It depends only on core's **Taxonomy**
module, and access to its settings is controlled by a dedicated
`administer_entity_term` permission.

One thing to know before you commit: if you later remove a set's configuration,
the module deletes every term in that vocabulary whose label matches an entity of
the configured type and bundle — regardless of whether the term pre‑existed. Plan
your vocabularies with that in mind.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Taxonomy.
2. [Configuration](configuration/index.md) — define the entity term sets that map
   a bundle to a vocabulary.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → System → Entity Term**
(`/admin/config/system/entity_term`). You need the **Administer Entity Term**
(`administer_entity_term`) permission to open it. Nothing syncs until you add at
least one entity term set there.
