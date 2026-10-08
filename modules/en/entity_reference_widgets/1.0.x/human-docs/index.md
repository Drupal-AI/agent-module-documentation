# Entity Reference Field Widgets — manual setup guide

**Entity Reference Field Widgets** (`entity_reference_widgets`) is a small suite of
usability improvements for entity reference fields. It bundles two independent
features: a **hierarchical taxonomy term** selection method that constrains what an
editor can pick to the children of a chosen parent term, and an **Inline Entity
Form (IEF) enhancement** that adds an autocomplete‑driven "create new" option to
the IEF *complex* widget.

The problem it addresses is editorial flow. On a big vocabulary, a flat
autocomplete offers every term at once; the hierarchical selection lets you scope
choices to one branch of the tree, so editors see only the terms that make sense
in context. On content types that embed referenced entities with Inline Entity
Form, the create option lets an editor type a name and add a brand‑new item
inline, rather than breaking off to create it separately first.

There is **no central settings page**. Everything is configured per field: the
hierarchical part is a reference‑method (selection handler) you choose in the
field's settings, and the IEF create option is a set of third‑party settings that
appear in the IEF‑complex widget's configuration. It depends on core's **Field UI**
(`field_ui`) and the contributed **Inline Entity Form** (`inline_entity_form`)
module. Note that all entity querying runs through Drupal core's access‑checked
selection handler, so the widgets never bypass reference access rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module — it has no settings form. All
setup happens on individual fields, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You configure it entirely from **Structure →
Content types (or other bundle) → *(bundle)* → Manage fields** (for the
hierarchical reference method) and **Manage form display** (for the IEF create
option).

## How to use it

### Hierarchical taxonomy term select

1. Make sure you have a vocabulary whose terms are arranged in a **parent/child
   hierarchy**.
2. On a taxonomy term reference field, edit the field settings and set the
   **reference method** (selection handler) to **Taxonomy Term selection –
   Hierarchical**.
3. Configure the **parent term**. From then on, the field's autocomplete/select
   results are restricted to that parent's children, so editors pick from a
   subtree instead of the whole vocabulary — no custom selection handler code
   required.

### Inline Entity Form "autocomplete create" option

1. On a reference field, go to **Manage form display** and set its widget to
   **Inline entity form – Complex**.
2. In the widget's settings, tick **Enable Autocomplete Create Option**.
3. Fill in the supporting text fields: the **helper text** shown to editors, the
   **new‑item** autocomplete label, and the **submit button** label for the
   inline create step.

With that enabled, editors get a single autocomplete that lets them either pick an
existing entity or create a new one on the spot. The extra JavaScript
(`entity_reference_widgets/ief`) is attached only when the option is turned on.
