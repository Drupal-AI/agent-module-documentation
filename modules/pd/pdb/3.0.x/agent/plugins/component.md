# Author a PDB component

A component is **not** a PHP plugin class — it is a directory with an info file whose `type` is
`pdb`. PDB discovers it and `PdbBlockDeriver` turns it into a block plugin (id
`pdb_<presentation>:<machine_name>`-style derivative) that shows up in Block layout / Layout Builder.
You need an enabled presentation module (e.g. `pdb_react`, `pdb_vue`, `pdb_ember`, `pdb_default`)
that provides both the concrete `PdbBlock` subclass and a `pdb_<presentation>/<presentation>`
runtime library.

## Minimal component

```
my_components/hello/
├── hello.info.yml
└── hello.js
```

```yaml
# hello.info.yml
name: 'Hello component'
type: pdb                 # REQUIRED — marks this as a PDB component, not a module/theme
machine_name: hello       # library/asset key; also the drupalSettings namespace
presentation: react       # which framework runtime library to depend on (pdb_react/react)
category: 'My components'  # optional block category (defaults to the provider)
add_js:
  footer:
    hello.js: {}
add_css:
  header:
    hello.css: {}
```

## Info-file keys PDB reads

| Key | Effect |
|---|---|
| `type: pdb` | Required. Makes the directory a discoverable component. |
| `machine_name` | Asset-library name (`<machine_name>/header`, `<machine_name>/footer`) and settings namespace. |
| `presentation` | Adds a dependency on library `pdb_<presentation>/<presentation>` (the framework runtime). |
| `add_js` / `add_css` | `header:`/`footer:` groups of asset files → built into libraries by `pdb_library_info_build()`. Entries with `type: external` are kept as absolute URLs; others resolve to `/<component path>/<file>`. |
| `settings` | Static values attached verbatim as `drupalSettings` when the block renders (`attachSettings`). |
| `contexts` | Map of `<name>: <context type>` (e.g. `entity: 'entity:node'`) → block context definitions. Legacy `entity: node` is rewritten to `entity:node`. |
| `configuration` | Form-API element definitions used to build the per-block settings form (see below). |
| `status` | `disabled` excludes the component from block derivation (`PdbBlockDeriver` skips it). |
| `category` | Block admin category (else the provider name). |

## Assets (header vs footer)

`_pdb_library_build_css()` / `_pdb_library_build_js()` split `add_css`/`add_js` into a
`<machine_name>/header` and `<machine_name>/footer` library; each automatically gets
`dependencies: [pdb_<presentation>/<presentation>]`. `PdbBlock::attachLibraries()` attaches whichever
of header/footer the component declares.

## Per-instance configuration form

If the info file has a `configuration` map, `PdbBlock::buildComponentSettingsForm()` builds a
`details` element named `pdb_configuration` on the block form. Each entry becomes a Form-API element
by prefixing every property with `#`:

```yaml
configuration:
  greeting:
    type: textfield        # -> #type: textfield
    title: 'Greeting'      # -> #title
    default_value: 'Hi'
```

Caveat (from source `@todo`): there is **no whitelist/blacklist of Form-API properties** — every key
under a configuration entry is passed straight through as a `#`-prefixed render property. Component
authors are trusted code authors (files on disk), so treat component info files like module code.

Submitted values are stored on the block as `configuration['pdb_configuration']` (schema
`block.settings.pdb`, a free-form `sequence` of `ignore`) and emitted at render time as
`drupalSettings.pdb.configuration[<block uuid>]`. Text-format elements are unwrapped to their
`value` for the stored default.

## Contexts → drupalSettings

When a component declares `contexts`, `PdbBlock::build()` reads each context value. For entity
contexts it **clones** the entity and checks `view` access on the entity and then on every field,
nulling any field the current user cannot view, before serializing it into
`drupalSettings.pdb.contexts`. This is the module's guard against leaking unviewable field data to
the browser.

## What the block build attaches

`PdbBlock::build()` returns only `#attached` (the framework library, component header/footer
libraries, `settings`, page-header additions, `drupalSettings.pdb.contexts`, and
`drupalSettings.pdb.configuration[uuid]`) plus a generated `uuid` — the visible DOM/markup is the
presentation module's / component's responsibility. Derived blocks are rendered with `max-age: 0`
(uncacheable) by the deriver.
