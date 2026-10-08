# Configuration

The heart of configuring CiviMRF is creating a **connection** to your CiviCRM
instance. You do this from CiviMRF's configuration (under **Configuration**); the
submodules then use that connection.

## Create a connection to CiviCRM

Add a connection and provide the details CiviCRM's REST API needs:

- **CiviCRM URL / endpoint** — the address of your remote CiviCRM's REST API.
- **API key** — the API key of the CiviCRM API user you're connecting as.
- **Site key** — CiviCRM's site key.

Use the **most restricted CiviCRM API user** that can still perform the operations
you need — this connection is effectively a grant over the CRM's contact, donor and
membership data, so least privilege matters.

## Secure the credentials

The API key and site key are secrets and should not live in plain configuration or
version control. The recommended pattern is to keep them in environment variables and
reference them through a **Key** entity.

> **Using DDEV?** Store a secret without committing it:
> `ddev dotenv set .ddev/.env --civicrm-api-key=<value>`, then `ddev restart` so DDEV
> loads it into the web container. Keep `.ddev/.env` out of version control. If you
> use the [Key](https://www.drupal.org/project/key) module, create a Key backed by
> the environment variable and point the connection at it, so the secret is never
> stored in the database.

## Use TLS

Because personal data crosses a network boundary on every call, make sure the
CiviCRM endpoint is an **HTTPS** URL so the connection is encrypted in transit. Note
this processing in your privacy assessment.

## Plan for latency and outages

Every remote call happens on the request path, so it becomes part of your page's
response time. Two practical decisions:

- **Cache aggressively** so you aren't calling CiviCRM on every page view.
- **Decide the fallback** for when CiviCRM is unreachable (it will happen). Showing a
  stale but rendered list is usually a better experience than a blank or broken page.

## Build with the submodules

Once the connection works:

- With **`cmrf_views`**, add a View and choose the CiviCRM connection as its data
  source to build membership lists, event listings, supporter directories and the
  like.
- With **`cmrf_webform`**, map Webform submissions to CiviCRM API calls so form
  submissions post into the CRM.
- Use **`cmrf_call_report`** to see what calls are being made while you debug.
