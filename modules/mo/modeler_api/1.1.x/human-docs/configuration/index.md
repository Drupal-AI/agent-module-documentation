# Configuration

Modeler API's own settings are deliberately small — the framework generates most of
its admin UI (model listings, add/edit/import/export screens) dynamically from the
model owners and modelers you have installed. The settings form itself is where you
tell it, for each owner/modeler pairing, how to present and store models.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Workflow → Modeler API**
   (`/admin/config/workflow/modeler_api`).

The form lists every combination of a model owner (for example ECA) and a modeler
(for example BPMN.iO) that you have installed. For each combination you choose:

- **Theme** — which editor theme/presentation the modeler should use for that
  owner's models.
- **Storage** — how the raw diagram data (the modeler's native XML or JSON) is kept.

### Storage methods

The raw modeler data can be stored one of three ways per owner/modeler combination:

- **As third-party settings** on the owner's config entity — the diagram travels with
  the entity.
- **In a separate config entity** — the diagram is stored on its own.
- **Not stored at all** — the diagram is re-derived from the config entity when
  needed.

Note that a model owner can *pin* its preferred storage method, in which case that
choice is enforced and you cannot change it from this form.

Click **Save configuration** to apply. These settings are stored in the
`modeler_api.settings` config object, so they export and deploy with your
configuration. (The models themselves are separate config entities.)

## Permissions

Modeler API defines one static permission at **People → Permissions**:

- **Administer modeler_api** (`administer modeler_api`) — general administration of
  the framework.

All the other permissions are **generated dynamically**, one set per model owner
(and a couple per modeler/owner combination) — up to eleven per owner, covering
things like viewing the model collection, creating, editing, deleting, viewing,
editing metadata, switching context, testing, replaying execution, and managing
templates. These appear on the permissions page once the relevant owner is
installed, and they gate the auto-generated model-management routes.

## Drush commands

The module provides several Drush commands for managing models from the command
line:

- `drush modeler_api:update` — update all models if their underlying plugins have
  changed.
- `drush modeler_api:enable <owner_id>` — enable all models of a given owner.
- `drush modeler_api:disable <owner_id>` — disable all models of a given owner.
- `drush modeler_api:model:export <owner_id> <id>` — export a model as a Drupal
  recipe. Options: `--namespace=<vendor>` (the Composer package prefix) and
  `--destination=<path>` (the output directory).
