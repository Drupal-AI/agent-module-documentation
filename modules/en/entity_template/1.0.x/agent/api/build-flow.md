<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The build flow

Turns a configured builder + blueprint into a saved entity. Controller
`src/Controller/EntityTemplateController.php`, form
`src/Form/BuilderParameterProvisionForm.php`, builder base
`src/Plugin/EntityTemplate/Builder/BuilderBase.php`.

## Steps

1. **Select builder** — `selectBuilder()` lists every builder plugin as links to the
   parameters step. Path `/entity_template/build`.
2. **Provide parameters** — `BuilderParameterProvisionForm::buildForm()` renders one form
   element per builder context definition (`entity_autocomplete` for entity contexts, else
   `textfield`). `submitForm()` loads entity parameters via storage, generates a
   `session_key` (UUID, also stored in the session as
   `entity_builder_{builder}_session_key`), and saves the collected parameters to the
   **private** entity-builder tempstore under `builder_parameters__{session_key}`.
3. **Select blueprint** — `selectTemplateBlueprint()` calls
   `builder->getAvailableBlueprints()`. If exactly one is available it redirects straight to
   the edit step; otherwise it lists blueprints to choose from.
4. **Edit & save** — `displayEntityForm()` reads the parameters from the tempstore, calls
   `builder->execute($parameters, currentUser(), $blueprint_key)`, takes the first result
   entity, re-loads it by UUID if it was already saved, and returns
   `entityFormBuilder->getForm($entity, 'default', ['entity_builder_tempstore_delete' => …])`.
   Submitting that standard entity form saves the entity;
   `entity_template_form_alter()` (in `entity_template.module`) appends a submit handler that
   deletes the tempstore entry afterwards.

## Blueprint execution

`BuilderBase::execute()` resolves the blueprint (by `provider:key`, or the highest-priority
available one — throwing `MultipleAvailableBlueprintException` on a tie or
`NoAvailableBlueprintException` when none apply), injects a `current_user` context when the
blueprint declares one, and calls `$blueprint->execute($parameters)`. The blueprint runs its
templates (`Template::execute()`), which create the target entity and apply each component
(see [../plugins/components.md](../plugins/components.md)). `ConfigTemplateBlueprint`
(`blueprint_config`) sources blueprints from `entity_template_blueprint` config entities.

## Contexts vs. parameters

Builder **parameters** (from step 2) become the typed-data **contexts** a template exposes via
`getTemplateContexts()`. Components read them: Twig components receive context *values*
(e.g. a User entity), placeholder components receive context *typed data*. This is how a
tokenised/Twig field value is filled from what the user entered at the parameters step.

## Services used

- `entity_template.entity_builder_tempstore` (`EntityBuilderTempStoreRepository`, private
  tempstore) — build parameters.
- `entity_template.blueprint_tempstore_repository` (shared tempstore) +
  `entity_template.blueprint_param_converter` — used by the UI submodule while editing a
  blueprint before it is saved.
- Plugin managers `plugin.manager.entity_template.{builder,template,component,blueprint_provider}`.
