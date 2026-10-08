<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webhook, bot commands & admin messages — alert_telegram

## Inbound webhook
Route `alert_telegram.webhook` → `POST /alert-telegram/webhook/{secret}` (`{secret}` regex `.+`),
`_access: 'TRUE'`. `Controller\WebhookController::handle($secret, Request $request)`:
1. Loads `webhook_secret` from `alert_telegram.settings`; if `$secret !== $webhook_secret` returns HTTP 403
   `Access Denied` and logs a warning. (Strict comparison; the configured secret is required/non-empty.)
2. Reads the raw body, `Json::decode()`s it (400 on empty/invalid JSON).
3. If `$update['message']` is present, extracts `chat_id`, `text` (trimmed), `message_id` and dispatches on
   the command text.

Always returns `200 OK` after processing a valid update.

## Bot commands (switch on `$text`)
- `/start` — replies with the command menu (quoting the user's message).
- `/ask` — replies "Please, ask your question." and sets state `awaiting_question`.
- `/feedback` — replies "Please, leave your feedback." and sets state `awaiting_feedback`.
- `/subscribe` — `addSubscriber()` (merge into `alert_telegram_subscribers` keyed by `chat_id`) and confirms.
- `/unsubscribe` — `removeSubscriber()` (delete the row) and confirms.
- default — reads per-user state via `\Drupal::state()->get('alert_telegram_user_state_' . $chat_id)`:
  - `awaiting_question` → `saveMessage(chat_id, text, 'question', message_id)`, `notifyAdmin(...)`, thank-you
    reply, clear state.
  - `awaiting_feedback` → same with type `feedback`.
  - otherwise → "Sorry, I do not understand this command." reply.

State is stored in the key-value `state` store, one key per chat id, cleared after capture.

## Persistence helpers (parameterized DB queries)
- `addSubscriber` / `removeSubscriber` → `alert_telegram_subscribers`.
- `saveMessage` → insert into `alert_telegram_messages` (`chat_id`, `message`, `message_type`, `created` =
  request time, `message_id`).

## Admin email — `notifyAdmin($chat_id, $text, $type)`
- Reads `notification_emails`, splits on newlines. If empty, logs an error and returns.
- Body = intro + `Html::escape($text)` + link to `/admin/reports/telegram-messages`; `format => 'html'`.
- Sends via `plugin.manager.mail` → `alert_telegram_mail()` (`hook_mail`, key `user_message`) to each address.

## Admin messages report — `Controller\MessagesController::listMessages()`
Route `alert_telegram.messages_list` (`view telegram messages`). Selects `alert_telegram_messages` with
`TableSortExtender` + `PagerSelectExtender` (20/page), renders a core `#type => 'table'` (cell values
auto-escaped). Each row gets a **Reply** link (AJAX modal, `use-ajax`, `data-dialog-type => modal`) and, when
the user has `delete telegram messages`, a **Delete** link. Attaches `core/drupal.dialog.ajax`.

## Reply — `Form\ReplyForm`
Route `alert_telegram.reply_form` (GET/POST, `view telegram messages`), form id `alert_telegram_reply_form`.
`buildForm($form, $form_state, $id)` loads the message's `chat_id`; `submitForm()` calls
`TelegramClient::sendMessage($chat_id, $reply_message, $reply_to_message_id)` and redirects to the list.
(Standard Form API CSRF token applies.)

## Delete — `Controller\MessageActionsController::deleteMessage($id)`
Route `alert_telegram.delete_message` (`administer site configuration`). Re-checks the permission, verifies the
row exists, deletes it, sets a messenger message, and redirects to `/admin/reports/telegram-messages`.
