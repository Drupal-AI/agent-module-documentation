<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: forms_steps:attach-entity

Registered via `drush.services.yml` → `FormsStepsCommands` (`src/Commands/FormsStepsCommands.php`,
extends `DrushCommands`; deps `entity_type.manager`, `uuid`).

## `forms_steps:attach-entity` (alias `fs-attach-entity`)

Binds an existing/migrated entity to a Forms Steps workflow step by creating a
`forms_steps_workflow` row, so the entity becomes editable from that step's URL.

```
drush forms_steps:attach-entity <forms_steps> <entity_type> <bundle> <id> <form_mode> <step> [options]
```

Arguments: `forms_steps` (collection machine name), `entity_type`, `bundle`, `id` (entity id),
`form_mode` (form mode machine name), `step` (step machine name).

Options:
- `--instance_id=<uuid>` — attach to an existing workflow instance instead of generating a new UUID.
- `--ignore_entity_id_check` — skip the existence check that loads the entity by id first.

Examples:
```
drush forms_steps:attach-entity my_form_steps node article 1 default step_1
drush forms_steps:attach-entity my_form_steps node article 1 default step_1 --instance_id=e479f307-729d-458e-88cb-7aa440cdac89
drush forms_steps:attach-entity my_form_steps node article 1 default step_1 --ignore_entity_id_check
```

Behavior (`attachEntityToStep()`): validates the workflow exists and has the given step; unless
`--ignore_entity_id_check`, verifies the entity id loads; then creates and saves the workflow row and
returns `['id' => <workflow id>, 'instance_id' => <uuid>]`. Errors are yelled to the console and logged
critical to watchdog. This is an admin/CLI operation.
