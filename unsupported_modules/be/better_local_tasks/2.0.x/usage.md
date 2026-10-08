Better Local Tasks restyles Drupal's local-task tabs (View / Edit / Delete / Revisions …) with a fancier UI by overriding the local-tasks templates and attaching its own CSS on non-admin routes.

---

The module (project `betterlt`, machine name `better_local_tasks`) is a pure theming layer with no config, permissions, dependencies or JavaScript. `hook_page_attachments_alter()` attaches the `better_local_tasks/local-tasks` CSS library — but only when the current user has the core `access contextual links` permission and the current route is **not** an admin route. `hook_theme_registry_alter()` swaps in the module's own templates for the local-tasks block and the local-tasks menu on non-admin routes: `templates/block/block--local-tasks-block.html.twig` (wraps the tabs block in a `<nav class="blt-tabs">`) and `templates/navigation/menu-local-tasks.html.twig` (renders primary/secondary tabs as `<ul class="blt-tabs">`). `hook_preprocess_menu_local_task()` inspects each task's route name and adds a semantic CSS class to the tab — `view`, `edit`, `delete`, `revisions`, `devel`, `translate`, `clone`, or `shortcuts` — which the bundled `css/local_tasks.css` uses to show per-action icons (SVGs shipped under `img/`). Enabling the module is the entire setup: styling applies automatically on the front end.

---

- Give the front-end local-tasks tabs a modern, styled appearance instead of core's plain tabs.
- Show icons next to View / Edit / Delete / Revisions / Translate / Clone / Devel / Shortcuts tabs.
- Restyle the local-tasks block placed in a theme region.
- Keep the fancier tabs off admin routes (they only apply to non-admin pages).
- Only render the enhanced tabs for users who can see contextual links.
- Improve editor UX on content pages without writing a custom theme.
- Add semantic per-action CSS classes to local tasks for further theming.
- Wrap the tasks block in an accessible `<nav aria-label="Tabs">` element.
- Provide consistent tab styling across content types without theme changes.
- Override the local-tasks menu template site-wide by enabling one module.
- Ship action icons (edit, delete, revisions, translate, clone, devel, shortcuts, view) via CSS.
- Give reviewers clear, icon-labelled tabs on node/entity view pages.
- Add a lightweight visual upgrade to tabs with no configuration to manage.
- Base further custom CSS on the module's `blt-tabs` classes.
- Restyle primary and secondary tabs together.
- Enhance local tasks on media, taxonomy or user entity pages (non-admin views).
- Avoid a full admin-theme change just to make front-end tabs look better.
- Use as a drop-in tabs skin on a decoupled-lite/front-end-heavy Drupal site.
- Distinguish the current/active tab visually through the shipped stylesheet.
- Provide a starting point for teams that want to fork the tab templates/CSS.
