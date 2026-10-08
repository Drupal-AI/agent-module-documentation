# Configuration

## Open the settings form

1. Log in as a user with the **Administer AI Monitoring** permission.
2. Go to **Configuration → AI → AI Monitoring**
   (`/admin/config/ai/ai-monitoring`).

The settings live in `ai_monitoring.settings`, with a separate configuration
object per channel (`ai_monitoring.channel.email`, `.slack`, `.webhook`,
`.drupal_notification`).

## Choose the AI provider and model

- **AI provider** and **AI model** — which provider and model (from the AI
  module) analyses each batch of log entries. This is the connection that does
  the severity assessment.

## Tune the prompt

- **Max log entry characters** and **max prompt characters** — cap how much text
  is sent per entry and per batch, controlling both cost and how much context the
  model sees.
- **Prompt append** — extra context you want added to every analysis prompt (for
  example, notes about your environment that help the model judge severity).

## Define the routing matrix

- **Routing rules** map each severity level (0–4) to a list of channel IDs. A
  severity mapped to **no** channels is effectively suppressed — a deliberate way
  to silence a level you don't care about.

## Noise controls

Because AI analysis can surface a lot, these settings keep the alert volume sane:

- **Maintenance window** — suppress alerts during planned downtime.
- **Business hours** — hold or digest alerts outside working hours.
- **Digest mode** — batch low-severity items into a summary instead of firing
  each one.
- **Max alerts per hour** — a hard rate limit.

Deduplication (via a dedup key returned by the analysis) also collapses repeats
within a window, and a **circuit breaker** stops calling the AI provider after
repeated failures.

## Set up the alert channels

Each channel has its own configuration object:

- **Drupal notification** — raises an in-site notification.
- **Email** — sends to a recipient using the site mail settings.
- **Slack** — posts to a **Slack incoming webhook URL** you provide.
- **Webhook** — POSTs to an arbitrary outbound URL with a payload template you
  define.

Alert subject and body support `{{token}}` placeholders — for example
`{{severity}}`, `{{message}}`, `{{site_name}}`, `{{next_step}}` — which are filled
in when the alert is sent. You can add your own channel by implementing a plugin
with the `#[AlertChannel]` attribute.

## Save and verify

Save the form, then watch **Reports → AI Monitoring** to confirm batches are
being analysed and that alerts arrive on the channels you configured. Adjust the
routing matrix and noise controls until the signal-to-noise ratio suits your
team.
