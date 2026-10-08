# ACCESS Job Reporting — manual setup guide

**ACCESS Job Reporting** (`access_job_reporting`) is a niche integration module
for Drupal-based **science gateways**. When a compute job run through the
[TAPIS](https://www.drupal.org/project/tapis_job) modules completes, this module
assembles a metadata record about that job and posts it to the **ACCESS-CI
Allocations API**, so the gateway's usage is credited against the right
allocation.

It is aimed squarely at HPC/research-computing sites that submit jobs through the
`tapis_job` and `tapis_system` modules — if you are not running such a gateway,
this module has nothing to offer. For those that are, it automates the accounting
step: on job completion it builds a record (resource name, agent name, job
attributes) and sends a POST to the allocations endpoint (default
`https://allocations-api.access-ci.org/acdb/gateway/v2/job_attributes`). A helper
also asks the API for the list of valid ACCESS resource names to suggest in the
settings form, falling back to a built-in list when the API is unreachable.

Outbound calls use Drupal's core HTTP client with normal TLS certificate
verification and a 10-second timeout. The API key is sent in an `XA-API-KEY`
header and the reporting agent name in an `XA-AGENT` header. You can store the
key directly in module configuration, but the recommended approach is to
reference it from a **Key** entity so it stays out of exported configuration —
the module prefers the Key value when one is available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the endpoint, API key and agent
   name.

## Where it lives in the admin menu

The settings form is at **Configuration → ACCESS → Job Reporting**
(`/admin/config/access/job-reporting`), behind the **Administer site
configuration** permission.
