<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TAPIS Jobs integrates TAPIS jobs (running/monitoring science-gateway jobs) into Drupal.

---

TAPIS Jobs **integrates TAPIS jobs into Drupal** — submitting, running and monitoring computational jobs on
the TAPIS science-gateway platform from Drupal. It depends on the TAPIS Tenant/Auth/System/App modules, plus Key,
JWT, Views and HTMX, and provides its own permissions, in the Tapis package.

Use it to run/monitor TAPIS jobs. It is a research-computing integration. Security/data handling: it **calls the
external TAPIS API** (egress) to submit/monitor jobs and authenticates via **TAPIS Auth using JWT/Key** — store the
credentials/keys as **secrets** (Key module — a positive; env) over HTTPS. Jobs may process research data; handle
it appropriately. It has its own permissions. Configure the TAPIS job execution.

---

- Integrate TAPIS jobs.
- Submit/run/monitor jobs.
- Build a science gateway.
- Depend on TAPIS Auth/System/App + Key + JWT.
- Provide its own permissions.
- Serve research computing.
- Call the external TAPIS API (egress) to submit/monitor jobs.
- Authenticate via TAPIS Auth (JWT/Key).
- Store credentials/keys as secrets (Key module - positive; env, HTTPS).
- Handle research data appropriately.
- Configure the job execution.
- Handle TAPIS jobs.
- Run jobs.
- Configure the jobs.
- Monitor jobs.
- Handle the integration.
- Submit jobs.
- Track jobs.
- Secure the keys.
- Provide TAPIS job integration.
