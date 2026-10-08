# Schema Based Config Forms — manual setup guide

**Schema Based Config Forms** (`schema_based_config_forms`) is a developer
toolkit for building Drupal configuration forms with far less code. It provides
an extension of core's `ConfigFormBase` class that constructs the form
automatically from your module's **config schema** — the YAML type definitions
you would normally write anyway. In other words, you describe the shape of your
configuration once in schema, and this module turns it into a working settings
form, so you write less PHP in exchange for little or no additional YAML.

Many of core's data types are supported out of the box, and additional submodules
can add support for more types from core and contrib. The type system is
extensible: other modules can register support for additional data types via
plugins. This is a framework/developer module — it produces admin configuration
forms but has no content model or access-control role of its own. It works on
Drupal 10.2 and 11.

Because it is a developer foundation rather than a feature, there is nothing to
configure through the UI after enabling it. You use it from your own module's
code by basing a config form on the class it provides, and by defining the config
schema that drives the form.

This guide is written for a **human** working with the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it so its base class is available to your code.

## How to use it

There is no settings page. Once enabled, the module's `ConfigFormBase` extension
becomes available to your custom modules. You point a config form at that base
class and define the matching config schema (the same YAML `type`, `label`,
`mapping`, and field-type definitions you would write for validation and
translation). The module reads that schema and renders the form fields, handles
their validation, and saves the values back to config — no hand-written form
array required. To support a data type the base set does not cover, add one of the
type submodules or provide a plugin for it in your own module.
