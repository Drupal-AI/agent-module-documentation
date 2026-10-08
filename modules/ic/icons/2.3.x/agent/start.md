<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Icons (icons) — agent index

Base **API module** for icons. Defines the `icon_set` config entity, an **IconLibrary** plugin
type (one plugin per icon library), a render element (`#type => 'icon'`), a select/picker form
element, and a field type + widget + formatter. Renders icons as CSS icon-font `<span>` elements
(class-based, no inline SVG). Also wires icons into menu links and Views menu displays.

- Depends on core `options`. Core requirement `^10.5 || ^11`.
- No module settings page (no `configure` route in info.yml). The admin UI is the **Icon Set
  collection** at `/admin/appearance/icon_set` (route `entity.icon_set.collection`), gated by the
  core permission `administer site configuration`.
- Defines no own permissions and no drush. Ships config schema. Defines the `IconLibrary` plugin
  type. Bundled provider submodules: `icons_fontawesome`, `icons_fontello`, `icons_icomoon`, plus
  `icons_iconpicker` (a fontIconPicker widget). Enable one provider submodule (or supply your own
  plugin) before you can create an Icon Set.

Solutions:
- **Create / manage an icon set (admin UI or code)** → [configure/icon-sets.md](configure/icon-sets.md)
- **Add a new icon provider plugin (custom library)** → [plugins/icon-library.md](plugins/icon-library.md)
- **Add an icon field to an entity (type / widget / formatter)** → [fields/list-icon.md](fields/list-icon.md)
- **Render an icon in a render array or use the picker element** → [api/render.md](api/render.md)
- **Add icons to menu links or Views menu displays** → [hooks/menu-icons.md](hooks/menu-icons.md)

Key facts:
- Config entity: `icon_set` (config prefix `icons.icon_set.*`, keys `id/label/plugin/description/settings`);
  `admin_permission: administer site configuration`. Links under `/admin/appearance/icon_set`.
- Plugin type **IconLibrary**: attribute `Drupal\icons\Attribute\IconLibrary`, manager service
  `plugin.manager.icon_library` (class `IconLibraryPluginManager`), interface
  `IconLibraryPluginInterface`, bases `IconLibraryPluginBase` and `IconLibraryPluginJsonBase`,
  discovery dir `Plugin/IconLibrary`, alter hook `hook_icon_library_alter`, cache bin key
  `icon_set_libraries`. Bundled plugin ids: `fontawesome`, `fontello`, `icomoon`.
- Service: `icons.manager` (class `Drupal\icons\IconsManager`) — `getIconOptions()`, `processMenuItems()`.
- Render element `#type => 'icon'` (`Drupal\icons\Element\Icon`, `::buildRenderArray('set:name')`);
  form element `#type => 'icon_select'` (`Element\IconSelect`); iconpicker `#type => 'font_icon_picker'`.
- Field: type `list_icon` (extends core `list_string`), widgets `icon_select_widget` and
  `font_icon_picker`, formatter `list_icon`; field-type category `icons`. Stored value is `set_id:icon_name`.
- Theme hooks: `icon` (template `icon.html.twig`), `icon_select` (`icon-select.html.twig`);
  suggestions `icon__{plugin_id}` and `icon__{icon_set_id}`. Asset library `icons/icon_picker`.
