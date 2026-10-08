Message UI adds the missing web interface for the Message module: routes and forms to create, view, edit and delete Message entities, plus granular per-template permissions.

---

The Message module stores activity/log Message entities but ships almost no UI; Message UI fills that gap. It registers routes for `/message/add` (a list of creatable templates), `/message/add/{message_template}` (create form), `/message/{message}` (canonical view), `/message/{message}/edit`, `/message/{message}/delete`, and a bulk `/admin/config/message/message_delete_multiple` form. It defines a set of permissions — global ones like `bypass message access control`, `update tokens`, `delete multiple messages`, and template-scoped ones (`view/edit/create/delete any message template`) — plus a permission callback that generates per-template permissions (`view <template> message`, `create <template> message`, etc.) for every Message template. Access is enforced by `MessageAccessControlHandler`, which also invokes hooks so other modules can allow or deny operations. Message UI additionally defines a small plugin type, `message_ui_views_contextual_links` (plugins: `view`, `edit`, `delete`), used to attach operation links to Message rows in Views, and a Views field/action for that. It depends on `message` and `views`; the optional submodule `message_notify_ui` adds a "Send" form on top. It has no settings page (`configure: null`) and no config object.

---

- Give site builders a `/message/add` page listing every message template a user may create.
- Let editors create a Message entity of a chosen template through a real Drupal form.
- View a single message at `/message/{id}` with a proper canonical route and title.
- Edit an existing message instance via `/message/{id}/edit`.
- Delete a message instance with a confirm form at `/message/{id}/delete`.
- Bulk-delete many messages from `/admin/config/message/message_delete_multiple`.
- Grant a role permission to create only messages of a specific template (`create <tpl> message`).
- Grant view/update/delete rights per message template to different roles.
- Give trusted admins `bypass message access control` for full CRUD over any message.
- Allow certain users to update message tokens via the `update tokens` permission.
- Add view/edit/delete contextual links to Message rows in a Views listing.
- Build a moderation screen for messages using the Views field the module provides.
- Redirect straight to the create form when only one message template is creatable.
- Integrate custom access rules through `hook_message_message_ui_access_control()`.
- Alter message create access per template with `hook_message_message_ui_create_access_control()`.
- Alter the rendered message output with `hook_message_ui_view_alter()`.
- Narrow the bulk-delete query with `hook_message_ui_multiple_message_delete_query_alter()`.
- Expose message creation as a menu local action for content teams.
- Let a support team log interaction messages against users through the UI.
- Provide an editorial audit trail of message instances that admins can browse and prune.
- Restrict message deletion to a dedicated role while allowing others to only view.
- Use per-template permissions to separate notification types by editorial responsibility.
- Add a "Send" action on top (via message_notify_ui) to notify recipients of a message.
- Manage large volumes of messages by deleting them in batches through the multiple-delete form.
- Surface message operations directly inside administrative Views without custom code.
