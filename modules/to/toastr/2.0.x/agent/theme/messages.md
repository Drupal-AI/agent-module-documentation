# Library integration & how a message becomes a toast

## Libraries (`toastr.libraries.yml`)

- **`toastr/core`** — the toastr.js library itself. Loaded from a **CDN**, not bundled:
  - JS: `//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js` (`type: external`)
  - CSS: `//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css`
  - `version: 2.1.4` is declared, but the URL path is `/latest/` (whatever cdnjs currently serves).
  - Depends on `core/jquery`.
- **`toastr/messages`** — the module's glue: `js/messages.js`. Depends on
  `core/drupalSettings` and `toastr/core`.

Because the asset is a remote CDN URL, toasts silently do not appear if the site is
offline / the CDN is blocked. There is no local fallback and no README step to install the
library locally in this version.

## Attachment flow (`toastr.module`)

1. `toastr_page_attachments(&$attachments)` — attaches `toastr/messages` on **every** page.
2. `toastr_js_settings_alter(&$settings, $assets)`:
   - Calls `\Drupal::messenger()->deleteAll()` — this **removes** all queued messages from
     the Messenger, so they will *not* render in the theme's normal status-messages region;
     they only show as toasts (requires JavaScript).
   - If any messages exist, it loads `toastr.settings`, fills each `toastr_*` key
     (falling back to `ToastrSettingsForm::defaultSettings()`), then sets:
     - `drupalSettings.toastr.messages` — the messages, keyed by type (`status`,
       `warning`, `error`), each an array of message strings.
     - `drupalSettings.toastr.settings` — a copy of the merged settings containing the
       `toastr_*` values that `messages.js` reads.

## Rendering (`js/messages.js`)

`Drupal.behaviors.toastrMessages.attach` iterates `settings.toastr.messages` by type. For
each message it builds `toastr.options` from `settings.toastr.settings.toastr_*`, maps the
Drupal type to a toastr method, and calls it:

| Drupal message type | toastr call |
|---|---|
| `status` | `toastr.success(item)` |
| `warning` | `toastr.warning(item)` |
| `error` | `toastr.error(item)` |

(`status` is the only type remapped; others pass through by name.)

## Making your own message a toast

Anything added through Drupal's Messenger becomes a toast automatically, because
`deleteAll()` collects them all:

```php
\Drupal::messenger()->addStatus($this->t('Saved.'));     // -> green success toast
\Drupal::messenger()->addWarning($this->t('Heads up.'));  // -> warning toast
\Drupal::messenger()->addError($this->t('Failed.'));      // -> error toast
```

No custom JS API is exposed for pushing an ad-hoc toast; the module only forwards
Messenger messages. The message text is whatever core would have rendered — a sanitized
`Markup` string — and toastr injects it as the toast body.

## Notes

- Since the module removes messages from the normal region, the old "Status messages"
  block can be removed from Block layout (per the module README).
- The library is attached on the front end and admin alike; scope it with a subtheme /
  conditional attachment if you only want it in one theme.
