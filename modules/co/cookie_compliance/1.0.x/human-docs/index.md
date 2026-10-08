# Cookie Compliance — manual setup guide

**Cookie Compliance** (`cookie_compliance`) adds a cookie‑consent banner to your
site by wiring in the hosted **hu‑manity.co** (cookie‑compliance.co) service. It is
a thin integration: rather than shipping its own consent logic, it injects the
hu‑manity.co banner script into every page's `<head>`, keyed by an **App ID** you
obtain from that service. All of the banner's behavior — consent categories, cookie
blocking, and consent storage — lives in the remote service and its CDN script, not
in Drupal.

The module does nothing until you configure it: you register your domain at
cookie‑compliance.co, get an **App ID** (and optionally an App Secret Key), enter it
on the settings form, and tick the enable box. When enabled with a non‑empty App
ID, the module writes an inline `huOptions` snippet plus a
`<script src="https://cdn.hu-manity.co/hu-banner.min.js">` tag into the head on
every response.

Because the banner is loaded from an **external CDN on every page**, it is a
client‑side third‑party dependency — if you run a Content‑Security‑Policy, allow
`cdn.hu-manity.co` as a script source. There is no server‑side callback or data
ingestion. The App ID is an account identifier (configuration), not a secret. The
settings route is gated by the core **Administer site configuration** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your App ID and switch the
   banner on.

## Where it lives in the admin menu

Once enabled, configure the module at **Configuration → System → Cookie Compliance**
(`/admin/config/system/cookie-compliance-settings`).
