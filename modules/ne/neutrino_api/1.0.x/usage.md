<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NeutrinoAPI provides a Drupal service wrapper around the Neutrino data service.

---

NeutrinoAPI provides a **Drupal service wrapper around NeutrinoAPI** — a data/analysis service — with
submodules for **email validation** (`neutrino_api_email_validator`), **IP info** (`neutrino_api_ip_info`) and
**user-agent parsing** (`neutrino_api_ua`), so modules can call those NeutrinoAPI features. It is in the
Developer package.

Use it as the integration layer for NeutrinoAPI features. It is a developer/integration feature. Security/data
handling: it calls the **NeutrinoAPI over the network** with **API credentials** — store them as **secrets**
(env/Key), use HTTPS — and the data you look up (**emails, IP addresses, user agents**) is **sent to
NeutrinoAPI** (a third-party data-egress/privacy consideration — confirm it's acceptable and disclosed). It has
no access-control role. Configure the NeutrinoAPI credentials.

---

- Wrap the NeutrinoAPI service.
- Provide email/IP/UA lookups.
- Offer submodules per feature.
- Call NeutrinoAPI over the network.
- Use API credentials.
- Serve developer integrations.
- Store credentials as secrets.
- Use HTTPS.
- SEND emails/IPs/UAs to NeutrinoAPI (egress/privacy).
- Confirm the egress is acceptable/disclosed.
- Have no access-control role.
- Configure the credentials.
- Handle NeutrinoAPI.
- Call the API.
- Configure the service.
- Look up data.
- Handle the integration.
- Query NeutrinoAPI.
- Secure the credentials.
- Provide NeutrinoAPI access.
