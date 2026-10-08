<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Textimage tokens & implemented hooks

## Tokens

Textimage adds two tokens returning the location of a generated image:

```
[<entity>:textimage-url:<field>{:<display>}{:<sequence>}]
[<entity>:textimage-uri:<field>{:<display>}{:<sequence>}]
```

- `<field>` — machine name of a field displayed with a Textimage formatter (e.g. `body`,
  `field_tagline`).
- `<display>` — optional view-mode (default `default`).
- `<sequence>` — optional index when a field yields multiple images; omitted → a comma-delimited
  list of all URLs/URIs.

Example: `[node:textimage-url:field_tagline:teaser]`. Resolution is implemented by
`TextimageFactoryInterface::processTokens()`.

## Hooks Textimage implements (it does not define an `.api.php`)

Textimage does not invite hook implementations of its own; it hooks into core. Implemented in
`src/Hook/TextimageHooks.php` and `TextimageThemeHooks.php`:

- `hook_help()` — help on the settings route.
- `hook_file_download()` — access control + headers for files under `textimage`/`textimage_store`
  (enables serving private Textimage derivatives).
- `hook_cron()` — deletes temporary/uncached images across writable stream wrappers.
- `hook_theme()` — registers the `textimage_formatter` theme hook (see `theming/formatter.md`).
- Token hooks — provide the `textimage-url` / `textimage-uri` tokens above.

To generate images from your own code, use the `textimage.factory` service
(see `api/factory.md`) rather than a hook.
