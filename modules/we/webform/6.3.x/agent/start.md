# webform — agent start

Form/survey builder. Forms are `webform` **config entities**; responses are
`webform_submission` **content entities**. Admin UI: **Admin → Structure → Webforms**
(`/admin/structure/webform`, configure route `entity.webform.collection`). Global settings at
`/admin/structure/webform/config`. Depends on core `field`, `filter`, `user`.

- Build a form: elements, YAML source, conditional logic, wizards → [configure/build-form.md](configure/build-form.md)
- Handle submissions: email, remote post, confirmations, exporters → [configure/handlers.md](configure/handlers.md)
- Plugin types it defines (Element/Handler/Exporter/Variant/SourceEntity) → [plugins/plugins.md](plugins/plugins.md)
- Call services / work with forms & submissions in code → [api/api.md](api/api.md)
- Alter hooks (elements, handlers, options, access, submissions) → [hooks/hooks.md](hooks/hooks.md)
- Drush commands (generate, export, purge, repair, libraries) → [drush/drush.md](drush/drush.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Notable submodules: webform_ui, webform_node, webform_options_custom, webform_options_limit,
  webform_scheduled_email, webform_submission_log, webform_access, webform_share, webform_cards
  (each documented at `modules/<sub>/6.3.x/`).
