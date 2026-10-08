# Taxonomy Ordinal — manual setup guide

**Taxonomy Ordinal** (`taxonomy_ordinal`) gives taxonomy terms a stable,
hierarchical numbering — the kind of outline reference you see in contracts, laws,
and scientific papers: *Chapter IV, Section 12.3, Article A*. It provides a field
type that turns the hierarchical structure of a vocabulary into a unique, numbered
index you can sort on in Views and display in several configurable lengths and
styles (for example `Chapter IV, Section 12.3, Article A`, or the short
`Ch. IV, Sec. 12.3, Art. A`, or the compact `IV-12.3, A`).

The problem it solves is stable referencing. If you have a structured collection —
contracts, papers, books, directories — you want each item to carry a fixed citation
number that does not shift when neighbouring items are added or removed. Taxonomy
Ordinal enforces that: index numbers are **unique** (you cannot assign the same one
twice), and they are **stable** (deleting a term or entity does not renumber the
ones after it, so existing citations stay valid). It suppresses Drupal's automatic
weight changes so the numbering stays put, and when you move a term to a new parent
its index resets to zero (disabled) so you can renumber it deliberately.

Entities of any type — nodes, for example — can join the same address structure:
if they reference a term in an enabled vocabulary, adding the module's field type to
them slots them into the numbering too. It depends only on core's **Taxonomy**
module. The module needs configuration before it does anything — you enable it for
specific vocabularies, set the display formats, and add the field where you want it.

This guide is written for a **human** working through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable it per vocabulary, set the
   index formats, and add the field to your terms and content.

## Where it lives in the admin menu

The module's main settings page is at **Configuration → Content authoring →
Taxonomy Ordinal** (`/admin/config/content/taxonomy-ordinal`), where you choose which
vocabularies use ordinal numbering. Per-vocabulary format settings then appear on
each vocabulary's own edit page. See [Configuration](configuration/index.md) for the
full sequence.
