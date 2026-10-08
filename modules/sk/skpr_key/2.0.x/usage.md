<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Skpr Key provides a key provider for Skpr config.

---

Skpr Key provides a **Key-module provider that reads secrets from Skpr configuration** — so Drupal's Key
entities can source their values from the Skpr hosting platform's secret store rather than from Drupal config,
keeping secrets out of the database/config. It depends on the Key module, in the Security package.

Use it to source API keys/secrets from Skpr. This is a **security-positive** secret-handling integration: it
follows best practice by keeping credentials in the platform's secret store and exposing them via the Key
abstraction (not in exported config/VCS). Ensure the Skpr secrets themselves are managed with least privilege.
It has no access-control role — it is a credential source. Configure Key entities to use the Skpr provider.

---

- Provide a Skpr Key provider.
- Read secrets from Skpr config.
- Keep secrets out of DB/config.
- Depend on the Key module.
- BE security-positive secret handling.
- Source values via the Key abstraction.
- Follow secret best practice.
- Not put secrets in exported config/VCS.
- Manage Skpr secrets with least privilege.
- Have no access-control role (credential source).
- Configure Key entities to use it.
- Handle Skpr keys.
- Source secrets.
- Configure the provider.
- Read secrets.
- Handle the integration.
- Provide keys.
- Store secrets safely.
- Set the provider.
- Provide a Skpr key provider.
