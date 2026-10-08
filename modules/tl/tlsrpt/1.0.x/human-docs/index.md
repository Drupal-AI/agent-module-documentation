# TLSRPT — manual setup guide

**TLSRPT** (`tlsrpt`) gives your Drupal site a small web service that receives
SMTP TLS reports — the "TLS-RPT" aggregate reports defined by
[RFC 8460](https://www.rfc-editor.org/rfc/rfc8460) — from other mail servers, and
logs them to the database.

If your domain publishes a TLS-RPT policy, other Mail Transfer Agents (MTAs) that
send you email will periodically post back a report describing how their attempts
to negotiate TLS with your mail server went — which succeeded, which failed, and
why. Those reports need somewhere to land. TLSRPT is that landing point: it
exposes an endpoint that accepts the incoming JSON reports and stores them (using
the JSON Field module) so you have visibility into the security of email transport
to your domain.

Because the endpoint ingests reports submitted from outside your site, treat it as
an untrusted input surface: validate and restrict submissions appropriately for
your environment rather than leaving it wide open. The module ships two
permissions — `administer tlsrpt` for administration and `create tlsrpt` for
creating (submitting) reports — so you can control who and what is allowed to post.

TLSRPT works as a receiving service once enabled; there is no configuration form to
fill in. It depends on the **JSON Field** module (`json_field`) and requires
**Drupal 11.2 or newer**.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   JSON Field dependency, and enable the module.

## How to use it

Once enabled, the module provides the reporting endpoint that collects TLS-RPT
reports from sending mail servers and logs each one to a database table as JSON.
Point your domain's TLS-RPT policy at this endpoint (per your mail
infrastructure's setup) and review the stored reports to monitor TLS negotiation
successes and failures over time. Use the `administer tlsrpt` and `create tlsrpt`
permissions to keep the endpoint appropriately restricted.
