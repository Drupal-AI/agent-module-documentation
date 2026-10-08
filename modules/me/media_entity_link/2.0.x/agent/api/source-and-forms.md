<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `link` media source plugin, add form, and hooks

## The `link` MediaSource plugin

`Drupal\media_entity_link\Plugin\media\Source\MediaEntityLink` — a plugin of **core Media's**
`MediaSource` type (this module does **not** define a plugin type of its own):

```php
@MediaSource(
  id = "link",
  label = "Link",
  allowed_field_types = {"link"},
  default_thumbnail_filename = "no-thumbnail.png",
  forms = { "media_library_add" = "\Drupal\media_entity_link\Form\LinkMediaLibraryAddForm" }
)
```

- `getMetadataAttributes()` returns `[]` (a link has no extracted metadata; the value *is* the URL).
- `createSourceField()` creates the `link`-type source field labelled "Link".
- `prepareViewDisplay()` sets the source field to render with the core `link` formatter, label hidden.
- Config schema `media.source.link` extends `media.source.field_aware`.

## The Media Library add form

`Drupal\media_entity_link\Form\LinkMediaLibraryAddForm` extends
`Drupal\media_library\Form\AddFormBase`; form id `media_entity_link_media_library_add`. It builds
a single **URL** input whose type depends on the field's `link_type` setting:

- external allowed → a `url` element;
- internal allowed → an `entity_autocomplete` element targeting `node`, disabling autocomplete
  when the first character is `/`, `#`, or `?`.

It supports the same special tokens as a core link widget: `<front>`, `<nolink>`/`<none>`, and
`route:<button>`, mapping user input to `entity:node/<id>`, `internal:…`, or `route:…` URIs
(`getUserEnteredStringAsUri()`), and validates external-vs-internal against `link_type`
(`validateUriElement()`). This is why you get friendly internal-path autocomplete and token
support when adding a Link in the Media Library.

## Hooks (OOP, via `MediaEntityLinkHooks`)

Registered as an autowired service (`media_entity_link.services.yml`) and dispatched by the
thin `.module` shims:

- `#[Hook('help')]` — help text on `help.page.media_entity_link`.
- `#[Hook('form_alter')]` — on the `media_entity_link_form_media_library_add` form for the
  `link` bundle, clears the auto-generated media **name** default and re-labels it ("Enter the
  text to be used as file name.").

There is no service API you would normally call directly; interact with the module by creating
`media` entities of bundle `link` and reading their `field_media_entity_link` value (see
[configure/link-media-type.md](../configure/link-media-type.md)).
