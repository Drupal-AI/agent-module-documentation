# Configuration

Reporting is configured by creating and managing **reporting endpoints** — small
configuration entities, one per place you want browsers to send reports. The module
ships one enabled endpoint (`default`) out of the box, so it works immediately; the
rest of this page is about tailoring it.

## Manage endpoints

Go to **Configuration → System → Reporting endpoints**
(`/admin/config/system/reporting`). This requires the **Administer site
configuration** permission. From here you can:

- **Add** an endpoint (`/admin/config/system/reporting/add`) — give it a machine
  **id** and a **label**. You might create one endpoint per report category, e.g.
  `csp` and `deprecations`.
- **Edit** an endpoint — change its label or its enabled state.
- **Delete** an endpoint.

Each endpoint is exported config (`reporting.reporting_endpoint.<id>`), so you can
deploy endpoints as part of your site configuration.

## What an endpoint does

For every **enabled** endpoint, the module:

- advertises it to browsers by adding it to the **`Reporting-Endpoints`** response
  header, mapping the endpoint id to its absolute intake URL, e.g.
  `Reporting-Endpoints: default="https://example.com/system/reporting/default"`; and
- accepts reports POSTed by browsers at **`/system/reporting/{id}`**.

The intake URL is deliberately **public/unauthenticated** — browsers post reports
without credentials, which is how the Reporting API is meant to work.

## Enable / disable an endpoint

Each endpoint has an enabled flag:

- **Enabled** — it's included in the header and its URL accepts reports.
- **Disabled** — it's dropped from the header, and its URL returns **410 Gone**,
  which is the standards-compliant way to tell browsers to stop delivering to it.
  Disabling is a way to switch an endpoint off without deleting its configuration.

You can toggle endpoints from the UI, or script them:

```bash
# create an endpoint
drush php:eval '\Drupal\reporting\Entity\ReportingEndpoint::create(["id" => "csp", "label" => "CSP", "status" => TRUE])->save();'

# disable one
drush php:eval '$e=\Drupal\reporting\Entity\ReportingEndpoint::load("csp"); $e->disable()->save();'

# read its config
drush cget reporting.reporting_endpoint.csp
```

## Integrate with the Content-Security-Policy module

If you install the contrib **Content-Security-Policy** (`csp`) module, Reporting
provides a **"Reporting Endpoint"** handler for it. In the CSP policy settings you
choose one of your reporting endpoints, and CSP will set its `report-uri` to that
endpoint's intake URL and its `report-to` to the endpoint id — so CSP violations
flow straight into Reporting. (If the `csp` module isn't installed, the integration
simply does nothing.)

## Read the collected reports

Reports are written to Drupal's logger (the `reporting` channel), not a custom
table. With core **dblog** enabled, the module adds a **Recent violation reports**
page at **Reports → Recent violation reports** (`/admin/reports/reporting`,
requiring the **Access site reports** permission). It lists each report's endpoint,
date, type, disposition, and location, with each row linking to the full log entry.

Without dblog, reports still reach whatever logging backend you've configured on the
`reporting` channel — you'd read them there instead.

## Good to know

- The endpoint list advertised in the header is cached and automatically refreshed
  whenever you add, edit, or delete an endpoint, so changes take effect right away.
- The intake endpoint returns standards-compliant status codes: `202` on a stored
  report, `400` for a bad body, `405` for a non-POST, `410` when disabled, and `415`
  for an unsupported content type. Responses have empty bodies by design.
- Firefox's non-standard `csp-report` payload is normalized into the Reporting API
  shape automatically, so both formats end up stored consistently.
