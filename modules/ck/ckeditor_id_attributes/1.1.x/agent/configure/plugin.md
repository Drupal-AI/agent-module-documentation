# Configure ID Attributes

No standalone settings route. Configuration is per **text format / editor**.

## Enable the button

1. *Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) → configure a format that uses **CKEditor 5**.
2. In *Toolbar configuration*, drag the **ID Attributes** button from *Available buttons* into
   the *Active toolbar*.
3. A plugin settings section **"ID Attributes"** appears with:
   - **Show element IDs in the editor** (`show_id_labels`, default off) — displays each
     element's id as a small label above it, **in the editing view only**. It does not alter
     saved markup; it is an authoring aid.
4. Save the format.

## HTML filtering (important)

The plugin declares `elements: <$any-html5-element id>`, meaning it registers the `id`
attribute as allowed on elements the format already permits. On a **Limited HTML** format with
"Limit allowed HTML tags" enabled, adding this button extends the allowed-tags list to permit
`id` on those tags. Confirm the format's filter configuration allows `id` where editors need
it; on a **Full HTML** format (no tag restriction) this is unrestricted.

## Where settings are stored

Inside the editor config entity `editor.editor.<format>` under the CKEditor 5 plugin settings,
schema `ckeditor5.plugin.ckeditor_id_attributes_idAttributes`:

```yaml
settings:
  plugins:
    ckeditor_id_attributes_idAttributes:
      show_id_labels: true
```

## Config → JS

`IdAttributes::getDynamicPluginConfig()` merges the static config (toolbar key) with
`idAttributes.showLabels = (bool) show_id_labels`. The bundled JS plugin
(`js/build/idAttributes.js`, `js/build/idAttributesLabels.js`, library
`ckeditor_id_attributes/editor`) reads it via
`editor.config.get('idAttributes.showLabels')`. `defaultConfiguration()` is
`['show_id_labels' => FALSE]`; `submitConfigurationForm()` casts the checkbox to bool.
