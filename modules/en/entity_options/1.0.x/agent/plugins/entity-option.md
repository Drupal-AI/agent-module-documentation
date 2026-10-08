<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EntityOption plugin type

Discoverable annotation plugin. Define one class per option; the module wires it into the
node-type and node forms automatically.

## Annotation (`src/Annotation/EntityOption.php`)

`@EntityOption` keys:
- `id` — machine id (also the option key used everywhere).
- `label` — translated admin label.
- `description` — translated description (default `''`).
- `allow_overrides` — bool (default `FALSE`); whether the option can be overridden per node.

Manager: `plugin.manager.entity_options` (`Service\EntityOptionsPluginManager`), plugin namespace
`Plugin/EntityOption`, interface `EntityOptionInterface`, alter hook
`hook_entity_options_info(&$definitions)`, cache key `entity_options_plugins`.

## Interface (`src/Plugin/EntityOptionInterface.php`)

`getLabel()`, `getDescription()`, `allowsOverrides(): bool`, `getStatus(): bool`, `getOverride()`,
`isFlag()`, and `settingsForm(array $form, FormStateInterface $form_state, array $values): ?array`.
Extends core `PluginInspectionInterface` and `ConfigurableInterface`.

## Base class (`src/Plugin/EntityOptionBase.php`)

`abstract EntityOptionBase extends PluginBase`. Extend it and add only an `@EntityOption`
annotation to get a **simple flag (checkbox) option — no further code needed**.

- `defaultConfiguration()` → `['status' => FALSE, 'overrides' => FALSE]`; the constructor
  `array_replace_recursive`s configuration over defaults.
- `getStatus()` reads `configuration['status']`; `getOverride()` reads `configuration['overrides']`;
  `allowsOverrides()` reads the annotation's `allow_overrides`.
- `isFlag()` returns `TRUE`, and `settingsForm()` returns `NULL` — that is what marks it a flag.
- `getConfiguration()` / `setConfiguration()` read/write `configuration['configuration']`.

## Defining a configurable (parametric) option

Extend `EntityOptionBase`, override `isFlag()` to return `FALSE`, and implement `settingsForm()`
to return form elements collecting the parameters. When `settingsForm()` returns a non-empty
array the form-alter and widget render those elements instead of a bare checkbox (see
[../api/mechanism.md](../api/mechanism.md)).
