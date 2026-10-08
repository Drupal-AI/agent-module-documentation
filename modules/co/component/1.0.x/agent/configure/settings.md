# Admin form & `component.admin` config

Route **`component.admin_form`** → `admin/config/development/component` (menu link under
*Configuration › Development*). Form `Drupal\component\Form\ComponentAdminForm` (form id
`component_admin_form`). Access: `_permission: 'access administration pages'`, `_admin_route: TRUE`.
There is no module-specific permission.

## What the form shows (`ComponentAdminForm::buildForm()`)

Built from `component.discovery`'s `getComponents()`:

1. **Plugins** — a `#type: table` (one row per `type: plugin` component, grouped by its `parent`
   machine name) with a `select` of the plugins that target that parent. Only this section is
   editable; it has the `Save configuration` submit button. If there are no `plugin` components it
   shows *"There are no plugin type components found in the system."*
2. **Libraries** — a read-only table of every `type: library` component (name, `component/<name>`,
   description, dependencies).
3. **Blocks** — a read-only table of every `type: block` component.

## Config object — `component.admin`

`getEditableConfigNames()` = `['component.admin']`. On submit
(`ComponentAdminForm::submitForm()`) each plugin row is saved as
`component.admin.<parent> = <selected plugin machine name>`. This map is consumed in two places:

- `component_library_info_build()` replaces the `<parent>` component's library dependencies with
  `component/<selected>` (`component.module:63-68`) — i.e. it swaps which implementation the parent
  loads.
- `component_page_attachments()` publishes the whole map to `drupalSettings.component.plugins`.

> **No config schema.** The module ships no `config/schema/*.yml`, so `component.admin` has no schema
> definition. Saving works, but the object is schema-less (this is reflected in
> `data.json: provides_config_schema = false`). There is likewise no `config/install/` default — the
> object only exists once the form is saved.

## Notes for agents

- Nothing on this form renders untrusted input; it reads discovery output (from on-disk files) and
  writes machine-name→machine-name selections. Component *rendering* happens through the block plugin,
  not this form — see [../plugins/block.md](../plugins/block.md).
- To change a component's assets, cache, or settings, edit its `*.component.yml`
  ([../api/component-yml.md](../api/component-yml.md)) and rebuild caches; this form does not edit
  component definitions.
