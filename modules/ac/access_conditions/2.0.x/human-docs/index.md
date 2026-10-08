# Access Conditions — manual setup guide

**Access Conditions** (`access_conditions`) lets site builders define reusable
**"access models"** — named sets of Drupal's core Condition plugins (by role, by
request path, by request, by custom context, and so on) combined with AND/OR
logic. Once defined, a model can be evaluated anywhere through a service, so you
manage a visibility rule in one place instead of duplicating condition settings on
every block, field, or pane.

Think of an access model as a saved answer to "who should see this?" You build it
once from condition plugins, choose whether the conditions must **all** match
(AND) or **any** match (OR), and give it a name. Other parts of the site — a field
group, a Commerce checkout pane, or your own custom code — then reference the model
and ask the module's checker whether the current user passes. The checker returns
a simple yes/no along with the cacheability metadata the consumer should respect.

The module ships an `access_model` configuration entity (so your rules are
exportable and move cleanly between environments), a `bypass access conditions
access` permission for roles that should ignore all models, and an optional
submodule, **`access_conditions_entity`**, that adds an access-model **reference
field** — its own field type, widget, and formatter — for attaching models to
entities. Related submodules exist for Commerce and field-group visibility.

One thing to be clear about: Access Conditions **decides**, it does not gate routes
itself. It hands a decision to consumers, which then hide content (typically by
setting `#access = FALSE`) when no model grants access. Its security design is
sound — decisions go through core's condition resolution, the bypass is an explicit
restricted permission, and there is no fail-open path.

This guide is written for a **human** setting the module up through the admin UI.
If you want the terse, token-cheap reference written for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module (and the optional field submodule), and set permissions.
2. [Configuration](configuration/index.md) — create access models, add conditions,
   choose AND/OR logic, and reference a model from a consumer.

## Where it lives in the admin menu

Access models are managed under **Configuration → System → Access models**
(`/admin/config/system/access-models`), which requires the `administer access
models` permission.
