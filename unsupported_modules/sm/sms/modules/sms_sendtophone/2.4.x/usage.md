Send To Phone provides tools for sending pieces of site content — a node, a field value, or highlighted inline text — to a mobile phone via SMS Framework.

---

The module exposes a send form at `/sms/sendtophone/{type}/{extra}` (route `sms_sendtophone.page`, permission `access content`), where `{type}` is `node`, `field`/`cck`, or `inline`. `SendToPhoneForm` lets the current user send to their own verified phone number(s); users granted the `send to any number` permission may enter an arbitrary destination number. It also ships a text-format filter (`filter_inline_sms`) that turns `[sms]…[/sms]` tags into a "send to phone" link/icon pointing at the inline send form, a field widget (`SmsSendWidget`) and a field formatter (`SmsLinkFormatter`) for adding send links to fields, plus an admin overview form at `/admin/config/smsframework/sendtophone` (permission `administer smsframework`). Actual delivery goes through SMS Framework's `sms.provider` and the configured gateway.

---

- Let users text a node's content to their phone.
- Let users text a specific field value to their phone.
- Add a "send to phone" button beside highlighted `[sms]…[/sms]` text via a filter.
- Let editors send inline snippets to a phone number.
- Allow privileged users to send to any arbitrary phone number.
- Restrict normal users to sending only to their own verified number.
- Add a send-to-phone link to a field via the field formatter.
- Add a send-to-phone widget on a field edit form.
- Share an article by SMS instead of email.
- Provide a mobile "read it later" style send action.
- Send a coupon code or short instruction to a phone.
- Configure the inline filter to show an icon or a text link.
- Use a custom icon for the inline send link.
- Route sends through the site's configured SMS gateway.
- Gate access to the feature via `access content` + phone verification.
