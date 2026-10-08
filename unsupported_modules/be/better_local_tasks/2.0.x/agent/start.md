# Better Local Tasks — agent index

Pure theming module (project `betterlt`, machine name `better_local_tasks`) that restyles
Drupal's local-task tabs on **non-admin** routes. No config (`configure` null), no permissions,
no dependencies, no JS, no schema, no Drush. Enabling it is the whole setup.

- **Templates, CSS library, the preprocess CSS classes, and the admin-route/permission gate** →
  [theming/theming.md](theming/theming.md)

Key facts:
- `hook_page_attachments_alter()` attaches `better_local_tasks/local-tasks` CSS only when the
  user has core `access contextual links` **and** the route is not an admin route.
- `hook_theme_registry_alter()` points `block__local_tasks_block` and `menu_local_tasks` at the
  module's templates (`templates/block`, `templates/navigation`) on non-admin routes.
- `hook_preprocess_menu_local_task()` adds a semantic class per tab (`view`, `edit`, `delete`,
  `revisions`, `devel`, `translate`, `clone`, `shortcuts`) used by `css/local_tasks.css` + `img/*.svg`.
