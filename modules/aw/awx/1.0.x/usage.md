<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AWX / Ansible Tower Client is a small, autowired Drupal service that launches AWX / Ansible Tower job templates over the REST API for other modules to call.

---

The module wraps AWX / Ansible Tower's `/api/v2/job_templates/{id}/launch/` endpoint as a typed Drupal service (`awx.awx_client`, class `Drupal\awx\Service\AwxClient`). It handles authentication (bearer token), endpoint construction, Guzzle timeouts, TLS verification, structured logging, and typed failure modes so consumers do not reinvent HTTP plumbing. It ships no job-launch UI or route of its own — you inject the service from your own module or automation code. A single admin form (`/admin/config/services/awx`, gated by `administer site configuration`) stores the AWX base URL, API token, connect/response timeouts, and TLS-verify flag in the `awx.settings` config object; the token can also be supplied via a `settings.php` config override. Launch a template by its unique name (the numeric ID is resolved automatically via a `?name=` lookup) or by numeric ID when you already have it. Supports Drupal 10 and 11.

---

- Trigger an Ansible job template from a custom module by injecting `awx.awx_client`.
- Launch a job template by its unique name without hardcoding instance-specific numeric IDs.
- Launch a job template by numeric ID when it is already known.
- Pass runtime parameters to a playbook as AWX `extra_vars`.
- Provision a customer environment when a node or order is created.
- Kick off a backup playbook on a scheduled cron or admin action.
- Restart or redeploy services in response to a content/workflow event.
- Deploy configuration to infrastructure from a Drupal admin trigger.
- Run ad-hoc playbooks as part of an editorial or approval workflow.
- Bridge Drupal ECA / Rules / queue workers to Ansible automation.
- Resolve a job template's numeric ID from its name via `getJobTemplateIdByName()`.
- Detect and handle "template not found" and "ambiguous name" resolution errors cleanly.
- Link operators straight to the running job in the AWX web UI with `getJobUrl()`.
- Log every launch attempt (success or failure) to the `awx` logger channel.
- Handle transport/HTTP errors via the typed `AwxClient::REQUEST_FAILURE_MODES` return values.
- Configure the AWX base URL, bearer token, and timeouts through one admin settings form.
- Store the API token via a `settings.php` config override instead of the database.
- Enable or disable TLS certificate verification per site (on by default).
- Tune connection and response timeouts to match slow AWX instances.
- Point Drupal at either upstream AWX or Red Hat Ansible Automation Platform / Tower.
- Centralize AWX credentials and endpoint for many consuming modules in one place.
- Treat job launching as a privileged operation restricted to trusted server-side code.
