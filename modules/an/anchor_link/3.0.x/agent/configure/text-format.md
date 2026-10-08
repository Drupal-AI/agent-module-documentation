# Enable the anchor button in a text format

There is no global settings page. Configure per text format at
`/admin/config/content/formats/manage/<format>` (e.g. `full_html`).

## Steps
1. Set **Text editor** to **CKEditor 5**.
2. In the toolbar configurator, drag the **Anchor link** button from *Available buttons*
   into the *Active toolbar*.
3. Save. The button is defined in `anchor_link.ckeditor5.yml` as plugin
   `anchorDrupal.Anchor` (toolbar item id `anchor`).

## Allowed markup
The plugin declares these elements/attributes, so if the format uses the **Limit allowed
HTML tags** filter they are added automatically:
```
<a>
<a id="">
<a target="">
<a rel="">
<a class="ck-anchor">
```
- Named anchors render as `<a id="name" class="ck-anchor">`; the `ck-anchor` class drives
  the editor marker styling (library `anchor_link/admin.cke5_anchor_link`).
- Because config is per format, enable it on Full HTML and leave Basic HTML untouched, etc.

## Requirement
The JS build lives at `/libraries/ckeditor5-anchor-drupal/build/anchor-drupal.js`. Install
the `vardot/ckeditor5-anchor-drupal` library (pulled in by the module's composer.json) into
the site `libraries/` directory so the `anchor_link/cke5_anchor_link` library resolves.
