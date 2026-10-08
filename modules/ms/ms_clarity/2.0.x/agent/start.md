# Microsoft Clarity — agent index

Injects the Microsoft Clarity analytics tag (`clarity.ms/tag/<id>`) into the HTML head via
`hook_page_attachments`, gated by page- and role-visibility rules. External SaaS analytics;
admin-configured project ID. No plugins, no Drush.

- **Settings form, config keys, page/role visibility logic, how the tag is emitted** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config route `ms_clarity.admin_settings_form` at `/admin/config/services/microsoft_clarity`, permission `administer microsoft clarity`.
- Config `ms_clarity.settings`: `account` (project ID, validated `^[a-zA-Z0-9]+$`), `visibility.request_path_mode`, `visibility.request_path_pages`, `visibility.user_role_mode`, `visibility.user_role_roles`.
- Services: `ms_clarity.accounts` (project ID), `ms_clarity.visibility` (`VisiblityTracker`, path+role matching).
- Tag emitted only when a project ID is set AND page-visibility AND role-visibility all pass.
- Template `templates/script-head.html.twig` renders the Clarity loader with `{{ id }}`.
