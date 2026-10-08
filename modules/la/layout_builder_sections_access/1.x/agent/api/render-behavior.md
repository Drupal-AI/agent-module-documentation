<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Render behavior, hooks, cache & UI (API)

The module has no services, routes, controllers, or plugins. All behavior is hook-based in
`layout_builder_sections_access.module`.

## Hooks implemented

| Hook | Function | Purpose |
|---|---|---|
| `hook_help` | `layout_builder_sections_access_help` | Help text on `help.page.layout_builder_sections_access`. |
| `hook_form_FORM_ID_alter` (`layout_builder_configure_section`) | `..._form_layout_builder_configure_section_alter` | Adds the `Access` fieldset (`disable_section`, `visibility_roles`) and **prepends** `_layout_builder_sections_access_submit_form` to `$form['#submit']` (`array_unshift`). |
| (submit) | `_layout_builder_sections_access_submit_form` | Writes the fieldset values into the layout plugin configuration. See [../configure/section-access.md](../configure/section-access.md). |
| `hook_preprocess_layout` | `layout_builder_sections_access_preprocess_layout` | The enforcement — removes section content at render time. |
| `hook_install` | `layout_builder_sections_access_install` | `module_set_weight(..., 100)` so it runs late in the hook order (other modules may add to `content`). |

## Enforcement — `hook_preprocess_layout`

`layout_builder_sections_access.module:91`. Reads
`$variables['settings']['layout_builder_sections_access_config']` and branches on
`$variables['in_preview']`:

- **Disabled section** (`disable_section` truthy):
  - `in_preview === FALSE` (frontend): `unset($variables['content'])` — the section's content render
    array is dropped **before** Twig renders the `layout` template, so it never enters the HTML.
  - `in_preview === TRUE` (LB editing UI): sets `data-layout--disable-section` attribute and attaches
    the `layout_builder_sections_access/ui` library (visual cue only; content stays visible to the
    editor).
- **Role restriction** (`visibility_roles` non-empty):
  - `in_preview === TRUE`: sets `data-layout--role-access` attribute + attaches the UI library.
  - `in_preview === FALSE`: iterates the allowed roles; `$access` starts **FALSE** and only becomes
    TRUE on `$user->hasRole($role)` (deny-by-default). Non-string role entries are skipped. If no role
    matched, `unset($variables['content'])`.

`$user` is the layout template's `user` variable (the current account). Content removal is genuine
server-side stripping — the module's functional test `SectionAccessTest::testDisabledSection` /
`testRoleAccessSection` asserts the body text is absent from the response for a non-matching viewer.

### Why `unset()` instead of `#access`

Per the README/inline comments: Layout Builder does not honor `#access` on the section render array
after `hook_preprocess_layout`, and core exposes a render event only for `SectionComponent`, not for a
`Section`. So the module sits at weight `100` (late) and removes the `content` variable directly.

### Cache correctness

For the role branch the module adds granular cache contexts to `$variables['#cache']['contexts']`:
`user.roles:<role>` for each matched role when access is granted, and for each of the user's roles when
denied. Core's `ThemeManager` bubbles `$variables['#cache']` / `$variables['#attached']` set in a
preprocess (it renders a `$preprocess_bubbleable` array), so these contexts propagate to the entity
render cache and Dynamic Page Cache — the section render therefore varies correctly by role and does not
leak the restricted content to a non-matching role from cache. (The disabled branch removes content
unconditionally, so it needs no context.)

## Library & preview markup — `layout_builder_sections_access/ui`

Defined in `layout_builder_sections_access.libraries.yml`; attached only in preview. Deps:
`core/drupal`, `core/jquery`, `core/once`.

- `js/layout_builder_sections_access_ui.js` — `Drupal.behaviors.layout_builder_sections_access`. For
  each `.layout-builder__section`, if a child `.layout-builder__layout` carries
  `data-layout--role-access` or `data-layout--disable-section`, it appends `(Role Access)` / `(Disabled)`
  to the section's `a.layout-builder__link--configure` text and adds the class
  `layout-builder__section__disabled`.
- `css/layout_builder_sections_access.css` — `.layout-builder__section__disabled > div { opacity: 0.25; }`.

These are editor-UI affordances inside Layout Builder only; they play no part in frontend enforcement.
