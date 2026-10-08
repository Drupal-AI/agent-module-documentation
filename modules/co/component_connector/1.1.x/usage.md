<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Component connector wires theme-authored front-end components into Drupal's theme registry, libraries, and
Layout API via small YAML descriptors.

---

## Setup

1. Install and enable `component_connector` (no extra dependencies).
2. At `/admin/config/system/component_connector_settings` set **Theme** to the machine name of the theme that
   holds your components (config key `component_connector.settings:theme`; install default `claro`). The module
   only scans that one theme's directory.
3. Author components in that theme, e.g. `templates/components/<name>/<name>.html.twig` plus optional
   `<name>.css` / `<name>.js`, and a descriptor `<name>.theme.yml` or `<name>.suggestion.yml`.
4. `drush cr` after adding or changing a descriptor (they are read at registry build time and file-cached).

A `<name>.css` / `<name>.js` file sitting next to the descriptor is **auto-declared as a library** and attached
to the hook; you do not have to list it under `libraries:` (that section is for extra/shared libraries).

## Descriptor structure

```yaml
component_name:            # unique id
  label: 'Component Label'
  hook theme: 'hook_name'  # the Drupal theme hook to register/extend/replace
  base hook: 'base_hook'   # optional: inherit from an existing hook (or 'layout')
  fields:                  # optional: extra variables / render regions
    field_name:
      label: 'Field Label'
  settings:                # optional: extra settings passed to render
    setting_name: 'value'
  libraries:               # optional: extra CSS/JS libraries
    - library-name:
        css: { component: { 'file.css': {} } }
        js:  { 'file.js': {} }
```

## The four integration types (from the README, with worked examples)

- **Custom theme hook** — `hook theme: 'my_progress_percentage'` only. Registers a new `hook_theme` you then
  render with `'#theme' => 'my_progress_percentage'`, `'#value' => ...` (e.g. from a field formatter).
- **Theme hook "candidate"** — `hook theme: 'input__checkbox'` + `base hook: 'input'`. Extends an existing
  hook using core's candidate mechanism. Do not use `fields`/`settings` here (render-element hooks can't take
  arbitrary variables).
- **Replace existing theme hook** — `hook theme: 'form_element_label'` only. Overrides a core/contrib hook's
  template with your own. Keep the original hook's variables/render element; do not add `fields`/`settings`.
- **Theme hook "suggestion"** (`<name>.suggestion.yml`) — `base hook: 'pager'`. Remaps the base hook to your
  `component.html.twig` AND lets you add extra `fields`/`settings` variables (they are merged into the hook's
  `variables`), avoiding the render-element-vs-variables limitation.

## Layout integration

A `*.theme.yml` descriptor with `base hook: 'layout'` is registered as a **Layout API plugin** (usable in
Layout Builder, panels, entity view modes):

```yaml
h_container:
  label: 'Layout / Container'
  hook theme: 'h_container'
  base hook: 'layout'
  fields:
    content:
      type: render
      label: Content
```

- `fields` become layout **regions** (each field's `label`).
- `settings` become a per-layout config form: field `type` `textfield` → text field, `boolean` → checkbox,
  `select` → select (with `options`).
- The plugin (`ComponentConnectorLayout`) adds a **Field templates** option: `default` (normal field wrappers)
  or `only_content` (strips field `#prefix`/`#suffix`/`#theme` so only field content prints).
- Optional `icon_map` is passed through to the layout definition.

---

- Register a new theme hook from a theme YAML file.
- Extend or replace a core/contrib theme hook from the theme.
- Remap a base hook to a component template with extra variables (suggestion).
- Register a component as a Layout Builder / panels layout.
- Auto-attach a component's colocated CSS/JS as a library.
- Point the module at the theme that holds your components via the settings form.
- Pass custom fields/settings into a component's render array.
- Clear cache so new component descriptors are picked up.
