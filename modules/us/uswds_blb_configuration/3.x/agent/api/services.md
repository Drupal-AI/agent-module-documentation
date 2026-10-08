<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, event subscriber, render elements, hooks & routes

## Services (`uswds_blb_configuration.services.yml`)

- `plugin.manager.uswds_styles` — `Style\StyleManager`. Manager for the `@Style` plugin type.
- `plugin.manager.uswds_styles_group` — `StylesGroup\StylesGroupManager`. Manager for the
  `@StylesGroup` plugin type; also the form-build / form-submit / render-build orchestrator (see
  `agent/plugins/styles.md`). Args include `@plugin.manager.uswds_styles` and `@config.factory`.
- `uswds_layout_builder_blocks.render_block_component_subscriber` —
  `EventSubscriber\BlockComponentRenderArraySubscriber` (tagged `event_subscriber`).

## Event subscriber

`BlockComponentRenderArraySubscriber` listens to
`LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY` at priority **50**
(`onBuildRender`). It reads the component's `uswds_styles.block_style` config and calls
`StylesGroupManager::buildStyles($build, $block_style_configs)` to apply block-level styles to the
render array, then `$event->setBuild($build)`. This is how per-block style choices reach the frontend.

## Render elements (`src/Element/`)

- `uswds_container` (`Container`) — `#theme uswds_container`.
- `uswds_container_wrapper` (`ContainerWrapper`) — `#theme uswds_container_wrapper`.
- `uswds_video_background` (`VideoBackground`) — `#theme uswds_video_background`, with
  `#video_background_url` / `#attributes` / `#children`. The URL is populated from an admin-mapped
  media entity's file, not from request input.

## Theme hooks (`uswds_blb_configuration_theme`, `.module:32`)

`uswds_container_wrapper`, `uswds_container`, `uswds_section` (base hook `layout`, template
`uswds-section`), `uswds_video_background`, `spacing_preview`, `border_preview`, `shadow_preview`,
and the Bootstrap-style form overrides `form_element__bs`, `fieldset__bs`, `input__bs`, `radios__bs`,
`details__bs` (templates under `templates/form/` and `templates/`).

## Hooks implemented (`uswds_blb_configuration.module`)

- `hook_help`, `hook_theme`.
- `hook_preprocess_html` — adds `layout-builder-form` / `user-logged-in` body classes on LB routes.
- `hook_preprocess_uswds_section` — flattens region `#attributes` and builds `region_attributes`.
- `hook_page_attachments_alter` — attaches `layout_builder_form_style`, `offcanvas-font`, and the
  `theme.light`/`theme.dark` library on `layout_builder.{defaults,overrides,layout_library}.*.view`
  routes.
- `hook_theme_suggestions_alter` — adds `__bs` suggestions inside the USWDS style UI.
- `hook_library_info_alter` — swaps the remote AOS scroll-effects library for a local copy when
  `/libraries/aos/dist/aos.js` exists.
- `hook_form_alter` — on `layout_builder_add_block` / `layout_builder_update_block`, injects the
  Content/Style tab UI and the block style groups (respecting `block_styles.block_restrictions`), and
  prepends submit handler `_uswds_blb_configuration_submit_block_form`, which persists the chosen
  styles onto the component's `uswds_styles` key.

Plugin-definition alter hook: both managers call `alterInfo('uswds_blb_configuration_info')`.

## Routes

Admin/style routes and the config-entity routes are covered in `agent/configure/`. Two extra
controller routes exist:

- `uswds_blb_configuration.ajax_temp_store_set` — `POST /uswds_blb_configuration/ajax/temp_store/set`
  → `Controller\TempStoreController::set` — writes `key`/`value` (from the POST body) into the
  caller's **private** tempstore (collection `uswds_blb_configuration`).
- `uswds_blb_configuration.ajax_temp_store_get` — `POST /uswds_blb_configuration/ajax/temp_store/get`
  → `Controller\TempStoreController::get` — returns the caller's own private tempstore value for
  `key` as JSON.

The layout live-preview reads `active_device` from this private tempstore
(`UswdsLayout::livePreviewCallback`) and returns an `Ajax\RefreshResponsive` command
(`command: uswds_refresh_responsive`).

## AJAX command

`Ajax\RefreshResponsive` — a `CommandInterface` emitting `{command: 'uswds_refresh_responsive',
selector, method, data}`, handled client-side by `js/components/responsive.js`.

No Drush commands. No custom permissions beyond `configure uswds layout builder`.
