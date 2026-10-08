# Schema Form — manual setup guide

**Schema Form** (`schema_form`) generates Drupal forms directly from a schema
definition, using the structure, labels, and validation constraints declared in
the schema. Instead of hand-building a long Form API array in PHP, you describe
the data once in a YAML schema file and the form page is generated for you —
complete with validation and saving. It works for **configuration forms**
(settings pages and config objects), for **config-entity forms**, and for any
other form you want to drive from a schema.

The saving is impressive in its economy: a config settings page that would
normally take a route file plus a couple of hundred lines of custom PHP can be
reduced to two small YAML files — a schema describing the fields and a routing
entry pointing the route's `_form` at
`Drupal\schema_form\SchemaConfigFromRouteForm` with the editable config names.
Because core already ships schemas for things like `system.site`, you can even
regenerate a core-style settings form with a single routing file and no schema of
your own. If you do need to customise a generated form, you can still alter it the
normal way, and **Schema Form Design** entities let you tweak or override the
form's presentation without touching the underlying data schema.

This is a developer/form-building module — it produces admin and custom forms but
has no content model or access-control role of its own. It works on Drupal 10 and
11 and has no other module dependencies. It is a drop-in replacement for similar
schema-driven form modules (Automatic Configuration Form, Schema Based Config
Forms): existing schemas can be reused without change.

Because it is a developer tool, there is nothing to configure through the UI after
enabling it — you use it from your own module's YAML and routing. More detailed
documentation and worked examples are published on the module's separate
documentation site (linked from its
[project page](https://www.drupal.org/project/schema_form)).

This guide is written for a **human** working with the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it so its form classes are available to your code.

## How to use it

There is no settings page. Once enabled, you build a form by writing schema and
routing rather than PHP:

1. **Describe the data** in a `config/schema/*.schema.yml` file — the `type`,
   `label`, and a `mapping` of fields, each with its own `type`, `label`, and
   `description`.
2. **Declare a route** in your module's `*.routing.yml` whose `_form` points at
   `Drupal\schema_form\SchemaConfigFromRouteForm`, with a `_title`, a `_permission`
   requirement, and the `editable_config_names` under `options`.
3. Visit the route's path — Schema Form renders the fields, validates input, and
   saves the values to config automatically.

The same approach works for config-entity forms and for arbitrary (non-config)
forms. To adjust a generated form's presentation without changing the data
schema, create a **Schema Form Design** entity.
