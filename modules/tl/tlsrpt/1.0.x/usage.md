<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TLSRPT provides a reporting endpoint that collects SMTP TLS-RPT reports from mail servers.

---

TLSRPT provides an endpoint for receiving SMTP TLS reports (TLS-RPT, RFC 8460) from Mail Transfer Agents — so a domain publishing a TLS-RPT policy can collect the aggregate reports MTAs send about TLS negotiation success/failure when delivering mail to it, giving visibility into email-transport security.

Permissions cover administration (`administer tlsrpt`) and creating reports (`create tlsrpt`). Because the endpoint ingests external reports (JSON), validate/restrict submissions appropriately. Depends on `json_field`; requires Drupal 11.2+.

---

- Receive SMTP TLS-RPT reports.
- Collect reports from MTAs.
- Support RFC 8460.
- Give email-transport visibility.
- Track TLS negotiation success/failure.
- Provide a reporting endpoint.
- Gate admin with `administer tlsrpt`.
- Gate creation with `create tlsrpt`.
- Validate/restrict submissions.
- Depend on `json_field`.
- Require Drupal 11.2+.
- Store reports as JSON.
- Support email security
- Configure the endpoint
- Ingest external reports.
- Monitor TLS reporting.
- Aggregate reports.
- Support TLS-RPT
