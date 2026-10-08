# CKEditor5 Open New Tab — agent index

Adds an "Open in new window" checkbox (`target="_blank"`) to CKEditor 5's link dialog. Depends on core
`ckeditor5`. No config page (`configure` null), no permissions, no schema, no Drush, no plugin types.

- **How it works and how to enable/customize it** → [configure/enable.md](configure/enable.md)

Key facts:
- `ckeditor5_open_new_tab.module` implements `hook_ckeditor5_plugin_info_alter()` to replace the
  `ckeditor5_link` plugin class with `Plugin/CKEditor5Plugin/CKEditor5Link`.
- That class's `getDynamicPluginConfig()` appends a **manual link decorator**
  `{mode:'manual', label:'Open in new window', attributes:{target:'_blank'}}` to the `link` config.
- Nothing to configure — just enable the module; the checkbox appears wherever the core Link toolbar
  button is enabled on a CKEditor 5 text format.
- Caveat: the `target` attribute only persists if the text format's *Limit allowed HTML tags* filter
  permits `<a target>`.
