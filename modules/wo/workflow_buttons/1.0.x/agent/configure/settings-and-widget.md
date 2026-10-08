# Configure Workflow buttons

## Prerequisite

The bundle must be under **Content Moderation** (a `content_moderation` workflow that includes
the entity type + bundle). The buttons come from that workflow's transitions.

## Enable the widget (per bundle)

On the bundle's **Manage form display** (`/admin/structure/types/manage/<type>/form-display`), set
the **Moderation state** field's widget to **"Workflow buttons"** (widget id `workflow_buttons`),
Update, Save. The module also registers `workflow_buttons` as the moderation_state field's default
form widget via `hook_entity_base_field_info_alter()`, so on many sites it is already the default.

Widget setting:

| Setting | Type | Meaning |
|---|---|---|
| `show_current_state` | bool | Show the current moderation state in the form's meta/sidebar section. |

Schema: `field.widget.settings.workflow_buttons` (maps `show_current_state`).

> Note: the `moderation_state` widget is a core base-field default managed by Content Moderation,
> so on some setups it is not written into the `entity_form_display` config as a normal component —
> it is resolved from the field's default display options.

## Global settings

Config object **`workflow_buttons.settings`**, form route `workflow_buttons.settings` at
`/admin/config/workflow/workflow-buttons` (permission `administer site configuration`, menu under
*Configuration → Workflow*).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `display.top_buttons` | bool | `false` | Also show the workflow buttons at the **top** of the edit form (as well as the bottom). With the Gin admin theme the buttons live in its sticky header, so a second set is added at the bottom instead. |

```bash
# Turn on top + bottom buttons:
drush cset workflow_buttons.settings display.top_buttons true -y
# Read it back:
drush cget workflow_buttons.settings display.top_buttons
```

```php
\Drupal::configFactory()->getEditable('workflow_buttons.settings')
  ->set('display.top_buttons', TRUE)->save();
```

## What the buttons look like

One button per transition the current user may perform (from
`content_moderation.state_transition_validation`), clustered as a dropbutton in `form.actions`.
Each button's `#value` is the **transition label**; each gets class
`workflow-buttons-<transition_id>`. The first button and any `publish` transition keep
`#button_type = primary`; a `delete` transition becomes a red danger/trash button. The default
Save/Publish/Unpublish buttons and the Published checkbox are hidden.
