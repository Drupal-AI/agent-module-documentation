# Glossary, sections & component assignment

The `/ui-kit` sidebar is driven entirely by the `glossary` key inside `bootstrap_ui_kit.settings`.
It is a two-level tree: **groups** (sidebar headings) → **sections** (tabs/anchors) → optional
**components** (SDC previews rendered inside a section). Three admin forms edit it, all gated by
`administer site configuration`.

## The three editing forms

| Route | Path | Form | Purpose |
|---|---|---|---|
| `bootstrap_ui_kit.glossary` | `/admin/appearance/bootstrap_ui_kit/glossary` | `BootstrapUiKitGlossaryForm` (`bootstrap_ui_kit_glossary_form`) | Add / remove / rename / reorder groups and sections via a tabledrag table. |
| `bootstrap_ui_kit.sections` | `/admin/appearance/bootstrap_ui_kit/sections` | `SectionsListForm` (`bootstrap_ui_kit_sections_list_form`) | Read-only listing of every section with a component count and a *Manage* link. |
| `bootstrap_ui_kit.component` | `/admin/appearance/bootstrap_ui_kit/glossary/{section}` | `GlossarySectionComponentForm` (`bootstrap_ui_kit_section_component_form`) | Assign SDC components (with props/variant/story) to one section. |

These are wired as local tasks in `bootstrap_ui_kit.links.task.yml`
(`settings_tab`/`glossary_tab`/`sections_tab`, base route `bootstrap_ui_kit.settings`).

## `glossary` config structure

Schema types `bootstrap_ui_kit.glossary_group` and `bootstrap_ui_kit.glossary_section`:

```yaml
glossary:
  foundations:                 # group machine key
    title: Foundations
    weight: -10
    sections:
      color:                   # section machine key
        title: Color
        description: "<p>…HTML shown above the section…</p>"
        weight: -9
        modal: false           # boolean, optional
        components:            # list of assigned SDC components (see below)
          - id: 'my_theme:card'
            weight: 0
            show_label: true
            props: { title: 'Example', variant: 'primary', _story: 'card.default.story.yml' }
            slots: { body: [ { type: html_tag, tag: p, value: 'Hi' } ] }
```

Machine keys for new groups/sections are generated from the entered label by
`generateMachineName()` (`[a-z0-9]+` → `_`, deduplicated). `BootstrapUiKitGlossaryForm::submitForm`
reconstructs the tree from the tabledrag rows (`reconstructFromTableValues`), preserving existing
section `description`s that the glossary form does not expose. Section removal / group removal write
config immediately in their AJAX submit handlers (`removeItemSubmit`, `removeGroupDirectly`).

## Component entry fields (`glossary…sections…components[]`)

| Key | Meaning |
|---|---|
| `id` | Full SDC component id `provider:machine` (validated against regex `COMPONENT_ID_PATTERN` in `GlossarySectionComponentForm::validateForm`). |
| `weight` | Render order within the section. |
| `show_label` | Show the component title + story badge above the preview. |
| `props` | Props array passed to the `#type => component` render. `variant` selects an SDC variant; `_story` (a story-file **basename**) links a discovered story. |
| `slots` | Transformed slot definitions (see [../plugins/slot-types.md](../plugins/slot-types.md)). |

## GlossarySectionComponentForm mechanics

- Injected services: `config.factory`, `messenger`,
  `bootstrap_ui_kit.content_injection_manager`, `bootstrap_ui_kit.component_definition_repository`,
  `bootstrap_ui_kit.story_discovery`.
- The component picker element is **`#type => cl_component_selector`** — this render element is
  **not** provided by this module; it comes from the *Component Libraries: Editorial* (`cl_editorial`)
  ecosystem. The component-assignment UI therefore needs that element available (undeclared soft dep).
- Props for a chosen component are built by merging (last wins):
  `default (buildDynamicExampleProps from the SDC props schema) < variant props < story props < custom JSON`
  (`buildMergedProps`). `buildDynamicExampleProps` fabricates sample values from the SDC
  `props.properties` schema (via `ComponentDefinitionRepository::getPropsSchema`).
- Stories are discovered with `StoryDiscovery::discover($id)`; picking one stores only the story
  **basename** in `props._story`. Legacy full-path `_story` values are normalised to basename on load
  and save.
- `submitForm` writes the section's `description` and rebuilt `components` array back into
  `glossary` and saves `bootstrap_ui_kit.settings`.

## Rendering path (runtime)

`bootstrap_ui_kit_preprocess_page__ui_kit()` walks `glossary`, and for each component:
validates `id` against the live SDC definitions (`plugin.manager.sdc`), hydrates a linked story via
`_bootstrap_ui_kit_hydrate_story()` (merges story props/slots/`library_wrapper`), normalises
attributes with `_bootstrap_ui_kit_normalize_component()`, then builds the final render with
`ContentInjectionManager::buildRenderable()` into `component['_render']`. See
[../api/services.md](../api/services.md).

## Local-task deriver caveat

`Plugin/Derivative/GlossarySectionComponentsDeriver` builds one local task per section, but declares
`base_route => bootstrap_ui_kit.glossary_components` (in `links.task.yml` too), and
`buildSafeComponentUrl()` falls back to route `bootstrap_ui_kit.section_component`. **Neither route
exists** in `bootstrap_ui_kit.routing.yml`, so those derived section tabs / the legacy fallback are
effectively dead references; the working entry point is the `bootstrap_ui_kit.component` route above.
