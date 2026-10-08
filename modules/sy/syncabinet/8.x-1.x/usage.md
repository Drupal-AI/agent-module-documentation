<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynCabinet provides profile and auth in the SynapseF package.

---

SynCabinet is a **vendor-specific (SynapseF) "profile and auth" module** — part of a supplier's suite (it
depends on `syncart`), handling user profile/account and authentication flows in that vendor's context.

Use it only within the SynapseF/syncart stack it belongs to. Because it handles **authentication and profiles**
and is vendor-specific with minimal public documentation, **review its actual auth/registration/session
behaviour in context** before relying on it (auth code warrants scrutiny — verify credential handling, session
management and any account-creation paths). Consult the vendor's documentation for configuration. It provides no
documented general-purpose access-control contract here.

---

- Provide vendor profile + auth.
- Belong to the syncart suite.
- Handle accounts/authentication.
- Depend on syncart.
- Serve the vendor stack.
- Be vendor-specific.
- REVIEW auth/registration/session behaviour in context.
- Verify credential/session handling.
- Scrutinize account-creation paths.
- Consult vendor documentation.
- Have no documented general access contract.
- Handle vendor profiles.
- Manage auth.
- Configure per vendor.
- Handle the suite.
- Review auth.
- Handle profiles.
- Manage accounts.
- Verify auth behaviour.
- Provide vendor profile/auth.
