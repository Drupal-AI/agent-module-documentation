# UI Examples — defining example plugins

Examples are **YAML plugins**, not PHP classes. Any enabled module or theme can ship them.

## Discovery locations (in `ExamplePluginManager::getDiscovery`)
- `<extension>/ui_examples/<anything>.ui_examples.yml` (one file per example dir), OR
- `<extension>/<extension>.ui_examples.yml` (root file).
- Searched across all module AND theme directories. Translatable: `label`, `description`, `category` (with `*_context`).

## Example YAML shape
```yaml
id: 'my_card'                 # required (PluginException if missing)
enabled: true                 # disabled examples are dropped in alterDefinitions()
label: 'Card'
description: 'A demo card.'
category: 'Components'         # default 'Other'; used for grouping/sorting
weight: 0
links:                        # optional; string or {url, title}
  - 'https://example.com/docs'
render:                       # the render array to display
  - type: html_tag
    tag: h2
    value: 'Hello'
```

## The `#`-optional syntax (`ExampleSyntaxConverter`)
Render arrays may omit the `#` on properties for readability; the converter restores them before rendering (`ui_examples.single` calls `convertArray()`):
- `type` → `#type`, `theme` → `#theme`, and by default every scalar-key property gets `#`.
- Known-property lists exist for `item_list`, `html_tag`, `layout`.
- "Children-in-properties" cases are handled specially: component `slots`, `status_messages` `message_list`, `item_list` `items`, `table` `header/rows/footer/empty/caption`.
- An array is treated as a render array only if it has exactly one of: `markup`, `plain_text`, `item_list`, `theme`, `type` (or their `#` forms) with a string value.

## Definition object & manager API
- `ExampleDefinition` (`src/Definition/`) wraps the array; getters/setters for label, description, category, render, weight, links, provider; `toArray()` adds `render_links`.
- `ExamplePluginManagerInterface`: `getDefinitions()`, `getDefinition($id)`, `getSortedDefinitions()`, `getGroupedDefinitions()`, `getCategories()`. Cache tag `ui_examples`.
- Alter: `hook_ui_examples_examples(&$definitions)` (each is an `ExampleDefinition`) — modify or unset examples from another extension.

## Rendering & access
- Controller `ExamplesLibraryController`: `overview()` (grouped by category, theme `ui_examples_overview_page`), `single($name)` (converts and returns the example's render array), `title($name)`.
- All example routes require `access_ui_examples_library`. This permission is **not** `restrict access: true`, and `ui_examples_update_8101` grants it to every role; the pages only expose developer-authored demo render arrays (no user data), so this is by design for a design-system viewer.

## Provider
`providerExists()` accepts both modules and themes, so a theme can be the provider of an example.
