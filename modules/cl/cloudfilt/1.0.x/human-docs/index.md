# CloudFilt — manual setup guide

**CloudFilt** (`cloudfilt`) connects your Drupal site to the third‑party
**CloudFilt** threat‑protection service. It works as a security middleware: on
every incoming request it checks the visitor's IP address against CloudFilt and
blocks traffic the service identifies as bad — bots, web scrapers, Tor exit
nodes, spam submissions, fraud and DDoS. It's an edge‑style protection layer that
filters malicious traffic before it does any harm.

The module solves the problem of unwanted automated traffic hitting your site.
Because it queries CloudFilt through a StackMiddleware, the check runs early in
Drupal's request handling. It works as soon as it is enabled *and configured*
with your CloudFilt account keys — there is nothing to protect against until it
can authenticate to the service. It has no Drupal dependencies beyond core.

A few things are worth understanding before you turn it on. CloudFilt makes an
**outbound HTTP call on every request**, which adds a little latency and a
dependency on the CloudFilt service, so confirm how your site should behave if
CloudFilt is ever unreachable (fail‑open versus fail‑closed) — you do not want an
outage to lock out all of your visitors. The module sends the **visitor's IP
address** to CloudFilt; an IP is personal data, so disclose this in your privacy
policy. Your CloudFilt public and private keys are credentials — treat the
private key as a secret. Note that CloudFilt performs edge filtering only; it does
**not** grant or restrict Drupal permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your CloudFilt keys and choose
   which roles to skip.

## Where it lives in the admin menu

Once enabled, configure CloudFilt at **Configuration → Web services → CloudFilt**
(`/admin/config/services/cloudfilt`).
