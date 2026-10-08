# Taxonomy Term Selection Role Filter — manual setup guide

**Taxonomy Term Selection Role Filter** (`taxonomy_term_selection_role_filter`)
lets you limit which taxonomy terms a user is offered in a term‑reference field,
based on the roles that user holds. It adds a new reference method — *"Taxonomy
terms with role filter"* — that you can choose when configuring a taxonomy
term‑reference field. Once selected, the term options the user sees are filtered
down to only the terms whose allowed roles they have.

The way it works: the target vocabulary carries a **Role reference field**, and on
each term an editor picks which user roles are allowed to select that term. If a
term has no roles set, anyone can select it. This is a neat way to scope a shared
vocabulary by role — for example so each department's editors only see their own
department's terms in a dropdown.

One important caveat to understand before you rely on it: this filter governs
**what appears in the selection widget** — it is an authoring convenience, **not a
hard security boundary** on the term data. The terms still exist and may be
reachable by other means (direct URLs, Views, the API), and the module plays no
entity‑access‑control role. Use it to keep editing forms tidy and role‑appropriate,
but do not use it as your only mechanism for hiding sensitive terms.

This guide is written for a **human** working through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to set it up

The module has no global settings page; you configure it per vocabulary and per
field. The typical flow is:

1. **Add a Role reference field to the target vocabulary.** Go to **Structure →
   Taxonomy**, edit the vocabulary you want to scope, open **Manage fields**, and
   add a field that references user **Roles**. This is what the filter reads.
2. **Set allowed roles on each term.** Edit the terms in that vocabulary and, in
   the new Role field, choose which roles are permitted to select each term. Leave
   it empty on a term to let any role select it.
3. **Point a term‑reference field at the filter.** On whatever content type (or
   other entity) references this vocabulary, edit the entity‑reference field
   settings and choose the reference method **"Taxonomy terms with role filter"**.

From then on, when a user fills in that reference field, they are only offered the
terms whose allowed roles they hold.
