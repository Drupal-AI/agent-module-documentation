# Send To Phone (`sms_sendtophone`) — agent index

Submodule of SMS Framework. Sends nodes / field values / inline text to a phone via SMS.
Provides a filter, a field widget, and a field formatter.

- **Routes, permissions, filter/widget/formatter plugins** →
  [configure/tools.md](configure/tools.md)

Key facts:
- Send form route `sms_sendtophone.page` → `/sms/sendtophone/{type}/{extra}` (`{type}` =
  `node` | `field`/`cck` | `inline`), permission `access content`. `SendToPhoneForm` sends to
  the user's own verified number(s); the `send to any number` permission allows an arbitrary
  destination.
- Admin overview: `/admin/config/smsframework/sendtophone` (permission `administer smsframework`).
- Plugins: filter `filter_inline_sms` (`[sms]…[/sms]` → send link/icon), field widget
  `SmsSendWidget`, field formatter `SmsLinkFormatter`. Delivery via `sms.provider`.
- Parent: [../../../../2.4.x/agent/start.md](../../../../2.4.x/agent/start.md)
