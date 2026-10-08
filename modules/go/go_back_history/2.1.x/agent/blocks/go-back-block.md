<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Go back history" block

## Install & enable

```bash
composer require drupal/go_back_history
drush en go_back_history -y
```

Only dependency is core **`block`**. No sub-modules, no permissions of its own, no config object,
no Drush commands.

## Place the block

UI path: *Structure → Block layout* (`/admin/structure/block`) → **Place block** in a region →
choose **"Go back history block"** (also listed under the block category *"Go back history block"*).
Configure only the standard block settings (admin title/label, visibility by content type, path,
role, etc.). There are **no module-specific block settings** — `GoBackHistoryBlock` defines no
`blockForm()`/`blockSubmit()`.

Config equivalent (a `block.block.*` config entity, e.g. for the Olivero theme):

```yaml
# block.block.gobackhistory
id: gobackhistory
theme: olivero
region: content
plugin: go_back_history_block
settings:
  id: go_back_history_block
  label: 'Go back'
  label_display: '0'   # hide the title; the button is icon-only by default
  provider: go_back_history
visibility: {}
```

## What it renders (source)

`GoBackHistoryBlock::build()` (`src/Plugin/Block/GoBackHistoryBlock.php`) returns:

```php
return [
  '#theme' => 'block_go_back_history',
  '#button_value' => $this->t('Go back'),
  '#attached' => ['library' => ['go_back_history/go_back_history']],
];
```

- The theme hook **`block_go_back_history`** is defined by `GoBackHistoryHooks::theme()`
  (`src/Hook/GoBackHistoryHooks.php`) → template
  `templates/block--go-back-history.html.twig`, with one variable `button_value`.
- The template outputs the block wrapper (`block`, `block-<provider>` classes, optional `label`
  in an `<h2>`) and, as its content:

  ```twig
  <a class="go-back-history-btn">{{ button_value }}</a>
  ```

  The anchor has **no `href`** — navigation is done entirely in JavaScript.
- `button_value` is the fixed, translatable string **"Go back"**; there is no way to change it
  per block from the UI (override the template or the string translation to change it).

## Behavior (JS)

`js/go_back_history.js` registers `Drupal.behaviors.goBackHistory`. Using `core/once`
(`once('goBackHistoryClick', '.go-back-history-btn', context)`) it binds a click handler that runs:

```js
window.history.back();
```

That is the entire behavior. It uses the **browser's** session history — not the HTTP referrer,
not a `destination`/URL parameter, and not any server value. Consequences:

- If there is no previous entry (a direct/deep-link arrival), the click is a **no-op** — the
  module provides **no fallback URL**.
- It is a client-side gesture, not a Drupal route/redirect; it cannot be pointed at an arbitrary
  target and does not participate in access control.

## Styling

`css/go_back_history.css` renders the block (`.block-go-back-history`) as a 48×48 semi-transparent
round button and paints `.go-back-history-btn` with the `images/left-arrow.svg` icon while setting
the label `color: transparent` (icon-only). To restyle: override `.block-go-back-history` /
`.go-back-history-btn` in your theme, or provide your own
`block--go-back-history.html.twig` to change the markup or show the text label.

## Library

`go_back_history/go_back_history` (`go_back_history.libraries.yml`) = `css/go_back_history.css`
(theme) + `js/go_back_history.js`, with dependencies `core/drupal`, `core/jquery`, `core/once`.
It is attached automatically by `build()` whenever the block renders.

## Gotchas

- Hide the block title (`label_display: '0'`) unless you want an `<h2>` above the icon — the
  default styling assumes an icon-only control.
- Because the button relies on `jQuery` + `core/once`, it only works with JS enabled.
- No config schema ships with the module (it has no config object of its own), so there is nothing
  to export beyond the standard `block.block.*` entity above.
