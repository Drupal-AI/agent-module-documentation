<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Install Core provisions a new Drupal site from a Webform submission and registers it with the dashboard.

---

This submodule of Drupal Remote Dashboard turns a Webform into a site-provisioning front end. Its Webform handler "DRD Core Installer" (`drd_core`) runs after a submission completes and creates a `drd_core` entity (with its Drupal root) and a `drd_domain` entity for the new site, seeding the domain's `shared_secret` authentication and `OpenSsl` transport encryption from the handler configuration. It also assembles the JSON "domain secrets" payload (authorised uuid + auth/crypt settings) that the new site's DRD Agent consumes to trust this dashboard, and stores it back into a submission field. A companion Webform element "DRD Domain" collects the target site URL, and an event subscriber listens for GitLab API "project created" events to record the new repository's SSH URL on the core. It is aimed at agencies that spin up many sites from an intake form and want them wired into DRD automatically. Requires the DRD base module, Webform and GitLab API.

---

- Provision a new managed site from a public/staff Webform submission.
- Create the `drd_core` (with Drupal root) and `drd_domain` entities automatically on submission.
- Map submission fields to user id, host id, core id, site name, site URL and a domain-secrets field.
- Seed the new domain's `shared_secret` authentication from the handler configuration.
- Seed the new domain's `OpenSsl` cipher and password for encrypted dashboard-to-agent traffic.
- Set custom HTTP headers (YAML) on the new domain for the agent connection.
- Generate the "domain secrets" JSON payload the target site's DRD Agent needs to authorise the dashboard.
- Collect a validated site URL with the dedicated "DRD Domain" Webform element.
- Record a newly created GitLab repository (SSH URL) against the DRD core via the GitLab API event.
- Standardise onboarding of many sites into DRD with one repeatable intake form.
- Combine with `drd_install_core`'s shipped example webform (`add_new_drupal_site`) as a starting point.
- Let downstream automation (webform emails, GitLab CI) pick up the created core/domain and secrets.
