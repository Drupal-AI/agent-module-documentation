<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Toastify intercepts messages (+ permissions & JS API)

## Server side — the `status_messages` element override

`toastify_element_plugin_alter()` (in `toastify.module`) swaps core's `status_messages` render
element class for `Drupal\toastify\Element\ToastifyStatusMessages`. That class extends core
`StatusMessages`; its `renderMessages()` does **not** render message markup — instead it pulls
the queued messages with `Messenger::deleteByType()` / `deleteAll()` and passes them to the
browser as `drupalSettings.toastify.messages`. `getInfo()`/`generatePlaceholder()` are
overridden so the messages are always placeholdered (works for both GET and POST). All of this
only happens when `toastify_is_active()` is TRUE (not-XHR + permission + enabled-for-theme);
otherwise it falls back to the parent `StatusMessages` behaviour and messages render normally.

`toastify_page_attachments()` attaches the libraries (`toastify/toastify`,
`toastify/toastify.messages`, plus `gin/gin_base` and `toastify/gin` under Gin) and exposes
`drupalSettings.toastify.settings` (the whole `toastify.settings` config).

## Client side

- `js/toastify-attach.js` defines `Drupal.toastify.getDefaultSettings(type)` (maps config to
  toastify-js options: gradient background from `direction`/`color`/`color2`, `progressBar`,
  `offset`, `className` `toastify--<type>`) and `Drupal.behaviors.toastify`, which loops over
  `drupalSettings.toastify.messages` and calls `Toastify(...).showToast()` for each, then clears
  the array.
- `js/toastify.messages.js` overrides `Drupal.theme.message` so messages added client-side via
  the core Message API (`Drupal.Message().add()`) are shown as toasts too. If
  `drupalSettings.toastify` is absent it falls back to the default message markup.

There is **no** PHP service and no plugin type. To trigger a toast from code you simply add a
Drupal message the normal way and let the override handle it:

```php
\Drupal::messenger()->addStatus(t('Saved.'));   // shown as a green toast when active
```

## Libraries (`toastify.libraries.yml`)

| Library | Contents |
|---|---|
| `toastify/library` | Bundled toastify-js v1.12.0 (`js/toastify.js`) + `css/toastify.css` |
| `toastify/toastify` | `js/toastify-attach.js`; depends on drupalSettings, jQuery, jquery.once, `toastify/library` |
| `toastify/toastify.messages` | `js/toastify.messages.js`; also depends on `core/drupal.message` |
| `toastify/gin` | `css/gin.css`; depends on `toastify/library` |

## Permissions (`toastify.permissions.yml`)

| Permission | Gates |
|---|---|
| `show toastify messages` | Whether this user's messages are shown as toasts at all. Without it, standard Drupal messages render. Grant to roles that should see toasts. |
| `administer toastify configuration` | Access to the settings form (`restrict access: true`). |
