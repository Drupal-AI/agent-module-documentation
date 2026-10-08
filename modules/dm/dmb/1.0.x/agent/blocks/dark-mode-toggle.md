<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dark Mode Toggle block (`dmb_block`)

The module's only feature: a block that renders an icon button toggling a client-side dark theme.

## Install and place

1. Enable: `drush en dmb -y` (requires core `block`, which is normally already on).
2. Place the block: at `/admin/structure/block`, click *Place block* in the target region and pick
   **Dark Mode Toggle** (`dmb_block`). Save. No block-specific settings exist beyond core's
   title/visibility options.
3. The button appears in that region on the front end immediately — there is no configuration form.

Scope where it shows with core block **visibility conditions** (pages, content types, roles). The
same `localStorage` key backs every placement, so multiple instances stay in sync per browser.

## The block plugin

`src/Plugin/Block/DmbBlock.php` — `DmbBlock extends BlockBase`, annotated:

```
@Block(
  id = "dmb_block",
  admin_label = @Translation("Dark Mode Toggle"),
)
```

`build()` returns:

```php
return [
  '#theme' => 'dmb_dark_mode_toggle',
  '#attached' => ['library' => ['dmb/dark_mode']],
];
```

That is the whole plugin — no injected services, no settings, no access override (default block
access applies).

## Theme hook and template

`dmb.module` implements `hook_theme()` registering `dmb_dark_mode_toggle` with **no** variables.
The template `templates/dmb-dark-mode-toggle.html.twig` is static markup:

```html
<div id="dmb-block-container">
  <button id="dark-mode-toggle">
    <i class="bi {{ dark_mode_icon }}"></i>
  </button>
</div>
```

Note: `dark_mode_icon` is not passed as a theme variable, so it renders empty on the server; the
icon class is set at runtime by JavaScript. The `bi` base class comes from Bootstrap Icons.

## Library

`dmb.libraries.yml` defines two libraries:

- `dmb/dark_mode` — attaches `css/dark-mode.css` and `js/dark-mode.js`; depends on `core/jquery`,
  `core/jquery.once`, and `dmb/bootstrap_icons`.
- `dmb/bootstrap_icons` — an **external** CSS asset:
  `https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css` (`type: external`),
  which supplies the moon/sun glyph fonts. This is a third-party CDN request made from the
  visitor's browser.

## Runtime behavior (`js/dark-mode.js`)

`Drupal.behaviors.darkModeToggle.attach()`:

- Defines `toggleIcon()`: if `<body>` has class `dark-mode`, sets the glyph to `bi-sun-fill`;
  otherwise `bi-moon-fill`. It targets `$('#dark-mode-toggle .bi')`.
- On attach, reads `localStorage.getItem('dark-mode')`; if `'true'`, adds `dark-mode` to `<body>`
  and re-runs `toggleIcon()`.
- Binds a click handler once (`.once('darkModeToggle')`) on `#dark-mode-toggle` that toggles the
  `dark-mode` body class, writes the resulting boolean to `localStorage` under key `dark-mode`,
  and updates the icon.

State is purely per-browser via `localStorage`; nothing is sent to or stored on the server.

## Styling (`css/dark-mode.css`)

Styles `#dmb-block-container` (flex, centered, padding) and `#dark-mode-toggle` (borderless,
`cursor: pointer`, `1.5rem`). Defines `body.dark-mode` and a set of `.dark-mode …` overrides for
`.container`, headings (`h1`–`h6`), links (`a`, with `!important`), `.tabs__link`, `.pager__item a`,
tag fields, `.site-branding__inner`, nav menus, and `p:has(code)` code blocks. These selectors
assume a common (Olivero-like) theme markup. To darken additional elements, add your own
`body.dark-mode …` rules in a custom theme or library rather than editing the module.

## Notes for agents

- There is nothing to configure via Drush or config export; the module ships no `config/` and no
  schema. `provides_permissions`, `provides_config_schema`, `provides_drush_commands` are all false.
- Behavior is jQuery + `jquery.once` based; on very new cores where `core/jquery.once` is
  deprecated the dependency still resolves via the compatibility shim.
