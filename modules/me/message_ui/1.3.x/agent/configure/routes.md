# Routes & forms

Message UI adds no settings page; its "configuration" is the set of entity routes/forms it
registers (in `message_ui.routing.yml` and via a message entity-type alter). Message entity
forms are `message.add` / `message.edit` / `message.delete` (`Drupal\message_ui\Form\*`).

| Route | Path | Purpose | Access requirement |
|---|---|---|---|
| `message_ui.add_page` | `/message/add` | List creatable templates (theme `message_add_list`); redirects if only one | `_entity_create_access: message` |
| `message_ui.add` | `/message/add/{message_template}` | Create-message form for a template | `_entity_create_access: message:{message_template}` |
| `entity.message.canonical` | `/message/{message}` | View a message | `_entity_access: message.view` |
| `entity.message.edit_form` | `/message/{message}/edit` | Edit a message | `_entity_access: message.update` |
| `entity.message.delete_form` | `/message/{message}/delete` | Delete a message (confirm) | `_entity_access: message.delete` |
| `message_ui.message_multiple_delete_form` | `/admin/config/message/message_delete_multiple` | Bulk delete | `_permission: delete multiple messages` |

`MessageController::addPage()` loads all `message_template` entities the user has create access
to; with exactly one it 302s to `message_ui.add`; with none it prints a link to
`message.template_add`.

Access is decided by `Drupal\message_ui\MessageAccessControlHandler` (registered by the module
on the message entity type). It honours `bypass message access control`, the per-template
permissions, and the `hook_message_message_ui_access_control` /
`hook_message_message_ui_create_access_control` hooks (see [../hooks/hooks.md](../hooks/hooks.md)).

Create a message programmatically (what the add form does):

```php
$message = \Drupal\message\Entity\Message::create(['template' => 'my_template']);
$message->save();
```

Services: `message_ui.field_display_manager`
(`MessageUIFieldDisplayManagerService`, arg `@entity_type.manager`) and the plugin manager
`plugin.manager.message_ui_views_contextual_links` (see [../plugins/contextual-links.md](../plugins/contextual-links.md)).
