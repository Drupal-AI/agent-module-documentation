<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Jumbotron Canvas code component

Everything this module contributes lives in two config entities under
`config/install/`. There is no PHP. Enabling `canvas_jumbotron` imports both.

## 1. `canvas.js_component.jumbotron` (the source component)
File: `config/install/canvas.js_component.jumbotron.yml`. This is a Canvas
**code component** (`js_component`).

Key fields:
- `machineName: jumbotron`, `name: Jumbotron`, `status: true`, `dependencies: {}`.
- `slots:` three named editable regions — `header` (title "Header"),
  `button` ("Button"), `footer` ("Footer"). Editors fill these with other
  Canvas components.
- `props.image:` a single prop, `type: object`, `$ref:
  json-schema-definitions://canvas.module/image` (the image shape — src, alt,
  width, height — is defined by the **canvas** module, not here). `examples`
  shows a placehold.co URL with `alternateWidths`.
- `required: {}` — no required prop; the image is optional.
- `js.original` / `js.compiled` — the React source (see §3).
- `css.original: ''` (empty); `css.compiled` is just the Tailwind v4.1.13
  preamble comment — the component ships **no** authored CSS.
- `dataDependencies: {}`.

## 2. `canvas.component.js.jumbotron` (the component instance)
File: `config/install/canvas.component.js.jumbotron.yml`. `id: js.jumbotron`,
`label: Jumbotron`, `source: js`, `source_local_id: jumbotron`,
`active_version: 66f3cd7884a741dc`.

- `dependencies.config:` `canvas.js_component.jumbotron`,
  `field.field.media.image.field_media_image`,
  `image.style.canvas_parametrized_width`, `media.type.image`.
- `dependencies.module:` `file`, `media`, `media_library`.
- `versioned_properties.active.settings.prop_field_definitions.image:` binds
  the `image` prop to a **Media entity reference** — `field_type:
  entity_reference`, `target_type: media`, handler `default:media` limited to
  the `image` bundle, widget `media_library_widget`, `required: false`. The
  `expression` maps the referenced media's `field_media_image` to the prop:
  `src` ← `src_with_alternate_widths` (responsive widths via the
  `canvas_parametrized_width` image style), plus `alt`, `width`, `height`.
- `fallback_metadata.slot_definitions:` mirrors the three slots (Header,
  Button, Footer).

## 3. The React source (`js.original`)
```
const Jumbotron = ({ header, button, footer, image }) => {
  if (!image || !image.src) {
    return (<section><div>{header}</div><div>{button}</div><div>{footer}</div></section>);
  }
  return (
    <section>
      <img src={image.src} alt={image.alt || 'Jumbotron header visual'}
           width={image.width} height={image.height} />
      <div>{header}</div><div>{button}</div><div>{footer}</div>
    </section>
  );
};
```
Behaviour: renders a `<section>`; when a media image with a `src` is present it
prepends an `<img>` (alt falls back to `'Jumbotron header visual'`), otherwise
the text-only variant. Slot values (`header`/`button`/`footer`) and the image
fields are rendered through normal JSX interpolation (no
`dangerouslySetInnerHTML`, no raw HTML).

## Install / operate
1. Enable the **canvas** (Experience Builder) module and the Media stack
   (`media`, `media_library`, `file`) first — this module's info.yml declares
   no dependencies, but the config import needs the canvas config entity types,
   the `media.type.image` bundle, `field_media_image`, and the
   `canvas_parametrized_width` image style to exist.
2. `drush en canvas_jumbotron` (or install via the UI). The two config entities
   are imported from `config/install`.
3. In the Canvas editor, add the **Jumbotron** component to a page. Fill the
   Header / Button / Footer slots with other Canvas components; optionally pick
   a hero image via the Media Library widget.
4. No settings form, route, or permission is added — authoring is gated by
   Canvas's own permissions.

## Uninstall
Removes only the two config entities; the module stores no content or state of
its own. Existing page instances that used the component should be removed in
Canvas first.
