<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Send To Phone (sms_sendtophone) — agent index

Submodule of **SMS Framework** ([parent docs](../../../../2.4.x/agent/start.md)). Adds a "Send to
phone" capability that texts a piece of content (a node's URL, a text field's value, or text marked
with `[sms]…[/sms]`) to a phone number, via a shared send form. Depends on `smsframework:sms`.

- **The send route/form, the admin content-type selector** → [configure/settings.md](configure/settings.md)
- **The field formatter, field widget and text filter that expose the link** → [fields/formatter-widget.md](fields/formatter-widget.md)

Key facts:
- Send form route `sms_sendtophone.page` → `/sms/sendtophone/{type}/{extra}`
  (`Drupal\sms_sendtophone\Form\SendToPhoneForm`, id `sms_sendtophone_form`),
  `_permission: 'access content'`; `type` ∈ `node|field|inline|cck`.
- Admin route `sms_sendtophone.admin_overview` → `/admin/config/smsframework/sendtophone`
  (`administer smsframework`), config object `sms_sendtophone.settings` (key `content_types`).
- Permission `send to any number` (send to an arbitrary number; otherwise the user's own confirmed
  number is used).
- Field plugins: formatter `sms_link` (`SmsLinkFormatter`, text fields), widget `sms_sendtophone`
  (`SmsSendWidget`, text fields), filter `filter_inline_sms` (`FilterInlineSms`).
- Node integration: `hook_node_links_alter` adds a "Send to phone" link on enabled content types.
- Sends via the parent `sms.provider` ([send flow](../../../../2.4.x/agent/api/services.md)).
