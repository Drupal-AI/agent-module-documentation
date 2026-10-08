# Taxonomy Term Config Groups — manual setup guide

**Taxonomy Term Config Groups** (`taxonomy_term_config_groups`) lets you gather many
taxonomy terms into **fieldable groups**, so you can configure a setting once for a
group and have it apply to every term in it — instead of repeating the same value term
by term. Think "show in filter", "boost weight", "navigation visibility", a landing
page, a banner, or a shipping class: set it on the group, and every term in the group
inherits it.

The problem it solves is keeping term-level configuration DRY, auditable, and
maintainable. Core lets you add fields to individual terms; this module adds a layer
above that — reusable *configuration groups* of terms with their own fields — so shared
settings live in one place. It does this by providing a content entity
`taxonomy_group` with a per-vocabulary bundle (`taxonomy_group_type`), to which you can
attach any fields you like (booleans, text, entity references, and so on).

The module is off for every vocabulary until you turn it on. You enable grouping per
vocabulary from that vocabulary's edit form, then use a visual **"Terms Icicle"**
interface (built with D3) to browse the vocabulary's hierarchy and drag terms into
groups. Groups' fields are managed through the normal Field UI on the bundle created
for each vocabulary. For developers, a lookup service
(`taxonomy_term_config_groups.group_lookup`) returns the group for a term (or all
groups for a vocabulary) so custom code can read the group's fields and apply behaviour
wherever that term is used. Data is preserved if you disable grouping on a vocabulary,
and cleaned up if you delete the vocabulary.

It depends on core **Taxonomy** and **Field**, and provides its own permission
(**administer taxonomy term config groups**). The D3 v7 JavaScript library it uses for
the icicle interface is bundled through Composer — nothing is loaded from an external
CDN. Note this project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable grouping per vocabulary, create
   groups and assign terms, and add fields to the groups.

## Where it lives in the admin menu

- Enable grouping on a vocabulary from its edit form under **Structure → Taxonomy**
  (`/admin/structure/taxonomy/manage/{vid}`).
- The grouping (icicle) interface for a vocabulary is at
  `/admin/structure/taxonomy/manage/{vid}/grouping`, also reachable from the
  vocabulary's **Configure term grouping** operation.
- The list of group bundles, where you manage each bundle's fields, is at
  `/admin/structure/taxonomy-groups/types`.

See [Configuration](configuration/index.md) for the full sequence.
