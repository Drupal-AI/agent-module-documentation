# sendgrid_integration_reports — agent start

Submodule of **sendgrid_integration**. Adds an admin **SendGrid Reports** dashboard
(`admin/reports/sendgrid`) that reads email statistics from the SendGrid v3 API using the parent
module's configured API key, and caches them in a dedicated cache bin. Depends on
`sendgrid_integration`. Package: Mail.

- Report date range / aggregation settings, cache bin, permissions → [configure/settings.md](configure/settings.md)
- Fetch stats programmatically (the `Api` service: stats, browsers, devices, bounces, subusers) → [api/api.md](api/api.md)
