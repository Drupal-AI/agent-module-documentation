# Configuration

Dynatrace's settings tell the module where your Dynatrace tenant is and how to
authenticate when it posts metrics. A separate page shows the current trace context.

## Open the settings form

1. Log in as a user with the **Administer Dynatrace** permission.
2. Go to **Configuration → Development → Dynatrace**
   (`/admin/config/development/dynatrace`).

## What to configure

- **Metric ingest URL / Dynatrace environment** — the endpoint for your Dynatrace
  tenant's metric ingest API. Point this at *your own* Dynatrace environment, and
  always over **HTTPS**. (When metrics are ingested locally through OneAgent, host
  context such as `dt.entity.host` is added automatically, so you don't need to set
  it by hand.)
- **API token** — the Dynatrace API token used to authenticate metric posts. As
  covered in [Installation](../installation/index.md), keep this in an environment
  variable / Key rather than typing a raw secret into configuration where possible.

Save the form.

## View trace information

Visit `/admin/config/development/dynatrace/trace-info` (same **Administer
Dynatrace** permission). If the OneAgent PHP extension is present, this page shows
the current **trace id**, **span id**, and whether the trace is valid — handy for
correlating a specific Drupal request with its trace in the Dynatrace UI. If the
extension isn't installed, the page tells you OneAgent isn't configured.

## Posting metrics

Sending custom metrics is done from code, not this form. From your own module you
build gauge or count metrics and post them; a common pattern is to emit them from a
cron hook or an event subscriber when a domain event occurs (an order placed, a job
processed). Errors while posting are logged rather than shown to end users. See the
[`agent/`](../agent/start.md) docs and the module's own API classes for the exact
method calls.

## Privacy and egress reminder

Posting metrics (and OneAgent tracing) sends data **out of your infrastructure to
Dynatrace**. Confirm that this outbound flow, and the contents of the metrics and
dimensions you emit, are acceptable under your organisation's privacy and
data‑handling policies before enabling it on production — and keep the token
scoped to only what it needs.
