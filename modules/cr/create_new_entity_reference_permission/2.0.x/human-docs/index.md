# Create New Entity Reference Permission — manual setup guide

**Create New Entity Reference Permission** (`create_new_entity_reference_permission`)
adds a dedicated permission that controls whether a user is allowed to **create
brand-new referenced entities on the fly** from an entity-reference autocomplete field.

Here's the problem it fixes. When an entity-reference field is set to "Create
referenced entities if they don't already exist", core's autocomplete widget lets
**anyone** with edit access to the field type a new value and have a new target entity
auto-created. That's great for trusted editors adding tags, but it means regular
contributors can quietly pollute a curated vocabulary with misspelled or duplicate
terms. The classic scenario: you want your editors to add new taxonomy terms while
writing, but you don't want everyone doing it.

This module ships a replacement widget, **"Autocomplete (with new entity
permission)"**, that behaves exactly like the core autocomplete widget except it hides
the "create new" ability behind a permission. Users **with** the permission get the
normal autocreate autocomplete; users **without** it get an autocomplete that can only
reference entities that **already exist**. The effect is restrictive, not permissive —
it takes core's always-on autocreate and gates it — and the permission is declared as
access-restricted, so it won't be granted by accident.

One thing to understand about where the gate sits: it works at the **widget/form
layer**. The underlying "create if not exists" behaviour still comes from the field's
own autocreate configuration, so the right pattern is to use this widget **and** grant
the permission only to trusted roles — don't expose the field to untrusted roles by
other means and assume the widget alone protects it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — you configure it per field on *Manage form
display* and assign the permission under **People → Permissions**, described below.

## How to use it — the permission model

Setting it up on a field is a three-step process:

1. **Turn on autocreate for the field.** In the entity-reference field's settings, set
   the reference handler to **"Create referenced entities if they don't already
   exist"**.
2. **Switch to the permission-aware widget.** On the bundle's **Manage form display**
   (**Structure → (entity type) → Manage form display**), choose the widget
   **"Autocomplete (with new entity permission)"** for that field, and save.
3. **Grant the permission to trusted roles only.** At **People → Permissions**
   (`/admin/people/permissions`), grant **"Create new autocomplete referenced entity"**
   to the roles that should be allowed to create new target entities inline.

The result: editors who hold the permission can create new referenced entities (e.g.
new taxonomy terms) as they type; everyone else gets a normal autocomplete that only
selects from existing entities. To revert, switch the field back to the stock
autocomplete widget.
