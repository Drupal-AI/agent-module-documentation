<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end behavior, per-link control, events & theming

No PHP service API — the module works via `hook_page_attachments()` plus JS. Summary so you
need not read `external_link_popup.module` or `js/dialog.js`.

## What gets attached

`external_link_popup_page_attachments()`:

- Skips admin routes unless `settings.show_admin` is true.
- Loads all **enabled** pop-up entities, sorts them by weight (`ExternalLinkPopup::sort`).
- Puts them + settings into `drupalSettings.external_link_popup`:
  ```js
  drupalSettings.external_link_popup = {
    whitelist: "...",           // newline domains
    width: "85%",               // value+units joined
    popups: [ /* serialized pop-ups */ ]
  };
  ```
- Attaches the `external_link_popup/dialog` library (deps: `core/once`, `core/drupal.dialog`).

Each pop-up is JSON-serialized (`ExternalLinkPopup::jsonSerialize`) to:
`{ id, name, status, weight, close, title, body (rendered via check_markup), labelyes,
labelno, domains, target }` where `target` is `_blank` when `new_tab` is on, else `_self`.

## Control a specific link

- **Exclude**: add CSS class `external-link-popup-disabled` to the `<a>` — never shows a pop-up.
- **Force a specific pop-up**: add `data-external-link-popup-id="<machine name>"` to the `<a>`.
  Overrides all domain matching (except the disabled class) and **also works for local links**.
- **Whitelist**: a link whose host matches `settings.whitelist` (or a subdomain of it) is skipped.

## JS events (fired on `window`)

| Event | When |
|---|---|
| `externalLinkPopup:yes` | user clicked Yes/continue; pop-up closes and navigation proceeds |
| `externalLinkPopup:no` | user cancelled |
| `externalLinkPopup:notFound` | no pop-up configured for the link |
| `externalLinkPopup:skipped` | skipped (whitelisted domain or `external-link-popup-disabled`) |

```js
$(window).on('externalLinkPopup:yes', (e) => {
  console.log(e.popupId, e.domain, e.target); // e.g. analytics on exit intent
});
```

## Theming (jQuery UI dialog)

Wrapper classes on the dialog:

- `.external-link-popup` — every pop-up dialog.
- `.external-link-popup-id-<machine name>` — a specific pop-up (e.g. `...-id-default`).
- `.external-link-popup-body` — the body section.

Style via jQuery UI selectors, e.g. `.external-link-popup .ui-dialog-titlebar` (header),
`.external-link-popup .ui-dialog-buttonpane .ui-button` (buttons). Set `min-width`/`max-width`
in CSS (the dialog opens at the configured width, default 85% of document width).
