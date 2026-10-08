<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
NVA provides integration with a Nasjonal service.

---

NVA provides an **integration with a Nasjonal (Norwegian national) service/register** — connecting Drupal to
that external national data service. It depends on the Key module, in the Custom package.

Use it to integrate with the Nasjonal service. It is an integration feature and it handles secrets **correctly**:
it depends on the **Key** module, so API **credentials are stored as a Key** (env/secret provider), not plain
config. Data-handling: it exchanges data with the **external national service** (egress — over HTTPS; handle any
personal data per privacy obligations). It has no access-control role. Configure the service credentials (via
Key).

---

- Integrate with a Nasjonal service.
- Connect to a national register.
- Exchange data with the service.
- Depend on the Key module.
- Serve integration.
- Use external national data.
- Store credentials as a Key (correct).
- Use HTTPS (egress).
- Handle personal data per privacy.
- Have no access-control role.
- Configure the credentials via Key.
- Handle NVA integration.
- Exchange data.
- Configure the client.
- Connect the service.
- Handle the integration.
- Integrate nationally.
- Fetch data.
- Secure the credentials (Key).
- Provide NVA integration.
