<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Animate On Scroll (lb_aos) — agent index

Adds a per-block **AOS** (Animate On Scroll) setting to Layout Builder so a site builder can make an
individual block fade/slide/zoom into view as the visitor scrolls, without writing JavaScript. The
whole module is a `.module`, a services file, and one event subscriber. Two moving parts: (1)
`lb_aos_form_alter()` adds an "Animations" details group with a single `animation_type` select to
Layout Builder's *add block* and *update block* forms, and a prepended submit handler
`_lb_aos_submit_block_form()` writes the chosen value onto the `SectionComponent` via
`$component->set('animation_type', …)` — so the choice is stored in the layout's **component
configuration** and travels with a config export (default layouts) or with the entity (per-entity
overrides). (2) At render time `BlockComponentRenderArraySubscriber` listens to Layout Builder's
`SECTION_COMPONENT_BUILD_RENDER_ARRAY` event (weight `50`, i.e. after core builds the base array),
reads `animation_type` back off the component, and adds `data-aos="<type>"` to the block wrapper plus
attaches the `aos/aos` library. The animation library itself is not shipped here — it comes from the
`aos` module dependency.

There is **no settings page, no route, no permission, no config schema, no plugin type, and no drush**.
Editing block animations reuses core Layout Builder's own access (a user who can edit the layout can
set the animation).

- Depends on: `aos:aos`, `drupal:layout_builder` (info.yml).
- Core: `^10 || ^11`.
- Package: none declared in info.yml (`package` is null).
- Composer: project is `drupal/lb_aos`, requiring **`drupal/aos-aos:^1.0`** — note the `aos-aos`
  package name (not `drupal/aos`); that is how drupal.org packages this project. Expect it in
  composer output and lockfiles.
- Settings page / configure route: none. Permissions: none (relies on core `layout_builder`).
- Drush: none. Plugin types: none. Config schema: none.
- Services: one event subscriber. Hooks: `hook_form_alter`.

## What you'd do → where
- Change/extend the animation list, or how the setting is captured and stored on a block →
  `agent/forms/block-form.md`
- Understand how `data-aos` and the `aos/aos` library land on the rendered block (event, weight,
  cache tag) → `agent/events/render-array.md`

## Key facts (real machine names)
- Service: `lb_aos.render_block_component_subscriber` →
  `Drupal\lb_aos\EventSubscriber\BlockComponentRenderArraySubscriber` (args `@entity_type.manager`,
  `@config.factory` — neither is actually used in the current code).
- Event: `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY`
  (`'section_component.build.render_array'`), handler `onBuildRender()`, priority `50`.
- Hook: `lb_aos_form_alter()` targets form ids `layout_builder_add_block` and
  `layout_builder_update_block` (`lb_aos.module`).
- Submit handler: `_lb_aos_submit_block_form()`, prepended with
  `array_unshift($form['#submit'], …)` so it runs before Layout Builder's own handler.
- Component config key: `animation_type` (get/set on the `SectionComponent`).
- Form structure: `$form['animations']` (`#type` details) → `animation_type` (`#type` select);
  22 AOS options plus `''` = None (fade-*, flip-*, zoom-in-*, zoom-out-*).
- Render additions (in `onBuildRender()`): `#animation_type`, `#attributes['data-aos']`,
  `#attached['library'][] = 'aos/aos'`, and `#cache['tags'][] = 'config:lb_aos.animation_type.' .
  $animation_type` (a cache tag string; no such config object actually exists).
- Library: `aos/aos` — defined by the `aos` module, not by lb_aos.
