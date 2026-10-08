# Entity Model — manual setup guide

**Entity Model** (`entity_model`) is a **developer** module that improves the
experience of working with Drupal's entity **bundle classes**. Defining custom
behavior for a specific entity type or bundle in Drupal normally means wiring up
hooks; Entity Model lets you register those classes through a simple `@Model`
**annotation** instead, and adds helper functions for field and translation
handling on top.

You create a model by writing a class in your module's `Entity` namespace, having
it extend the entity type's class, and annotating it with `@Model`. If you provide
only an `entity_type`, the module overrides that entity type's class; if you
provide both `entity_type` and `bundle`, it overrides the bundle class. A Drush
command, `drush entity_model:list`, reports which models are mapped to which
classes so you can confirm everything is wired up.

Beyond registration it offers a few conveniences for developers. Controllers can
have model entities **injected automatically** as method arguments by type hint
(matched by name when there are several of the same type). Two optional features
are toggled through the `entity_model.settings` configuration: setting
`override_account_proxy` to `true` makes the `current_user` service return the real
**User entity** instead of a lightweight session object, and setting
`resolve_form_state_argument_type` to `true` extends the same argument-resolution
convenience to `FormStateInterface` arguments.

Entity Model runs on Drupal 10.2 and 11 and has no module dependencies. As
developer infrastructure it carries no unusual runtime security surface of its own —
but because it helps define entity types and bundles (which carry access
implications), review the access handlers of any entities you model with it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no admin settings form** — the two optional features are toggled in the
`entity_model.settings` configuration (via a config export or `drush config:set`),
and everything else is done in code, as described in "How to use it" below.

## Where it lives in the admin menu

Entity Model adds no admin page. Its behavior is defined in your module's code
(annotated model classes) and, for the two optional features, in the
`entity_model.settings` configuration object.

## How to use it

1. In your custom module, add a class under its `Entity` namespace that extends the
   relevant entity/bundle class and carries the `@Model` annotation:

   ```php
   namespace Drupal\mymodule\Entity\Node;

   use Drupal\node\Entity\Node;

   /**
    * @Model(
    *   entity_type = "node",
    *   bundle = "page"
    * )
    */
   class Page extends Node {}
   ```

2. Run `drush entity_model:list` to confirm the model is mapped to your class.
3. Optionally type-hint your model class in a controller method to have the entity
   injected automatically.
4. Optionally set `override_account_proxy` and/or `resolve_form_state_argument_type`
   to `true` in `entity_model.settings` if you want those conveniences.
