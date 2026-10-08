# Configure available attributes

![Menu link attributes config form](../../../../../../../screenshots/menu_link_attributes/1.7.x/attributes.png)

Single config object `menu_link_attributes.config` (key `attributes`). Edit at
`/admin/config/menu_link_attributes/config` (route `menu_link_attributes.config`, task tab
"Available attributes" under Structure → Menus). Permission: `administer menu link attributes`.
The form is a YAML textarea (installing `yaml_editor` improves editing).

Each attribute is a keyed entry; all sub-keys are optional:

```yaml
attributes:
  container_class:              # name = the HTML attribute (also the link options key)
    label: 'Container class(es)' # form label (defaults to humanized name)
    description: '...'           # form field description
  class:
    label: 'Link class(es)'
    description: 'CSS class for the link.'
  target:
    label: 'Link target'
    type: select                # form element type; auto = select if options set, else textfield
    options:                    # required for select/checkboxes/radios
      _blank: 'New window (_blank)'
      _self: 'Same window (_self)'
    default_value: ''           # prefilled value on new links
  data-icon:                    # arbitrary attribute, e.g. a data-* attribute
    label: 'Icon'
```

Sub-keys: `label`, `description`, `type` (`textfield` default, or `select`/`checkboxes`/
`radios`/`managed_file`/any form element), `options` (map, for select-like types),
`default_value`, `upload_location` (for `managed_file`), `container` (`true`/`false`).

**Container vs link attributes:** a name prefixed `container_` (e.g. `container_class`) is
applied to the menu item `<li>` instead of the `<a>`. Force/disable this with `container: true`
or `container: false`. Non-container attributes render on the `<a>` element.

**Storage:** saved values go into the menu link's `link` field `options` under
`attributes` (link) and `container_attributes` (container); `class`/`container_class` are
stored as arrays. Ships as exportable config (`config/install/menu_link_attributes.config.yml`).
Update hooks normalize legacy scalar `class` values and backfill default labels.
