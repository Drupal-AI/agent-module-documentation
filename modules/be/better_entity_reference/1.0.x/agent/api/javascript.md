<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JavaScript component kit & per-widget API

The widgets are thin consumers of a public JS kit shipped in
`better_entity_reference.libraries.yml`. Other modules can compose new popover UIs or extend the
shipped widgets without patching. (Source is minified in `dist/js/`; readable sources in `js/`.)

## Layers

- **`window.BerUi`** (`js/core.js`) — framework-agnostic, no Drupal dependency: `Component`
  (chainable modifiers: `withClasses`, `withText`, `withAttribute`, `withAria`, `on`, `show`/
  `hide`, `enable`/`disable`, `setLoading`) and `Container extends Component` (child API: `add`,
  `addComponent`, `addAll`, `addComponents`).
- **`Drupal.berUI`** (`js/kit.js`, library `better_entity_reference/ui`) — the Drupal adapter:
  extends the core classes (`withTooltip()`, etc.), wires `Drupal.t`, and builds the concrete
  widget components: `window()`, `view()`, `search()`, `toolbar()`, `viewSwitch()`, `list()`,
  `listItem()`, `upload()`, `button()`, and `display.tag/doc/image/media()`. Register/replace types
  with `ui.register(name, factory)` / `ui.create(name, options)`.
- **`Drupal.berTags`** (`js/api.js`, library `better_entity_reference/api`) — lower-level building
  blocks (`components.*`: `list`, `listItem`, `tag`, `searchBox`, `sortBar`, `filterBar`,
  `progressRow`, `dragReorder`, `createForm`, `createView`, `toolbar`, ...), the shared `popover`
  machinery (`place`, `anchorAt`, `portalFor`, `closeOthers`), `tooltip`, `confirm`, `toast`,
  `undo`, `codecs`, `sortStore`/`viewStore`, and `dom`/`util` helpers.
- **`Drupal.berUpload`** (`js/file.model.js`) adds the chunked `uploadFile()`, `formatBytes()`,
  `copyText()` and hook-driven `fileTypes` colors; `Drupal.berMedia.Model` (`js/media.model.js`)
  holds the media widget's state/server logic. Widget logic (models) is deliberately split from
  rendering (`*.widget.js`).

## Extension events (dispatched on `document`)

- `ber-ui:build` — a widget finished assembling; detail `{ scope, window, views/panel/uploader }`
  (`scope` = image/file/media).
- `ber-ui:build:<type>` — a kit component was built (`window`, `view`, `toolbar`, `list`, `button`,
  `upload`, `viewSwitch`, `search`); `ber-ui:build:view:<name>` for named views (`browse`,
  `upload`, `add`), carrying `scope`.
- `ber-ui:toolbar-button` — mutable, alter a toolbar button before placement (`detail.weight`,
  `detail.el`).
- `ber-toolbar:toggle`, `ber-popover:place`, `ber-ui:loading`/`ber-ui:loaded`.

```js
document.addEventListener('ber-ui:build:view:browse', (event) => {
  if (event.detail.scope !== 'media') return;
  event.detail.window.getFooter().addOnce('my-action').addComponent(
    Drupal.berUI.create('button', { label: Drupal.t('My action'), onClick: () => {} }),
  );
});
```

## Per-widget instance API

Each widget root exposes `el.berTags`:

```js
const w = document.querySelector('[data-ber-tags]').berTags;
w.selection.get();                 // ordered [{id, label}]
w.selection.select('12', 'Crimson');
w.addItem({ id: 99, label: 'Ruby', parent_ids: [16] });
w.openFolder('16', 'Colors');
w.open(); w.refresh();
w.root.addEventListener('change', () => { /* fires on every pick/remove */ });
```

## Scaling

Every size derives from one CSS variable — set `--ber-scale` (e.g. `1.2`) in a theme to resize the
whole UI.

See the `better_entity_reference_demo` submodule for a complete worked example of every extension
point.
