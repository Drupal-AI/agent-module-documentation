<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login.gov OpenID Connect adds Login.gov as a provider for the `openid_connect` module, so a US federal site can authenticate members of the public through the government's shared identity service.

---

Login.gov is the United States government's single sign-on for the public: one account, with the identity proofing and multi-factor authentication done once and reused across agencies. For a federal site that means it does not run its own registration, does not store its own passwords, and inherits an assurance level it could not economically build — which is why agencies are directed toward it rather than choosing it. This module supplies the provider plugin, requiring `openid_connect >= 3.0` and, notably, **`key_asymmetric`**: Login.gov requires **private-key JWT** client authentication rather than a shared client secret, so the site signs its token requests with a private key whose public half is registered with Login.gov. That dependency is the tell that the integration is done properly, and it changes the operational work — there is a key pair to generate, register, protect and eventually rotate, and the private key belongs in a Key entity backed by an environment variable or a KMS, never in configuration. Version **2.0.0** on core `^10 || ^11`. Three things to plan. **IAL and AAL levels** — the identity-proofing and authentication assurance the site requests — are a policy decision with real consequences for who can complete registration, and they belong to the programme rather than to the Drupal team. **Account linking** needs deciding: what happens when a Login.gov identity arrives whose email matches an existing local account is a security question, not a convenience one. And **the sandbox and production environments are separate registrations**, so a working integration in one proves nothing about the other.

---

- Authenticate the public through Login.gov.
- Meet a federal identity requirement.
- Remove password storage from an agency site.
- Inherit government identity proofing.
- Support multi-factor authentication centrally.
- Add Login.gov to an OpenID Connect setup.
- Support a benefits application site.
- Authenticate citizens for a service.
- Meet an assurance level requirement.
- Avoid running a registration system.
- Support a public-facing federal service.
- Use private-key JWT authentication.
- Link Login.gov identities to accounts.
- Support a sandbox-to-production rollout.
- Reduce account-support burden.
- Meet an OMB identity directive.
- Authenticate applicants for a programme.
- Support a shared federal login.
