# views_jump_menu — agent start

Adds one Views **style/format** plugin (id `jump_menu`, class `JumpMenu` extends `StylePluginBase`,
theme `views_jump_menu`) that renders all view rows as a single `<select>` dropdown; picking an
option navigates to that row's URL. Requires the **Fields** row style (`usesFields = TRUE`). You
choose a **Label field** and a **URL field** from the view's fields. Depends only on core `views`.
No admin settings form, no `configure` route, no permissions, no services, no Drush — all config
lives in the view. Config schema: `views.style.jump_menu`. JS library: `views_jump_menu/views-jump-menu`.

- Add the Jump Menu format + all its style options → [configure/views_jump_menu.md](configure/views_jump_menu.md)
- Render pipeline, URL resolution, JS behavior, template override → [api/views_jump_menu.md](api/views_jump_menu.md)
