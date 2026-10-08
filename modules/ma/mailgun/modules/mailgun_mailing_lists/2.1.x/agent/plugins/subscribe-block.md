<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mailing_list_subscribe` block plugin

Class `Drupal\mailgun_mailing_lists\Plugin\Block\MailingListSubscribeBlock`
(`@Block(id = "mailing_list_subscribe", admin_label = "Mailing list subscribe form")`). This is a
standard core Block plugin — you place/configure it, you don't implement a new plugin type.

## Configuration

- Block setting **`mailing_list`** — the Mailgun list *address* this block subscribes people to.
- Set on the block placement form (a text field), stored in the Block config entity under
  `settings.mailing_list`.
- `blockForm()` renders the field; `blockSubmit()` saves `$this->configuration['mailing_list']`.

## Behavior

- `build()` constructs a `MailingListSubscribeForm` with the injected `mailgun.mailgun_client`
  and the configured list address; the form shows a single **Email** field.
- On submit the form calls `mailingList()->member()->show()` (to detect an existing member) and
  `mailingList()->member()->create($listAddress, $email, $email)` to subscribe the address.
- `label()` fetches the list's display name from the Mailgun API when `mailing_list` is set.

Because `build()`/`label()` call the Mailgun API, actual rendering needs a valid API key
(parent `mailgun.settings`). Placing the block and setting `mailing_list` is pure Drupal config
and does not call the API.

## Dependencies injected

`create()` injects `mailgun.mailgun_client` (the shared `Mailgun\Mailgun` instance from the
parent module) and `form_builder`.
