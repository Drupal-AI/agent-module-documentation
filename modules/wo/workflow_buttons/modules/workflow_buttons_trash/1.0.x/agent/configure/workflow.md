# The Trash workflow

Enabling `workflow_buttons_trash` installs one workflow config,
**`workflows.workflow.workflow_buttons_trash_publishing`** (label "Publishing (with draft and
soft delete)", type `content_moderation`). There is no settings form — you apply the workflow to
content types under *Configuration → Workflows* (`/admin/config/workflow/workflows`), then set the
moderation_state form widget (e.g. the parent module's Workflow buttons) on those bundles.

## States (`type_settings.states`)

| State id | Label | published | default_revision |
|---|---|---|---|
| `draft` | Draft | false | false |
| `published` | Published | true | true |
| `trash` | Trash | false | true |
| `unpublished` | Unpublished | false | true |

`default_moderation_state: draft`.

## Transitions (`type_settings.transitions`)

| Transition id | Label | From → To |
|---|---|---|
| `create_new_draft` | Save | draft → draft |
| `save_draft_leave_current_published` | Create draft (leave current version published) | published → draft |
| `publish` | Publish | draft, unpublished → published |
| `update` | Update | published → published |
| `unpublish` | Unpublish | published → unpublished |
| `save_unpublished` | Save | unpublished → unpublished |
| **`delete`** | Delete | draft, published, unpublished → **trash** |
| **`restore_draft`** | Restore to Draft | trash → draft |
| **`restore_publish`** | Restore and Publish | trash → published |

The `delete` transition is what makes deletion "soft": it moves content to the `trash` state
instead of removing it. With Workflow buttons, `delete` renders as a red danger button.

## Read / edit with drush

```bash
# What state does 'delete' move content to?
drush cget workflows.workflow.workflow_buttons_trash_publishing type_settings.transitions.delete.to
# The trash state's label:
drush cget workflows.workflow.workflow_buttons_trash_publishing type_settings.states.trash.label
```

```php
// Change the default moderation state:
\Drupal::configFactory()->getEditable('workflows.workflow.workflow_buttons_trash_publishing')
  ->set('type_settings.default_moderation_state', 'draft')->save();
```

## Restore the shipped workflow

If deleted, re-import from the submodule's default config:

```php
use Symfony\Component\Yaml\Yaml;
$p = \Drupal::service('extension.list.module')->getPath('workflow_buttons_trash')
   . '/config/install/workflows.workflow.workflow_buttons_trash_publishing.yml';
$data = Yaml::parseFile(DRUPAL_ROOT . '/' . $p);
\Drupal::configFactory()->getEditable('workflows.workflow.workflow_buttons_trash_publishing')
  ->setData($data)->save(TRUE);
```

## The Trash tab

`workflow_buttons_trash.routing.yml` defines route `workflow_buttons_trash.admin_trashed_content`
at `/admin/content/trash` (title "Trash", permission "view any unpublished content") and a local
task under *Content*. In this release the route ships a title + permission only (no controller), so
treat it as a placeholder tab; the workflow config is the functional deliverable.
