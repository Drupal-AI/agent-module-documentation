# Splunk Real User Monitoring — manual setup guide

**Splunk Real User Monitoring** (`splunk_rum`) adds the Splunk RUM
(Real User Monitoring) browser script to your site's pages. That script
instruments the front end so page‑load performance, JavaScript errors and real
user‑experience data are collected in the visitor's browser and reported to
**Splunk Observability Cloud** — giving you end‑to‑end visibility from the browser
through to your backend services.

The module gives you a small configuration form where you enter your Splunk
**access token**, an **application name** and an **environment**, which it uses to
build the SignalFx/Splunk RUM JavaScript snippet. Nothing is monitored until you
fill those in, so this module needs configuration before it does anything. It has
no module dependencies and runs on Drupal 10 and 11.

This only works if you already have a running **Splunk Observability** environment
to send the data to. The recommended companion is the **OpenTelemetry** module.

A note on data: RUM collects real‑user behaviour and sends it to a third party
(Splunk), and the access token is a credential — keep it out of code and version
control, and treat what you collect as a privacy/consent consideration.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module.
2. [Configuration](configuration/index.md) — enter your Splunk access token,
   application name and environment.

## Where it lives in the admin menu

After you enable the module, its settings live at `/admin/config/splunk-rum`. Add
your parameters there and save, and the RUM script is injected into your pages.
