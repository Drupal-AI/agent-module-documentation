<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SiteDash connects to the SiteDash monitoring/dashboard service for site management.

---

SiteDash **connects to the SiteDash service** — reporting site audit/health data to the SiteDash monitoring
and management dashboard, using Audit Export. It depends on the Audit Export modules and provides its own
permissions, in the SiteDash package.

Use it to monitor the site via SiteDash. It is a monitoring/integration feature. Security/data handling: it **sends
site audit/health data to the external SiteDash service** (egress — this can include module/version/config details
= fingerprinting/operational data, so keep it to your trusted SiteDash account) and authenticates with
**credentials** (store as secrets — env/Key — over HTTPS). It has no access-control role beyond its permission.
Configure the SiteDash credentials.

---

- Connect to the SiteDash service.
- Report audit/health data.
- Support site management/monitoring.
- Depend on the Audit Export modules.
- Provide its own permissions.
- Serve monitoring/integration.
- Send site audit/health data externally (egress; fingerprinting/operational data).
- Keep it to your trusted SiteDash account.
- Store credentials as secrets (env/Key, HTTPS).
- Have no access-control role beyond permission.
- Configure the SiteDash credentials.
- Handle SiteDash.
- Report data.
- Configure the client.
- Send audits.
- Handle the integration.
- Monitor the site.
- Push health.
- Secure the credentials.
- Provide SiteDash monitoring.
