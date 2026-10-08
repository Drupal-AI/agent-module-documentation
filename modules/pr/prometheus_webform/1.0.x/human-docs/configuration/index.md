# Configuration

This add-on has no configuration form of its own. There are two things to do, and
both live in the parent **Prometheus Exporter** module.

## 1. Enable the collector

Open the **Prometheus Exporter settings form** and enable the
**webform_submissions** collector, just as you would enable or disable any other
collector. Once it is on, the exporter's `/metrics` endpoint includes a gauge
named `<namespace>_total`, with one series per webform, labelled
`webform="<webform_id>"`, reporting that webform's total submission count.

If you would rather not publish submission volumes at all, simply leave this
collector disabled.

## 2. Protect the `/metrics` endpoint (important)

The `/metrics` endpoint and its access control belong to the **Prometheus
Exporter** module, not to this add-on — this module only registers a collector. So
the endpoint's protection is configured on the exporter's side (typically a token
or a permission).

The data this collector adds is **aggregate submission counts per webform**
(totals only, never the submitted field values). Even so, submission volumes can
be sensitive operational data — a competitor or attacker learning how many people
submit a given form is information leakage. Before pointing a scraper at it:

- Confirm the exporter's `/metrics` endpoint is **not anonymously readable** —
  that it is gated by the exporter's token/permission and, ideally, only reachable
  from a firewalled or internal network.
- If submission volumes are sensitive for your site, keep this collector
  **disabled** rather than relying solely on endpoint protection.

Refer to the Prometheus Exporter module's own documentation for exactly how its
endpoint authentication is configured.
