<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Context (layout_builder_context) — agent index

Adds a **Context visibility** control to Layout Builder **sections** and **block components**. The
selected contrib-**Context** entities are evaluated at render time; if they fail, the section or
block is not shown. Version **1.0.2** (dir `1.0.x`). Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. No PHP constraint declared.

Depends on core **`layout_builder`** and contrib **`context`** (`drupal/context:^5.0`).

- **The service, subscriber and preprocess hook that hide content, and the exact evaluation
  semantics** → [api/visibility-service.md](api/visibility-service.md)
- **How the two settings get onto the Layout Builder forms and where they are stored** →
  [config/layout-integration.md](config/layout-integration.md)

## What it actually is

- **No routes, no permissions, no config entity, no config page, no plugin types, no Drush.** It
  ships no `config/install` or `config/schema` of its own (the only config under the project is in
  `tests/`). Its own code is two PHP classes plus one `.module` file.
- Two settings ride on existing Layout Builder structures:
  - `context_visibility` — an array of Context entity IDs.
  - `context_all_must_pass` — bool (default TRUE); AND vs. any-fail-tolerated logic.
  They are set on the **component** (`SectionComponent::set()`) for blocks, and merged into the
  **layout configuration** array for sections.
- **Visibility only.** Context **Reactions** do nothing through this module — only the enabled
  Context's *conditions* are evaluated. A disabled Context is treated as passing.

## Provided code (from source)

- Service `layout_builder_context.visibility` → `Drupal\layout_builder_context\Utility\Visibility`
  (arg `@context.manager`). Method `evaluate(array $build, array $contexts, bool $all_must_pass)`.
- Event subscriber `layout_builder_context.render_block_component_subscriber` →
  `EventSubscriber\BlockComponentRenderArraySubscriber`, listening on
  `LayoutBuilderEvents::SECTION_COMPONENT_BUILD_RENDER_ARRAY` (priority 50) — handles **blocks**.
- `.module`: `hook_form_alter()` injects the fieldset on `layout_builder_add_block`,
  `layout_builder_update_block`, `layout_builder_configure_section`;
  `hook_preprocess_layout()` applies visibility to whole **sections**;
  `layout_builder_context_option_list()` lists enabled Contexts.

## Operate it

Enable `layout_builder_context` (pulls in `context`). Build conditions at **Admin > Structure >
Context** (`/admin/structure/context`). In a Layout Builder layout, open a block or section's
config form and pick Contexts under **Context visibility**. Neither preview affects nor Reactions
apply — see the solution docs for the precise render behavior.
