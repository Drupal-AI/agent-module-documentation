# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → ACCESS → Job Reporting**, or navigate directly to
   `/admin/config/access/job-reporting`.

Restrict this permission to site administrators — the form holds the API
credentials used to report usage on your behalf.

## Settings

- **Allocations API endpoint** — the URL the job records are POSTed to. It
  defaults to the production ACCESS-CI allocations endpoint
  (`https://allocations-api.access-ci.org/acdb/gateway/v2/job_attributes`).
  Override it only when you need to point at a staging environment.

- **API key** — the credential sent in the `XA-API-KEY` header to authenticate
  your gateway to the allocations API. You can enter it directly here, but the
  preferred approach is to **reference a Key entity** (from the Key module)
  instead — the module uses the Key value when one is configured, which keeps the
  secret out of exported configuration. Avoid committing a plaintext key into
  version control.

- **Agent name** — the identifier sent in the `XA-AGENT` header, naming the
  reporting gateway.

- **ACCESS resource name** — which ACCESS resource(s) your local TAPIS systems map
  to. The form suggests valid `xsederesourcename` values by querying the
  allocations API; if the API is unreachable it falls back to a built-in list.

## After configuring

- Once set, completed TAPIS jobs are reported automatically — there is no manual
  send step.
- Outbound requests use normal TLS verification and a 10-second timeout.
- If reports are not arriving, check the **`access_job_reporting`** log channel
  (**Reports → Recent log messages**) for failed submissions, and verify
  connectivity to the allocations API before go-live.
- If the resource-name suggestions come back empty, the API is likely unreachable
  or the key is wrong — the module will fall back to its built-in list in the
  meantime.
