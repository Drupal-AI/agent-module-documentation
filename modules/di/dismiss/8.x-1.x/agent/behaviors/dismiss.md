<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dismiss — JS behavior, library and hooks

Everything the module does, grounded in its four source files. There is no PHP business logic, no
config, no routes and no dependencies beyond Drupal core.

## Install / enable

- `composer require drupal/dismiss` then `drush en dismiss -y` (or enable at
  `/admin/modules`). Composer `require` is empty (`composer.json`), so nothing else is pulled in.
- No configuration step: `dismiss_help()` (`dismiss.module`, `hook_help` for route
  `help.page.dismiss`) says only *"Adds a 'Dismiss' button to Drupal messages, warnings, and
  errors."* There is no settings form and `configure` is not set in `dismiss.info.yml`.

## Asset library — `dismiss/drupal.dismiss`

Defined in `dismiss.libraries.yml`:

```
drupal.dismiss:
  version: VERSION
  js:    { js/dismiss.js: {} }
  css:   { theme: { css/dismiss.base.css: {} } }
  dependencies: [ core/jquery, core/drupal ]
```

It is attached on **every page** by `dismiss_page_attachments(array &$page)` in `dismiss.module`
(`hook_page_attachments`), which appends `'dismiss/drupal.dismiss'` to
`$page['#attached']['library']`. So the button appears anywhere Drupal renders a `.messages`
container, front-end and admin alike, with no opt-in per theme or route.

## Behavior — `Drupal.behaviors.dismiss` (`js/dismiss.js`)

`attach(context, settings)` does two things, wrapped in the classic `(function ($, Drupal) { … })`
IIFE:

1. **Inject the button.** For each `$('.messages')`, if its children do not already include a
   `.dismiss` element (`hasClass('dismiss')` guard, which prevents duplicate buttons when `attach`
   runs again after AJAX), it prepends the literal string
   `'<button class="dismiss"><span class="element-invisible"></span></button>'`.
2. **Bind dismissal.** `$('.dismiss').click(...)` runs `$(this).parent().hide('fast')` to slide the
   message container away, and `event.preventDefault()` so that clicking the button inside a form
   does not submit the form.

Notes for agents:

- The button markup is a **fixed literal** — no message text, request data, config or settings is
  interpolated into it, so there is no injection surface here.
- **No state is persisted.** The handler only calls jQuery `.hide()`; there is no cookie, no
  `localStorage`/`sessionStorage`, and no request back to Drupal. Reloading the page brings the
  messages back if the underlying condition still produces them. (Despite older drupal.org copy
  mentioning an auto-hide option, this source has no timeout/auto-hide and no config for it.)
- The click handler selects `$('.dismiss')` globally (not scoped to `context`), so on repeated
  `attach` calls handlers can be bound more than once; functionally harmless because the action is
  idempotent hide.
- Relies on the theme rendering messages inside `.messages` elements (Drupal core's standard
  `status_messages` markup); a theme that renders messages without that class gets no button.

## Styling — `css/dismiss.base.css`

Loaded in the `theme` CSS group. Sets `div.messages { position: relative; padding-right: 1.5em; }`
so the button can be absolutely positioned top-right, styles `.dismiss` (orange `#ed541d` pill with
a `\2715` "✕" glyph via `::before`), gives per-type colours through `.error .dismiss`,
`.status .dismiss`, `.warning .dismiss`, and reveals the button fully on `.messages:hover`. Purely
presentational; safe to override in a theme.

## What it does NOT provide

No entities, fields, plugins, blocks, services, routes, permissions, config objects/schema, install
hooks, update hooks, Drush commands, or submodules — confirmed by the module having only
`dismiss.info.yml`, `composer.json`, `dismiss.module`, `dismiss.libraries.yml`, `js/dismiss.js`,
`css/dismiss.base.css` and `README.md`.
