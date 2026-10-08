<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle form (bundle_form) — agent index

Per-bundle content-entity form override via a plugin type. Instead of switching on bundle inside `hook_form_alter`, you write a `@BundleForm` plugin for an entity type + bundle and mutate the form in `overrideForm()`.

- **Version:** 1.0.x (1.0.2). Core `^11 | ^12`. Package `AB`. License GPL-2.0-or-later.
- **Dependencies:** none declared in `bundle_form.info.yml`. Paragraph support only runs when the contrib **paragraphs** module is present (`Hook\FormHooks` type-checks `ParagraphsWidget`).
- **Submodule:** `bundle_form_examples` — copy-ready example plugins → [modules/bundle_form_examples/1.0.x/agent/start.md](../modules/bundle_form_examples/1.0.x/agent/start.md).

## What it provides

- **Plugin type `bundle_form`** — manager `plugin.manager.bundle_form` (`BundleFormPluginManager`), base `BundleFormPluginBase`, interface `BundleFormInterface`, annotation `@BundleForm` (`src/Annotation/BundleForm.php`: `id`, `title`/`label`, `entity_type`, `bundle`, `weight`). Discovery namespace `Plugin/BundleForm`, alter hook `bundle_form_info`, cache bin key `bundle_form_plugins`.
- **Hook classes** (`bundle_form.services.yml`, OOP `#[Hook]` attributes):
  - `Hook\EntityHooks::entityTypeBuild()` — sets the `default` and `edit` form classes of **node** → `Form\NodeForm` and **taxonomy_term** → `Form\TermForm`.
  - `Hook\FormHooks::fieldWidgetSingleElementFormAlter()` — for **paragraph** subforms rendered by `ParagraphsWidget`.
- **Base forms** `Form\NodeForm` / `Form\TermForm` — subclass core `NodeForm` / `TermForm` and add `Form\BundleFormTrait`, which after `parent::buildForm()` calls `pluginManager->fetchInstances($entityTypeId, $bundle)` and runs each plugin's `overrideForm()`.
- **No** routes, permissions, config, services beyond the above, Drush, or config schema.

- **How it works + writing your own plugin (all entity types, weights, adding a new entity type)** → [api/plugins.md](api/plugins.md)

## Key facts

- Plugins targeting the same entity type + bundle run ordered by ascending `weight` (`BundleFormPluginManager::fetchInstances()` → `usort`).
- `overrideForm(array &$form, FormStateInterface $form_state, ?EntityInterface $entity = NULL)` — `$entity` is passed for node/term forms; for paragraphs it is null and the widget `$context` is available via `$form_state->get('context')`.
- Access control is unchanged: `NodeForm`/`TermForm` extend core forms, so entity create/edit access and field access are still enforced by core. Plugins only shape the render array of a form the user already reached.
