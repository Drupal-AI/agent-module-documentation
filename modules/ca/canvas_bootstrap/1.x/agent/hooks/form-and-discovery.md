<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Bootstrap — form grouping + theme-aware discovery

All PHP lives in `src/Hook/CanvasBootstrapFormHooks.php` and
`src/ComponentSource/ThemeAwareSingleDirectoryComponentDiscovery.php`. Both are wired with OOP
`#[Hook]` attributes and constructor autowiring — there is no `canvas_bootstrap.services.yml`.

## Hook: `form_component_instance_form_alter`

`CanvasBootstrapFormHooks::formComponentInstanceFormAlter()` runs on Canvas's
`component_instance_form` (the per-component settings form in the editor). It:

1. Attaches the CSS library `canvas_bootstrap/component_instance_form`.
2. Reads `$form['form_canvas_tree']['#value']` (JSON), takes `tree['type']`, strips the `@version`
   suffix to get the component config id (e.g. `sdc.canvas_bootstrap.button`).
3. Loads that component's `canvas_bootstrap.ui_groups` metadata and, if present, reorganises the prop
   fields under `$form['canvas_component_props'][<instance_key>]` via `applyUiGroups()`.

If the component has no `ui_groups`, or no fields actually move, the form is left unchanged (the
`canvas_bootstrap_groups` container is removed when nothing moved).

### `canvas_bootstrap.ui_groups` metadata format

Placed at the top level of a `*.component.yml` (sibling of `props:` / `slots:`), under the module
namespace key `canvas_bootstrap`. It builds a `#type => 'vertical_tabs'` container
(`canvas_bootstrap_groups`, `#weight` 35). Two shapes are supported per top-level group:

- **Flat group** — a `fields:` list (or the group *is* a bare list of field names) → one
  `#type => details` tab holding those prop fields directly.
- **Nested group** — a `groups:` map (or a mapping with no `fields:` key) → one `details` tab, and
  each subgroup becomes a `#type => fieldset` inside it holding its `fields:` (a subgroup may also be
  a bare list). Optional `weight:` on any group/subgroup sets element weight.

Example (from `wrapper.component.yml`):

```yaml
canvas_bootstrap:
  ui_groups:
    Spacing:
      weight: 10
      groups:
        Margin: { weight: 0, fields: [margin_for_all, margin_top, margin_bottom, ...] }
        Padding: { weight: 10, fields: [padding_all, padding_top, ...] }
    Flex:
      weight: 20
      fields: [flex_enabled, flex_direction, flex_gap, flex_width, justify_content, align_items]
```

Container keys are derived as `canvas_bootstrap_group_<slug(label)>`. Only prop fields that already
exist in the form (`isset($props[$field])`) are moved; unknown names are ignored.

Metadata is located by `resolveComponentMetadataPath($provider, $component_name)`: it looks up the
provider as a **theme first**, then a **module**, and reads
`<base>/components/<component_name>/<component_name>.component.yml`. NOTE: this assumes the component
directory name equals the machine name — true for 14 of the 16 components, but **not** for `alert`
(machine name `canvas_bootstrap_alert`, dir `alert/`) and `badge` (machine name
`canvas_bootstrap_badge`, dir `badge/`), so their `ui_groups` grouping does not resolve and is
silently skipped. Bear this mismatch in mind when adding `ui_groups` to your own components: name the
directory identically to the `*.component.yml` basename.

## Hook: `canvas_component_source_alter` — theme-aware discovery

`CanvasBootstrapFormHooks::canvasComponentSourceAlter()` sets
`$definitions['sdc']['discovery'] = ThemeAwareSingleDirectoryComponentDiscovery::class`, replacing
Canvas's default SDC discovery for the `sdc` component source.

`ThemeAwareSingleDirectoryComponentDiscovery` (implements Canvas's
`ComponentCandidatesDiscoveryInterface`) wraps core `SingleDirectoryComponentDiscovery` and delegates
everything except `checkRequirements()`. In `checkRequirements()`, if the component is a **module**
SDC whose machine name is also provided by an **active-theme** SDC, it throws
`ComponentDoesNotMeetRequirementsException` — hiding the module component so the theme's version wins.

`getPreferredThemeComponents()` builds the lookup once: it groups all discovered SDCs by
`machineName`, keeps only candidates whose `provider` is the active theme or one of its base themes,
sorts them by theme inheritance order (active theme before base themes), and records the winning
plugin id per machine name. Net effect: a Bootstrap theme can override any `canvas_bootstrap:*`
component simply by shipping an SDC with the same machine name — no config, no code.
