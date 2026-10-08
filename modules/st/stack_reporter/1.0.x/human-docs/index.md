# Stack Reporter — manual setup guide

**Stack Reporter** (`stack_reporter`) exposes a small, API-key-protected endpoint
that reports your site's technology-stack versions — Drupal, PHP, and Node.js — so
the external **StackReporter** service can monitor them.

StackReporter is a hosted service that keeps track of the stacks running across
your sites. This module is the Drupal side of that: it adds an endpoint at
`/api/v1/stack-reporter` which, when called with the correct API key, returns a
small JSON document listing the site's Drupal version, PHP version, and Node.js
version. That lets the service watch for out-of-date components across your estate
without anyone logging in to each site.

The endpoint is gated by a configurable API key. The access check requires a
non-empty key in the request that matches the key you configured, so it correctly
refuses when no key is supplied — there is no empty-key bypass. Two things are
worth keeping in mind. First, the response is effectively a **version
fingerprint** of your site, so anyone holding the key learns exactly which
versions you run; treat the API key as a secret and hand it only to the monitoring
service. Second, Node.js detection relies on PHP's `exec()` function being enabled
and Node being installed on the server, so on hosts where `exec()` is disabled the
Node version simply will not be reported.

The module provides its own permission, has no other module dependencies, and runs
on Drupal 9.4+ (through 11) with PHP 8.0 or higher. At the time of writing it is
not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the API key and describe your
   site's stack.

## Where it lives in the admin menu

Its settings screen is at **Configuration → System → Stack Reporter**
(`/admin/config/system/stack-reporter`), where you enter the API key and other
site information.

## How to use the endpoint

Once an API key is set, the endpoint lives at `/api/v1/stack-reporter`. A caller
authenticates by supplying the key either as a query parameter
(`?apikey=your_api_key`) or in a JSON request body (`{"apikey": "your_api_key"}`),
and receives a JSON response along the lines of:

```json
{
  "drupal_version": "10.1.2",
  "php_version": "8.2.7",
  "node_version": "18.16.0"
}
```
