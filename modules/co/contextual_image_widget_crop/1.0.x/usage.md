Shows only the crop type(s) relevant to where a Media image will be displayed, when editors add or edit an image through the Media Library.

---

Contextual Image Widget Crop extends the Image Widget Crop module for the Media Library workflow. On an entity's *Manage display*, a Media reference field is usually rendered through an image style that applies a `crop_crop` effect tied to one crop type (aspect ratio). This module inspects those image styles and, when an editor opens the media library to add or edit an image, limits the ImageWidget crop tool to just the crop type(s) actually used in that context — hiding all other configured crop types so editors are not asked to crop aspect ratios that will never be shown. It ships two field widgets (an entity-reference "Contextual Image Widget Crop: Media library" widget that replaces the core Media Library widget, and a "Contextual ImageWidget crop" image widget for the Media type's Image field), an in-modal AJAX media edit form served from a new `/media/{media}/ajax` route, and a small thumbnail refresh template. It provides no settings form, no permissions, and no config schema of its own — it reuses the crop types, image styles and Image Widget Crop settings you already have.

---

- Restrict editors to the single crop type used by a node teaser image style, hiding all other aspect ratios.
- Simplify a multi-aspect-ratio media workflow so editors only crop what will actually be rendered.
- Add contextual cropping to a blog post's teaser Media reference field per the README's blogpost example.
- Crop a Media image inline from the media library selection, in a modal AJAX dialog, without leaving the host entity form.
- Refresh the thumbnail preview of a cropped media item in place after saving the crop, via AJAX.
- Derive the relevant crop type automatically from the image style's `crop_crop` effect on *Manage display*.
- Support fixed image styles configured on the Media field formatter.
- Support responsive image styles, resolving crop types from `image_style` and `sizes` mappings.
- Reuse existing Crop API crop types and Image Widget Crop configuration without redefining them.
- Replace the core Media Library widget on an entity-reference field with the contextual variant.
- Replace the Media type's Image field widget with the contextual ImageWidget crop widget on the media library form display.
- Present a single-aspect-ratio crop UI to editors on content types that reference media images.
- Avoid the "image used in multiple places" multi-usage crop warning when editing in a known display context.
- Force the crop area to be shown when a context crop type is supplied.
- Keep crop editing scoped to entities the editor may update (the AJAX edit route requires media update access).
- Provide an "edit / crop" link on each selected media item that opens the AJAX crop form for that item.
- Standardize teaser/hero image aspect ratios across an editorial team by removing irrelevant crop choices.
- Use with multiple bundles that reference the same Media type but display it at different aspect ratios.
- Let editors correct or re-crop an existing media image directly from the referencing entity's form.
- Combine with responsive_image so all breakpoint-mapped styles' crop types are offered contextually.
- Reduce editorial errors from cropping the wrong aspect ratio for a given placement.
