# Configure per text format

There is **no dedicated admin page**. Configuration lives inside each text format's
CKEditor 5 settings: **Admin → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) → *Configure* a format that uses CKEditor 5.

## Enable the plugin

The plugin `editor_advanced_link_link` ("Advanced links") activates automatically when the
core **Link** (`ckeditor5_link`) plugin is present (see `conditions.plugins: [ckeditor5_link]`
in `editor_advanced_link.ckeditor5.yml`). Its settings appear in the CKEditor 5 plugin
settings vertical tabs as **Advanced links**.

## Enabled attributes

The settings form (`Plugin/CKEditor5Plugin/AdvancedLink::buildConfigurationForm`) exposes one
checkbox per supported `<a>` attribute:

| Setting label | Attribute written |
|---|---|
| ARIA label | `aria-label` |
| Title | `title` |
| CSS classes | `class` |
| ID | `id` |
| Open in new window | `target="_blank"` |
| Link relationship | `rel` |

Only the checked attributes appear in the editor's link dialog. Stored as
`enabled_attributes` (a sequence of attribute strings) under the editor's
`settings.plugins.editor_advanced_link_link` config; schema is
`ckeditor5.plugin.editor_advanced_link_link` in `config/schema/editor_advanced_link.schema.yml`.

## Interplay with the HTML filter

If the format enables **Limit allowed HTML tags and correct faulty HTML**, an attribute is
only usable when it is allowed on the `<a>` tag. Enabling an attribute here contributes the
matching allowed-HTML fragment via `getElementsSubset()`, e.g. `<a title>`, `<a class>`,
`<a id>`, `<a aria-label>`, `<a rel>`, `<a target="_blank">`. Checking **Open in new window**
also registers a manual CKEditor link decorator that writes `target="_blank"`
(`getDynamicPluginConfig`).

## Notes

- `defaultConfiguration()` is `enabled_attributes: []` — nothing is exposed until you opt in.
- The same fields are added to the classic/editor link dialog via a form alter (see
  [../extend/integrations.md](../extend/integrations.md)); there the fields show based on the
  filter's allowed `<a>` attributes rather than these checkboxes.
- Settings are plain config: exportable and deployable with the text format.
