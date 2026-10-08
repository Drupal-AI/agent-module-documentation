# Internals — render pipeline, URL resolution, JS, theming

The module ships no callable services or public API. Its behavior is the style plugin plus a
preprocess function, a Twig template, and a small JS behavior. Override points below.

## Plugin

`Drupal\views_jump_menu\Plugin\views\style\JumpMenu` (`@ViewsStyle id = "jump_menu"`,
`title = "Jump Menu"`, `theme = "views_jump_menu"`, `display_types = {"normal"}`),
extends `StylePluginBase`. Flags: `usesRowPlugin = FALSE`, `usesRowClass = FALSE`,
`usesFields = TRUE`. It only declares options and the options form — no custom `render()`
(the base render calls the theme with the view + rows).

## Preprocess — `views_jump_menu_preprocess_views_jump_menu(&$variables)`

Runs per rendered menu. Steps:

1. Reads `$view->style_plugin->options`.
2. Adds `wrapper_class` to the container `attributes['class']` when set.
3. Builds a unique id via `Html::getUniqueId("<viewid>-<display>-jump_menu")` so several
   jump menus on one page stay independent.
4. Attaches `drupalSettings.viewsJumpMenu[<id>].new_window` = the `new_window` option.
5. Builds `$select` with `select_text`, `select_label`, and `attributes` (classes from
   `_views_jump_menu_get_select_classes()` — always includes `ViewsJumpMenu` and
   `js-viewsJumpMenu`, plus the user `class`; `title` = `select_text`; `id`).
6. If `label_field` is set, for each row it calls `advancedRender()` on the label and URL
   field handlers, then per option:
   - `label` = `Html::decodeEntities(strip_tags(advancedRender(label_field)))` (plain text).
   - `url`: if the URL field handler is a `Drupal\views\Plugin\views\field\EntityLink` and its
     text has **not** been rewritten (`!options['alter']['alter_text']`), uses
     `$url_field->getEntity($row)->toUrl('canonical', ['language' => <current language>])`;
     otherwise uses the field's rendered output (`advancedRender($row)`).

So: to link to canonical entity pages, use an unaltered entity-link URL field; to link to
rewritten/external URLs, use a field with "Rewrite results / alter text" enabled.

## Template — `templates/views-jump-menu.html.twig`

Theme hook `views_jump_menu` (variables `view`, `rows`; preprocess adds `attributes`, `select`,
`title`). Emits an optional wrapper `<div>`, optional `<h3>{{ title }}</h3>`, then a `<select>`
with `aria-label` (when `select.select_label` set), a first placeholder `<option>{{ select.select_text }}</option>`,
and one `<option data-url="{{ option.url }}">{{ option.label }}</option>` per row. Attaches
`views_jump_menu/views-jump-menu`. Override by copying this template into your theme.

## JS behavior — library `views_jump_menu/views-jump-menu`

`js/views-jump-menu.js` (depends on `core/drupal`). `Drupal.behaviors.viewsJumpMenu` binds a
`change` handler to every `.js-viewsJumpMenu`: reads `selectedOptions[0].dataset.url`; if empty,
does nothing; if `settings.viewsJumpMenu[<id>].new_window` is true it calls
`window.open(url, '_blank', 'noopener')` and resets the select, otherwise sets `window.location = url`.

## No configure/permissions/services/drush

`hook_help` and `hook_theme` are the only other module hooks. There is no permission, settings
form, service, event subscriber, or Drush command.
