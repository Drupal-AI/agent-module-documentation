# Taxonomy proportion — manual setup guide

**Taxonomy proportion** (`taxonomy_proportion`) lets you attach a numeric proportion
— a share or weight — to a taxonomy term *when it is referenced on an entity* such as
a node or user. You keep all the power of taxonomy (vocabularies, term pages, Views
integration), but each term reference now also carries a number: how much of the
whole this term represents.

The classic use cases make it concrete: a **recipe** node listing its ingredients,
each with its proportion; a **product** describing its composition (grape varieties in
a wine, metals in a piece of jewellery); or a **person** whose strengths and
weaknesses are weighted. In every case you want the term *and* a quantity, tied
together on the referencing content.

It ships as a field type with **two widgets** — an autocomplete widget (with term
creation) and a radio/checkbox widget — so editors can enter the term and its
proportion together. You can add a **field prefix** (like `€` or `$`) or a **suffix**
(like `%`), and a **formatter** lets you display the term before or after the
proportion. It is designed to work cleanly with Views, so you can build listings that
sort or show the weighted values. It depends only on core, supports Drupal 10 and 11,
and provides its own permission. If you need more flexibility than this field offers,
the maintainers point you at the Paragraphs module instead.

Because this is a field type, there is no central settings page — you configure it per
field, in the usual Drupal field UI. This guide covers how to add and set up the field.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Taxonomy proportion adds a new **field type** rather than a configuration page, so you
set it up wherever you want to weight terms:

1. Go to the **Manage fields** page of the content type (or other entity bundle) you
   want to add it to — for example **Structure → Content types →** your type **→
   Manage fields** (`/admin/structure/types/manage/{bundle}/fields`).
2. **Add a field** and choose the **Taxonomy proportion** field type.
3. In the field settings, point it at the vocabulary whose terms you want to weight,
   and set an optional **prefix** (such as `€`) or **suffix** (such as `%`).
4. On the **Manage form display** tab, choose the widget: the **autocomplete** widget
   (which can create terms on the fly) or the **radio / checkbox** widget.
5. On the **Manage display** tab, use the provided **formatter** to control whether
   the term shows before or after its proportion.

Editors then enter a term and its proportion together when creating content, and you
can surface the weighted values in Views.
