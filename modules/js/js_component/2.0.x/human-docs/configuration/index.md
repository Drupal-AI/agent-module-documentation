# Configuration

JS Component has no admin settings page. "Configuring" it means writing a component
definition in YAML, then placing and configuring the block it produces. This page
walks through both.

## 1. Define a component in YAML

Create a file named `MY_MODULE.js_component.yml` (or `MY_THEME.js_component.yml`)
in the root of a module or an enabled theme. Each top‑level key is a component id;
the full component identifier becomes `<provider>.<id>` and its block plugin id
becomes `js_component:<id>`.

```yaml
my_widget:
  label: 'My widget'
  root_id: root                 # DOM id the JS mounts on (default: root)
  libraries:                    # same syntax as a *.libraries.yml file
    js:
      build/static/js/main.js: {}
    css:
      theme:
        build/static/css/main.css: {}
  settings_scope: dom           # 'dom' or 'attribute' (see below)
  settings_allow_token: false   # run entered settings through Token replacement
  settings:                     # optional site-builder settings form (Form API)
    heading:
      '#type': textfield
      '#title': 'Heading'
```

Key options:

- **`label`** — the human name shown for the component's block.
- **`root_id`** — the DOM id your JS mounts onto (defaults to `root`). When the
  same block is placed more than once on a page, each instance still gets a unique
  mount id automatically.
- **`libraries`** — the JS/CSS to attach, using the same structure as a
  `*.libraries.yml` file. This is where you point at your built bundle (for example
  `build/static/js/main.*.js`); you can also load an external/CDN script with the
  library `type: external` flag.
- **`settings`** — an optional Form API settings form presented to the site
  builder on each block instance.
- **`settings_scope`** — how those settings reach the browser: `dom` (the default)
  passes them via `drupalSettings.jsComponent[<id>][<root_id>].settings`, while
  `attribute` writes them as `data-*` attributes on the mount `<div>`.
- **`settings_allow_token`** — when `true`, entered setting values are run through
  Token replacement (for example `[node:title]`) before render.
- **`template`** *(optional)* — a Twig template file to render instead of an empty
  mount `<div>`; the component's library is attached automatically.
- **`handlers`** *(optional)* — PHP classes for advanced behavior: a
  `component_form` class to replace the auto‑built settings form (for AJAX or
  validation), and a `data_provider` class whose `fetch()` supplies
  server‑computed data to the component.

After adding or editing a definition, clear caches so it is discovered:

```bash
drush cache:rebuild
```

## 2. Place the component's block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, and find your component by its
   **label**.
3. On the block configuration form, fill in any settings you declared under
   `settings`, adjust the standard block visibility conditions, and save.

The block renders your component in that region — mounting on the configured
`root_id` (or rendering your Twig template) and attaching the library.

## 3. Supply data to the component

Beyond the site‑builder settings, you can feed a component server‑side data in two
ways:

- Implement a **`data_provider`** handler class (referenced in the YAML) whose
  `fetch()` method returns the data.
- Subscribe to the **`js_component.build_component_data`** event to inject or alter
  the data at build time.

The data is delivered alongside the settings (through `drupalSettings` or `data-*`
attributes, per `settings_scope`).

## Hooks for extending other people's components

The module invites several alter hooks so one module can adjust another's
components: `hook_js_component_info_alter()` (discovered definitions),
`hook_js_component_form_alter()` / `hook_js_component_FORMID_form_alter()` (the
settings form), and `hook_js_component_form_submit()` (settings submission).
