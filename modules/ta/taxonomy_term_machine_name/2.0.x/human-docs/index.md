# Taxonomy Term Machine Name — manual setup guide

**Taxonomy Term Machine Name** (`taxonomy_term_machine_name`) adds a
machine‑name field to taxonomy terms, so every term can carry a stable,
code‑friendly identifier that never changes even if you rename the term or
rebuild your content. Instead of pointing your code, config, or migrations at a
term's numeric ID (which differs from site to site) or its human label (which
editors can edit at any time), you give the term a constant key — a slug like
`featured` or `north_region` — and reference that.

Because it is implemented as an ordinary field, the machine name behaves like any
other field: it shows up on the term edit form, it can be exported and kept in
sync by the *Content as Configuration* approach, and it can be used as a filter in
Views. That makes it a natural fit whenever you need to map imported data to
terms, key business logic on a category, or build configuration that survives a
content rebuild. It also guards against duplicate registrations within a
vocabulary. The module depends only on core's **Field** and **Taxonomy** modules
and needs PHP 8.0 or newer.

There is nothing to configure globally — once the module is enabled you add the
machine‑name field to whichever vocabularies need it, and editors fill it in per
term. When it comes time to uninstall, the module gives you a dedicated route to
tear the field data down cleanly first.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and clean up safely at uninstall time.

## How to use it

After enabling the module, add the machine‑name field to a vocabulary the same
way you add any field: go to **Structure → Taxonomy**, edit the vocabulary, open
its **Manage fields** tab, and add a new field of the machine‑name type. From then
on, each term's edit form includes the machine‑name input, and you can reference
that value from code, use it as a Views filter, or match imported records against
it. The value is meant to stay constant across environments, so pick it
deliberately.

When you eventually need to remove the module, first visit
`/admin/modules/uninstall/field/taxonomy_term_machine_name` (you need the
**Administer modules** permission) to remove the stored field data cleanly, then
uninstall the module itself.
