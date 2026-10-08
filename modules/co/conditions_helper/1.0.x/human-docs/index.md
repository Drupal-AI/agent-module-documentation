# Conditions Helper — manual setup guide

**Conditions Helper** (`conditions_helper`) is an **API-only developer module**. It has no UI,
no routes, no permissions, and no configuration of its own — you enable it so that *other*
modules can use its services and base classes to integrate with Drupal core's Condition plugin
API with far less boilerplate. If you have ever wanted to give your module a settings page where
admins pick from core's condition plugins (Request Path, User Role, Node Type, and so on),
render each selected condition's configuration form, and then evaluate the whole set to a single
TRUE/FALSE, this module is the glue that does it for you.

It provides three services — one builds the "which conditions are available" selector form, one
builds and submits the detailed per-condition configuration sub-forms (including the context
mapping UI that context-aware conditions need), and one evaluates a set of stored conditions with
either AND logic (all must pass) or OR logic (any passing is enough). It also ships two abstract
base form classes that wire those services up so consuming code is almost turnkey: one for a
condition-selection settings form, one for embedding a condition-configuration form. An alter
hook lets you narrow the list of selectable conditions per feature.

Because it is purely a library for developers, there is nothing to configure after enabling it —
its value shows up only in the modules built on top of it. It requires only core APIs (Condition,
Context, Form) and PHP 8.1+, and runs on Drupal 10 and 11.

This guide is written for a **human** developer. If you want terse, token‑cheap references for
an AI coding agent — the exact service method signatures, the evaluate flow, and the base-class
contracts — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it (usually as a
   dependency of a module that uses it).

## How to use it

There is nothing to click. From your own module you either call the services or extend the base
classes:

- **`conditions_helper.condition_selector_form_builder`** — builds a checkboxes element listing
  all condition plugins (sorted by label) for an admin to choose from.
- **`conditions_helper.form_builder`** — builds and submits the per-condition configuration
  sub-forms, including context-mapping for context-aware conditions.
- **`conditions_helper.evaluator`** — evaluates stored conditions:

  ```php
  $result = \Drupal::service('conditions_helper.evaluator')->evaluateConditions(
    $configured_conditions,   // [plugin_id => config]
    $all_must_pass = TRUE,    // TRUE = AND, FALSE = OR
    $additional_contexts = [] // extra runtime contexts, e.g. the current node
  ); // returns bool
  ```

The two base classes make a full feature near-turnkey:
`ConditionSelectorSettingsFormBase` (extends `ConfigFormBase`) gives you a settings form that
saves the chosen plugin IDs under a standardized `enabled_conditions` config key, and
`ConditionsFormBase` (extends `FormBase`) injects the form-builder service for embedding the
configuration UI. Your module supplies its own config schema for the stored condition data. The
method signatures, the `hook_conditions_helper_selector_definitions_alter()` hook, and the schema
recommendation are all in [`agent/api/services.md`](../agent/api/services.md) and
[`agent/extend/base-classes.md`](../agent/extend/base-classes.md).

## Where it lives in the admin menu

Nowhere — it adds no admin pages, menu links, permissions, or settings. Any UI you see comes from
the module that consumes Conditions Helper, not from Conditions Helper itself.
