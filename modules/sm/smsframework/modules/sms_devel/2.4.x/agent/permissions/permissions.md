# SMS Devel — permission & the test form

## Permission

| Permission | Grants |
|---|---|
| `sms_devel form` | Access `/admin/config/development/sms` to send or receive test messages. |

## The test form

`Drupal\sms_devel\Form\SmsDevelMessageForm` (route `sms_devel.message`, path
`/admin/config/development/sms`, menu "Test SMS" under Development, id `sms_devel_message_form`).

Fields: **Phone number**, **Message**, **Gateway** (select of configured gateways; empty = automatic
routing — not allowed when receiving), plus **Options**: *Force skip queue* (process immediately),
*Automated* (flag the message), *Verbose output* (show a full result table), *Send on* (schedule).

Two submit buttons:
- **Send** → sets `Direction::OUTGOING` and calls `sms.provider->send()` (when skip-queue + verbose)
  or `->queue()`. Verbose mode renders each recipient's `SmsMessageResult` (error, credits) and its
  delivery reports as a table.
- **Receive** → sets `Direction::INCOMING`, attaches fake reports, and calls `sms.provider->incoming()`
  (skip-queue) or `->queue()`. A gateway must be selected.

This exercises the parent framework's real send/receive path
([send flow](../../../../2.4.x/agent/api/services.md)); with the default `log` gateway a "send" just
writes to the Drupal log and reports DELIVERED. It is a build-time/testing aid — grant `sms_devel form`
to developers/administrators only.
