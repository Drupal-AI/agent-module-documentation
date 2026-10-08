# Quick Tabs (quicktabs) 4.3.x — agent index

Build tabbed/accordion blocks whose tabs load a node, block, View, or another
Quick Tabs instance. Each tab set is a `quicktabs_instance` config entity, placed
as a derived block. Requires `block` and `js_cookie`.

- Create/manage tab sets, instance options, styles, config entity/schema, AJAX route → [configure/tab-instances.md](configure/tab-instances.md)
- Tab type + tab renderer plugin types and how to add one → [plugins/plugin-types.md](plugins/plugin-types.md)
- Alter an instance at render time with `hook_quicktabs_instance_alter()` → [api/hooks.md](api/hooks.md)
- Permission: `administer quicktabs` gates the whole admin UI and entity forms (see configure doc).
- Submodules add renderers: quicktabs_accordion (`accordion_tabs`), quicktabs_jqueryui (`ui_tabs`).
