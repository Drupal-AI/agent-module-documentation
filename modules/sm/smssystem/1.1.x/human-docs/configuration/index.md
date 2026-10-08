# Configuration

SMS System spreads its configuration across several admin screens, all under
**Configuration → System → SMS System** (`/admin/config/system/smssystem`). You'll
want a user with the module's administration permission to reach them.

## Main settings

`/admin/config/system/smssystem`

The general settings for the module. This is where you'll find the overall
behaviour options — including **Test mode**, which lets you exercise the sending
flow without actually dispatching (and paying for) real SMS. Turn Test mode on
while you're setting things up and for local development, and turn it off when
you're ready to send live messages.

## API settings

`/admin/config/system/smssystem/api`

Where you connect SMS System to your **SMS gateway** and enter the account
**credentials** it authenticates with. The module has been tested with InterMobcom
and can also work with BulkSMS, PROCONTEXT, and EMOTION TRADING. Treat the
credentials here as secrets — prefer an environment variable or a Key entity over
plain exported configuration, and don't commit them to version control.

## SMS message templates

`/admin/config/system/smssystem/templates/list`

Define reusable message templates here. Each template has a machine name you pass
to `sendSmsByTemplate()` (for example `order_completed`). Because the module works
with **Token**, template text can include token placeholders that are filled in at
send time with dynamic values.

## Reporting

`/admin/config/system/smssystem/reporting`

Every sent SMS is logged, and this screen (built on **Views**) lets you monitor
the history — filter, paginate, and, with **Views data export**, export it.

## SMS queue list

`/admin/config/system/smssystem/sms-queue-list`

For high‑load sites you can push sends onto a queue (the `sms_send_processing`
queue) instead of sending immediately; queued messages are processed in the
background by **cron**. This screen lists the queued messages. In code, pass `TRUE`
as the third argument to `sendSms()` / `sendSmsByTemplate()` to queue a send rather
than dispatch it straight away.

## A word on abuse and privacy

Because each SMS costs money, be careful about which events trigger sends: a
public‑facing action wired to a send is a potential spam / cost‑abuse vector, so
gate your triggers to trusted flows. Recipient phone numbers are personal data —
handle them with appropriate consent and privacy safeguards.
