# How the dialog and logging work (api)

There are no public services. The whole feature is: a form-alter hook that ships data to the browser,
a JS behavior that renders a dialog, and one controller route that records a log line.

## 1. Form alter — `confirm_unpublish_form_node_form_alter()`

In `confirm_unpublish.module` (implements `hook_form_node_form_alter`). On **every** node add/edit
form it:

- Attaches the `confirm_unpublish/confirm_unpublish` library.
- Reads `confirm_unpublish.settings`. Only when `allowed_content_types` is non-empty and the current
  bundle is not in it (see configure/settings.md) does it attach `drupalSettings`:

```php
$safe_message = check_markup($raw_message, $format);   // alert_text via its text format
$translated_message = t(strip_tags($safe_message));    // tags stripped, then t()
$form['#attached']['drupalSettings']['confirm_unpublish'] = [
  'message' => $translated_message,
  'logging' => $config->get('logging'),
  'user_id' => \Drupal::currentUser()->id(),
  'node_id' => $form_state->getFormObject()->getEntity()->id(),
];
```

The message is run through `check_markup()` then `strip_tags()` before it reaches the browser, so the
dialog body is effectively plain text (HTML markup in `alert_text` is removed on output). `node_id`
is `NULL` on a node *add* form (entity not yet saved).

## 2. JS — `js/confirm_unpublish.js`

`Drupal.behaviors.confirmUnpublish` (guards `context === document`):

- Tracks the Published checkbox `input[name="status[value]"]`.
- On a checked→unchecked transition it opens a modal jQuery-UI dialog (`core/drupal.dialog`, title
  `Confirm Unpublish`, width `50%`) whose body is `drupalSettings.confirm_unpublish.message`.
- **Cancel** re-checks the box (`$checkbox.prop('checked', true)`) and closes.
- **Confirm** just closes the dialog (sets `wasChecked = false`); it does **not** submit or block the
  form — the box stays unchecked and the editor still has to press Save. If `logging` is true it
  fires `$.post(Drupal.url('confirm-unpublish/log'), {uid, nid})`.

The guard is purely advisory/UX; it does not prevent unpublishing and does not run server-side.

## 3. Log endpoint — route `confirm_unpublish.log`

- Path `/confirm-unpublish/log`, `_access: 'TRUE'`, controller
  `Drupal\confirm_unpublish\Controller\ConfirmUnpublishController::log(Request $request)`.
- Reads `uid` and `nid` from the POST body. If `confirm_unpublish.settings:logging` is on it loads the
  user (`user` storage) and node (`node` storage), resolves the node's path alias
  (`path_alias.manager`), and writes a `notice` to the `confirm_unpublish` logger channel:

```
User %user confirmed unpublish of %alias. This only means they clicked continue on the
confirmation box. It does not mean they actually saved the node. ...
```

- `%user` = loaded account name or `Unknown`; `%alias` = alias of `/node/<nid>` (or the raw path).
  Both are safe `%` placeholders (escaped by the logger).
- Always returns `JsonResponse(['status' => 'ok'])`, regardless of whether anything was logged.

Constructor deps (via `create()`): `config.factory`, `logger.factory`, `path_alias.manager`,
`entity_type.manager` → `user` and `node` storage.
