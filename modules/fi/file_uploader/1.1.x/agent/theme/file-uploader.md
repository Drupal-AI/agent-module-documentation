# Theme, template, library and client wiring

## Theme hook `file_uploader`

Registered in `file_uploader.module` via `hook_theme()` as a `render element` named `element`.
Template `templates/file-uploader.html.twig` simply wraps the rendered element in the container the
JS binds to:

```twig
<div{{ attributes.addClass('file-uploader') }}>
  {{ element }}
</div>
```

Available variables: `element` (the file-uploader form element) and `attributes`.

## Theme suggestion

`hook_theme_suggestions_file_uploader()` adds one suggestion: the element's `#upload_provider`, i.e.
`file_uploader__<provider>`. So an integration or theme can override markup per provider with
`file-uploader--<provider>.html.twig`.

## Library

`file_uploader.libraries.yml` defines one library:

```yaml
widget:
  version: VERSION
  js:
    public/js/widget.js: { minified: true }
  dependencies:
    - file_uploader/base
```

`public/js/widget.js` (built from `components/widget/widget.js`) declares the global store
`window.DrupalFileUploader = {}` and a behavior `Drupal.behaviors.fileUploader` that, for each
`div.file-uploader`, reads `drupalSettings.file_uploader[element.id]` and instantiates the
provider's class: `new window.DrupalFileUploader[options.provider](element, options)`.

The concrete uploader class (`window.DrupalFileUploader.<provider>`) is supplied by an integration
module, which is why `FileUploader::processFileUploader()` attaches `"<provider>/widget"` (the
integration's library), not this module's `file_uploader/widget`.

## `drupalSettings.file_uploader[<element_id>]`

Published by the element process step; this is the contract a JS provider consumes:

```js
{
  provider: "uppy",            // #upload_provider
  name: "field_image",          // element #name
  options: {
    // ...#upload_options (the widget's saved settings), plus:
    xhr: "/file-uploader/upload?token=…&key=…",
    validators: { limit: 3, extensions: [".png", ".jpg"], filesize: 2097152 }
  },
  values: [ { fid, name, url, size, type }, … ]   // existing files as previews
}
```

Post each selected file (field name `file`) to `options.xhr`; the endpoint returns `{value: <fid>}`
on success (HTTP 200) or an error string with HTTP 400. Append returned fids to the hidden `fids`
field so core `ManagedFile` validation/submit picks them up.
