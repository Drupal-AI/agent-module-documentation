# Theming — Better Local Tasks

All logic is in `better_local_tasks.module` (three hooks) plus templates and CSS. No config.

## When it activates

`hook_page_attachments_alter()`:

```php
if (!\Drupal::currentUser()->hasPermission('access contextual links')) return;   // gate 1
if (!$router.admin_context->isAdminRoute()) {                                    // gate 2
  $attachments['#attached']['library'][] = 'better_local_tasks/local-tasks';
}
```

So the CSS is attached only for users who can see contextual links, and only on **non-admin**
routes. The template overrides (below) are likewise applied only on non-admin routes.

## Template overrides

`hook_theme_registry_alter()` (skipped on admin routes):

| Theme hook | Points at | Template |
|---|---|---|
| `block__local_tasks_block` | `templates/block/` | `block--local-tasks-block.html.twig` — extends `block.html.twig`, wraps tabs in `<nav class="blt-tabs" aria-label="Tabs">`. |
| `menu_local_tasks` | `templates/navigation/` | `menu-local-tasks.html.twig` — primary/secondary tabs as `<ul class="blt-tabs primary|secondary">`. |

(The block override is registered by cloning the core `block` theme entry if
`block__local_tasks_block` is not already defined.)

## Per-tab CSS classes

`hook_preprocess_menu_local_task()` maps each task's route name to a class added to
`$variables['link']['#attributes']['class']`:

| Route suffix (regex) | Class |
|---|---|
| `.canonical` | `view` |
| `.edit_form` | `edit` |
| `.delete_form` | `delete` |
| `.version_history` | `revisions` |
| `.devel_load` | `devel` |
| `.content_translation_overview` | `translate` |
| `.clone_form` | `clone` |
| `shortcut.set_switch` | `shortcuts` |

`css/local_tasks.css` uses these classes to render the icons shipped in `img/*.svg`
(`icon-edit.svg`, `icon-delete.svg`, `icon-revisions.svg`, `icon-translate.svg`, `icon-view.svg`,
`icon-newdraft.svg`, `icon-managedisplay.svg`, `icon-shortcuts.svg`, `icon-devel.svg`).

## Library

`better_local_tasks.libraries.yml` defines `local-tasks` = `{ css: { theme: css/local_tasks.css } }`
— CSS only, no JS.

## Customising

- Override the `blt-tabs` styles in your theme's CSS, or place the copied templates in your theme
  to change markup.
- Note the `shortcut.set_switch` branch in the preprocess hook uses `=` (assignment) rather than
  `==`, so that class is effectively always applied last regardless of route — cosmetic only.
