<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Gin Everywhere works

The whole module is two hooks on a single autowired service
(`Drupal\gin_everywhere\Hook\GinEverywhereHooks`, wired via `gin_everywhere.services.yml`),
plus an install-time requirement check. There is **no configuration**.

## Requirements — `gin_everywhere.install`

`hook_requirements('install')` fails installation unless the **Gin** theme exists
(`theme_handler->themeExists('gin')`), unless Gin is part of the install profile being
installed. So the module cannot normally be enabled without Gin present.

## Hook 1 — `hook_gin_content_form_routes_alter($routes)`

Tells Gin which routes get its content-form layout. `ginContentFormRoutesAlter()` iterates
`entityTypeManager()->getDefinitions()` and, for every entity type whose
`getGroup() === 'content'`, appends:

```
entity.<type>.create_form
entity.<type>.edit_form
entity.<type>.override_form
<type>.add
entity.<type>.add_form
entity.<type>.revision
entity.<type>.content_translation_add
```

Then a fixed set of extras that don't follow the pattern:

```
block_content.add_page
block_content.add_form
entity.block_content.canonical
entity.media.canonical
entity.menu.add_link_form
entity.menu_link_content.canonical
```

This is additive — Gin's own default routes remain; Gin Everywhere only extends the list.

## Hook 2 — `hook_form_alter($form, $form_state, $form_id)`

`formAlter()` guards heavily, then restructures the form:

1. **Guard:** returns unless Gin's `GinContentFormHelper::isContentForm()` is TRUE.
2. **Guard:** returns unless the active theme is `gin` or has `gin` among its base themes
   (so it does nothing on a frontend theme, e.g. inside Layout Builder).
3. Ensures an `advanced` `vertical_tabs` group (weight 99, class `entity-meta`).
4. For an `EntityFormInterface` entity it adds to `meta`:
   - `published` (item) when the entity is `EntityPublishedInterface`;
   - `changed` ("Last saved") when `EntityChangedInterface`;
   - `author` when `EntityOwnerInterface` with an `owner` key; moves the `status` checkbox to
     the `footer` group; adds an **Authoring information** details group (`author`) and moves
     `uid`/`created` into it.
   - Moves the `path` alias widget into the `advanced` group (unless the field is required).
5. Wraps `meta` in a details group under `advanced` (weight -10, title "Status").

## Inspecting behaviour on a live site

Because there is no config, "is X covered?" is answered by invoking the service:

```php
$routes = [];
\Drupal::service(\Drupal\gin_everywhere\Hook\GinEverywhereHooks::class)
  ->ginContentFormRoutesAlter($routes);
// e.g. in_array('entity.media.canonical', $routes) or 'entity.taxonomy_term.edit_form'
```

The visual `form_alter` effects only appear when the current admin theme is Gin.
