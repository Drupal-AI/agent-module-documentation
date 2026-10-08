# How Toastify intercepts messages (+ permissions & JS API)

## Server side — the `status_messages` element override

`toastify_element_plugin_alter()` swaps core's `status_messages` render element class for
`Drupal\toastify\Element\ToastifyStatusMessages`. Its `renderMessages()` does **not** render
message markup; instead it pulls the queued messages with `Messenger::deleteAll()` and passes
them to the browser as `drupalSettings.toastify.messages`. This only happens when
`toastify_is_active()` is TRUE (permission + enabled-for-theme); otherwise it falls back to
the parent `StatusMessages` behaviour, so messages render normally.

`toastify_page_attachments()` attaches the libraries (`toastify/toastify`,
`toastify/toastify.messages`, and `toastify/gin` under Gin) and exposes
`drupalSettings.toastify.settings` (the whole `toastify.settings` config).

## Client side

- `js/toastify-attach.js` defines `Drupal.toastify.getDefaultSettings(type)` (maps config to
  toastify-js options) and `Drupal.behaviors.toastify`, which loops over
  `drupalSettings.toastify.messages` and calls `Toastify(...).showToast()` for each.
- `js/toastify.messages.js` overrides `Drupal.theme.message` so messages added client-side
  via the core Message API (`Drupal.Message().add()`) are shown as toasts too. If
  `drupalSettings.toastify` is absent it falls back to the default message markup.

There is **no** PHP service and no plugin type. To trigger a toast from code you simply add a
Drupal message the normal way and let the override handle it:

```php
\Drupal::messenger()->addStatus(t('Saved.'));   // shown as a green toast when active
```

## Permissions

| Permission | Gates |
|---|---|
| `show toastify messages` | Whether this user's messages are shown as toasts at all. Without it, standard Drupal messages render. Grant to roles that should see toasts (usually the same audience as `access content`). |
| `administer toastify configuration` | Access to the settings form (`restrict access: true`). |
