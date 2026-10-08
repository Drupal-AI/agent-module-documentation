# Forms Steps Drush commands

Provided by `\Drupal\forms_steps\Commands\FormsStepsCommands` (`drush.services.yml`).

## `forms_steps:attach-entity` (alias `fs-attach-entity`)
Attach a specific entity entry to a Forms Steps workflow step / instance.

```
drush forms_steps:attach-entity <workflow> <entity_type> <bundle> <id> <form_mode> <step> [options]
```

Arguments:
- `workflow` — the `forms_steps` config entity id.
- `entity_type` — e.g. `node`.
- `bundle` — e.g. `article`.
- `id` — the entity id to attach.
- `form_mode` — the form mode id used by the step.
- `step` — the step id within the workflow.

Options:
- `--instance_id=<uuid>` — attach to an **existing** workflow instance (otherwise a new
  instance UUID is created).
- `--ignore_entity_id_check` — skip verifying the entity id exists before attaching.

Examples:
```
# New instance:
drush forms_steps:attach-entity example_1 node article 12345678 default step1

# Existing instance:
drush forms_steps:attach-entity example_1 node article 12345678 default step1 \
  --instance_id=51e4e52a-d9d9-44c4-9aa1-9b075255e18c
```

Returns an array with the workflow id and instance on success. It validates that the workflow
and step exist (and, unless `--ignore_entity_id_check`, that the entity exists), printing an
error and returning NULL otherwise. Deps injected: `entity_type.manager`, `uuid`.
