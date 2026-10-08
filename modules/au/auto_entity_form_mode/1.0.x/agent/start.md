<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto entity form mode (auto_entity_form_mode) — agent index

A one-hook developer helper. It automatically registers every custom **entity form mode** as a
form **handler class** on its entity type, so custom code can call
`entity.form_builder->getForm($entity, '<form_mode>')` without first writing a
`hook_entity_type_build()`/`hook_entity_type_alter()`. No UI, no config, no permissions, no routes,
no services, no dependencies. Core requirement `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.0.

- **How the registration hook works, what it registers, and how to use a form mode in code** →
  [api/registration.md](api/registration.md)

## What it actually is

- A single procedural implementation: `auto_entity_form_mode_entity_type_alter(array &$entity_types)`
  in `auto_entity_form_mode.module`. That is the entire module.
- No `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `*.install`, `config/` (schema or
  install), `src/`, plugins, or library. Nothing web-exposed is added.
- The only other files are the `tests/` fixtures (`auto_entity_form_mode_test` submodule with three
  `core.entity_form_mode.*` config fixtures + `AutoEntityFormModeKernelTest`).

## Mechanism (from source)

- On `hook_entity_type_alter()`, it iterates every entity type. For each, it reads form-mode config
  IDs directly from the config factory with
  `configFactory->listAll('core.entity_form_mode.' . $entity_type_id)` (reads config, **not** the
  entity storage, to avoid a recursive load during entity-type build).
- For each mode config it takes the `id` (e.g. `node.my_custom_node_form_display`), splits on `.`,
  and uses the second segment as the form-handler key.
- It skips modes whose form class is already registered (`hasHandlerClass('form', $key)`), otherwise
  copies the entity type's `default` form class onto that key with
  `setFormClass($key, $default_entity_form_class)`.

## Security / caveats

- No user input, routes, external calls, database queries, or rendering — nothing adversarial to
  reach. Registered modes reuse the **default** form class, so core entity/field access and
  validation are unchanged; the module only makes the mode addressable in code. See
  [api/registration.md](api/registration.md) for operational notes.
