# Condition Field — manual setup guide

**Condition Field** (`condition_field`) adds a new field type that stores a set
of Drupal **Condition plugin** configurations directly on a content entity. Those
are the very same condition plugins that power block visibility — User Role,
Request Path (pages), Language, and any other context-based conditions provided
by core or contrib. With this field you can attach editor-configurable "show this
only when…" rules to a node, paragraph, custom block, or any other fieldable
entity.

Editors configure the conditions in a familiar vertical-tabs interface that
mirrors the block visibility settings, so the experience is one they likely
already know. Per field instance, you decide which condition plugins are offered,
so you can keep the choices focused (for example just "roles" and "pages").

One important thing to understand: **Condition Field only stores the conditions —
it does not evaluate them for you.** It is a building block for developers. Your
own code reads the field and resolves the stored conditions (the module ships a
`ConditionAccessResolver` helper with AND/OR logic), for example inside
`hook_entity_view` to hide or show an entity, or to drive any custom business
rule. Because of that, there is no admin settings page, no permissions, and no
Drush commands — everything is per-field configuration plus the evaluation code
you write.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how to read and
evaluate the stored conditions in code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Condition Field adds no admin pages. You use it from a bundle's **Manage fields**
screen when adding a field of type **Condition plugin field**, and from **Manage
form display** / **Manage display** to configure its widget and formatter.

## How to use it

### Add a Condition Field to a content type

1. Go to **Structure → Content types → (your type) → Manage fields → Create a new
   field**.
2. Choose the **Condition plugin field** type and give it a label such as
   "Display conditions".
3. On the field settings form, tick the **condition plugins** you want editors to
   be able to use on this field. Nothing appears in the editor until you enable at
   least one. (A few plugins are always skipped because they do not make sense
   here — for example `node_type`, `current_theme`, and the webform conditions;
   the Language condition only appears once your site is multilingual.)
4. Save the field.

### Editors set the conditions

On the entity's edit form, the field renders each enabled condition inside
vertical tabs — the same UI as block visibility. Editors fill in the ones they
want (a set of roles, a list of paths, and so on). Only conditions that differ
from their defaults are stored, keeping the data tidy.

### Show or evaluate the conditions

- The default **formatter** ("Condition summary") displays a readable list of the
  stored conditions on the rendered entity — handy for confirming what an editor
  set.
- To actually *act* on the conditions (hide the entity, gate a component, drive a
  rule), a developer reads the field and calls
  `ConditionAccessResolver::checkAccess($conditions, 'and')` (or `'or'`). See the
  [`agent/`](../agent/api/evaluate.md) docs for the exact code.
