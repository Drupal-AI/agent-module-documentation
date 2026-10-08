<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the re-skin works

No plugin, no theme negotiator, no theme switch. It is hooks + theme suggestions + a CSS class
prefix. Everything is gated by `gin_lb.context_validator`.

## The two gates

```php
ContextValidator::isValidTheme()          // FALSE if active theme IS gin or has gin as a base
ContextValidator::isLayoutBuilderRoute()  // route name matches /^(layout_builder\.([^.]+\.)?)/
                                          // then hook_gin_lb_is_layout_builder_route_alter()
ContextValidator::isLayoutBuilderFormId($form_id, $form)
```

**Counter-intuitive:** `isValidTheme()` returns **FALSE** when Gin is active. The module only
works when the active theme is *not* Gin — because if Gin is already the active theme, Layout
Builder is styled anyway. So on a site whose front-end theme is Gin, gin_lb is a no-op.

`isLayoutBuilderFormId()` matches an explicit list —
`editor_image_dialog`, `form-autocomplete`, `layout_builder_add_block`,
`layout_builder_block_move`, `layout_builder_configure_section`, `layout_builder_remove_block`,
`layout_builder_update_block`, `section_library_add_section_to_library`,
`section_library_add_template_to_library` — plus regexes for
`media_library_add_form_*`, `media_*_edit_form`, `layout_builder_translate_form*`,
`layout_builder_block_translation*`, `views_form_media_library_widget_*`,
`ai_ckeditor_dialog_form*`, the `views_exposed_form` whose `#id` is
`views-exposed-form-media-library-widget`, and any form id containing `layout_builder_form`.

## `#gin_lb_form` — the marker

`gin_lb_form_alter()` sets `$form['#gin_lb_form'] = TRUE` and adds the class `glb-form` on
matched forms, then an `#after_build` callback
(`FormAlter::afterBuildAttachGinLbForm` → `GinLayoutBuilderUtility::attachGinLbForm()`)
**recursively** copies `#gin_lb_form = TRUE` onto every child element. Layout Builder attaches
its settings forms late, which is why this has to happen in `#after_build`.

That marker is what `ThemeSuggestionsAlter` looks for.

## `__gin_lb` theme suggestions

`gin_lb_theme_suggestions_alter()` fires for any element carrying `#gin_lb_form`, or on the
route/hook allowlists (`layout_builder.choose_block`, `media_library.ui`, `editor.*_dialog`,
`view.media_library.widget`, … / hooks `media`, `pager`, `status_messages`, `views_view`, …).
For each existing suggestion it appends a `__gin_lb` twin and adds `<hook>__gin_lb`:

```
form_element  →  form_element, form_element__gin_lb, form_element__<orig>__gin_lb
```

`gin_lb_theme()` registers ~35 such hooks, each mapping `<hook>__gin_lb` to a bundled
`templates/<path>--gin-lb.html.twig` with a `base hook`. Covered: form/form-element/input/
select/textarea/checkboxes/radios/details/fieldset/container/table/item-list/links/pager/
status-messages/toolbar, the file + image widgets, and the whole `media_library` set. Extras:
`form__layout_builder_form__gin_lb` and `gin_lb_form_actions` (variables `preview_region`,
`preview_content`; template `top_bar/gin-lb-form-actions`).

Special cases: a checkbox `input` also gets `input__checkbox__toggle`; `toolbar` gets
`toolbar__gin_lb` on any Layout Builder route; `views_view_unformatted` additionally gets
`views_view_unformatted__<view id>__gin_lb`.

To override a template, copy the module's `templates/.../*--gin-lb.html.twig` into your theme —
normal Twig override rules apply.

## The `glb-` prefix and `glb_classes()`

All bundled CSS is prefixed `glb-` so it cannot collide with the front-end theme. The Twig
function **`glb_classes(attributes)`** (service `gin_lb.twig`, class `GinLbExtension`) rewrites
an `Attribute` object's classes: for each class, if `glb-<class>` exists in the module's
generated `src/classes.json`, it is replaced by `glb-<class>`; otherwise it is left alone.
`form-autocomplete` is special-cased to keep **both** names because JS targets it.

```twig
{{ attributes|default(create_attribute()) }}          {# unprefixed #}
<div{{ glb_classes(attributes) }}>                    {# prefixed where a style exists #}
```

## CSS/JS attached

`hook_page_attachments()` runs only on a Layout Builder route and attaches
`gin_lb/gin_lb_init`, `gin_lb/offcanvas`, `gin_lb/preview`, `gin_lb/toolbar`,
`gin/gin_ckeditor`, `claro/claro.jquery.ui`, `gin_lb/gin_lb`, `claro/global-styling`,
`gin_lb/gin_lb_10` (Drupal ≥ 10), `gin_lb/olivero` when the active theme name contains
`olivero`, and `gin_lb/gin_lb_toastify` unless `toastify_loading` is `custom`.

`hook_css_alter()` removes core's off-canvas CSS (both the D9 `core/misc/dialog/off-canvas.*`
and the D10 `core/misc/dialog/off-canvas/css/*` sets), jQuery UI base theme CSS, and most
`core/themes/claro/css/components/*` — keeping only `fieldset.css`, `entity-meta.css` and
`jquery.ui/theme.css` — plus Claro's `base/elements.css` and `base/typography.css`.

## Form structure tweaks

On `layout_builder_add_block`, `layout_builder_configure_section`,
`layout_builder_remove_section`, `layout_builder_remove_block`, `layout_builder_update_block`
the form gets class `canvas-form`; `settings` / `layout_settings` / `description` become
containers with `canvas-form__settings`, and `actions` gets `canvas-form__actions`. Layout
Builder Lock and UI Styles elements are folded into `canvas-form__actions` too. On any
`*layout_builder_form*`, `advanced` becomes a plain container and the submit button gains
`js-glb-button--primary` so JS can target only it.
