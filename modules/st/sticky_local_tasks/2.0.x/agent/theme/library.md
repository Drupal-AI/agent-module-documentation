# Libraries, templates, JS and theming

## Libraries (`sticky_local_tasks.libraries.yml`)

| Library | Assets | Dependencies | Attached when |
|---|---|---|---|
| `sticky_local_tasks/sticky-local-tasks` | `assets/css/sticky_local_tasks.css`, `assets/js/sticky_local_tasks.js` | `core/drupal`, `core/drupalSettings`, `core/once` | Always (added by `build()`). |
| `sticky_local_tasks/hide-default-local-tasks` | `assets/css/hide_default_local_tasks.css` | `sticky-local-tasks` | When `usage_options.hide_default_local_tasks` is true. Visually hides `.block-local-tasks-block`. |
| `sticky_local_tasks/gin` | `assets/css/sticky_local_tasks.gin.css` | `sticky-local-tasks` | When `usage_options.use_gin_colors` is true. Maps CSS vars to Gin's palette. |

## Theme hooks & templates

`hook_theme()` registers two hooks (both with a `base hook`, so they are theme-suggestion overrides of
core's local-task theming), preprocessed in `sticky_local_tasks.theme.inc`:

| Theme hook | Base hook | Template | Preprocess adds |
|---|---|---|---|
| `menu_local_tasks__sticky_local_tasks` | `menu_local_tasks` | `templates/menu-local-tasks--sticky-local-tasks.html.twig` | `position`, `dark_theme`, `gin_colors` (from the `#primary` element's `#position` / `#dark_theme` / `#use_gin_colors`). |
| `menu_local_task__sticky_local_tasks` | `menu_local_task` | `templates/menu-local-task--sticky-local-tasks.html.twig` | `url`, `text` (from the link element), and merged cacheability. |

`build()` sets `#theme => 'menu_local_tasks__sticky_local_tasks'` on the wrapper and, per task, prepends
the `menu_local_task__sticky_local_tasks` suggestion (via `addSuggestion()`). The wrapper template emits
`#sticky-local-tasks__main` containing a `.sticky-local-tasks__wrapper.sticky-local-tasks--{position}`
(plus optional `gin-colors` / `dark-theme` classes), a `<ul class="sticky-local-tasks__list ...">` of
tasks, and a toggle `<button data-sticky-local-tasks-toggle>` with `aria-expanded` / `aria-controls`.
Each task `<li class="nav-item ...">` gets an icon class `nav-item--<name>` from
[hooks/route-alter.md](../hooks/route-alter.md).

## JavaScript (`assets/js/sticky_local_tasks.js`)

`Drupal.behaviors.stickyLocalTasks` (guarded by `core/once` on `[data-sticky-local-tasks-toggle]`):
the toggle button shows/hides the `[data-sticky-local-tasks-items]` panel (adds/removes the `show`
class, toggles `display` and `aria-expanded`). When `drupalSettings.stickyLocalTasks.rememberToggledState`
is true it persists the open state in `localStorage` under key `Drupal.sticky_local_tasks.shown`;
when false it removes any stored key. Only display/toggle state — no personal data is stored or sent.

## Colors / CSS variables

`sticky_local_tasks.css` defines the light palette as custom properties on
`.sticky-local-tasks__wrapper` (e.g. `--slt-background`, `--slt-background2`, `--slt-background3`,
`--slt-background-hover`, `--slt-text-color`, `--slt-svg-fill-color`, `--slt-icon-color`,
`--slt-icon-background`). The `.dark-theme` class (from `use_dark_theme`) overrides them with dark
values; the `gin` library / `gin-colors` class remaps them to Gin theme variables. Override any of these
in your theme's CSS to restyle the widget. Icons ship in `assets/img/icon--*.svg`.
