# Configuration

All screens require the **administer log alert rules** permission, which is
restricted to trusted admins.

## Post-installation checklist

1. Ensure **Database Logging (dblog)** is enabled.
2. Go to **Configuration → System → Log Alert Rules**
   (`/admin/config/system/log-alert-rules`).
3. Create one or more alert rules for the channels and severities you care about.
4. **Test** each rule against recent log entries before you rely on it.
5. Set up notification targets and verify delivery in your environment.

## Create an alert rule

From the Log Alert Rules screen, add a rule. A rule can target:

- **Log channel** — a specific channel, or any channel.
- **Severity level(s)** — one or more (e.g. warning, error, critical).
- **Message pattern** — a substring or a PCRE regex to match, with an optional
  **negate pattern** to exclude certain messages.
- **Raw or rendered matching** — whether to match the raw message template or the
  rendered message.
- **Threshold and time window** — how many matching entries within a sliding window
  should trigger the alert.
- **Cooldown** — how long to suppress repeat alerts after one fires, so a
  persistent problem doesn't flood your inbox.

Rules can be **enabled or disabled** (the toggle is CSRF-protected), and you can
**test** a rule to preview whether it would fire against recent entries.

## How evaluation works (worth knowing)

Matching is captured as each log entry is written, but evaluation is **deferred**
until after the response is sent — so alerting doesn't slow down page requests.
When it runs, it counts occurrences, applies the cooldown, and dispatches to the
rule's enabled notification targets. Log context variables are sanitised before
being placed into notification messages.

## Notification targets

Notification targets are reusable, named destinations you define once at
`/admin/config/system/log-alert-rules/targets` and attach to any number of rules —
so a single critical alert can reach, say, **email and Slack at once**. Each target
can be **enabled or disabled** with one click (CSRF-protected), which mutes that
destination across every rule at the same time.

Available channels depend on which submodules you enabled:

- **Email** *(base module)* — send alerts to an operations address.
- **Slack** *(Webhook submodule)* — Block Kit messages posted to a Slack incoming
  webhook.
- **Generic webhook** *(Webhook submodule)* — POST a JSON payload to any endpoint.

### Storing a webhook URL securely

The Webhook submodule stores the destination URL through the **Key** module rather
than in plaintext configuration. Create a Key holding your Slack/webhook URL, then
select it on the notification target.

> **With DDEV**, you can keep the URL in an environment variable —
> `ddev dotenv set .ddev/.env --slack-webhook-url=<value>` then `ddev restart` —
> and create a Key that reads from that variable, so the secret never lives in
> config. Keep `.ddev/.env` out of version control.

The webhook channel posts over HTTPS with TLS verification left at safe Guzzle
defaults, a short timeout, and bounded retries (honouring `Retry-After` on 429
responses).

## Export and import

Rules can be **exported as YAML** (single rule or in bulk) for deployment and
**imported** from a YAML file — the importer is backward-compatible with older
single-rule exports. Both are permission-gated.

## Security posture

Every route requires the restricted **administer log alert rules** permission, and
all state-changing toggles additionally require a CSRF token. The module exposes
alert *configuration* to permitted admins — not raw log contents — and defines no
anonymous or log-disclosure endpoints.
