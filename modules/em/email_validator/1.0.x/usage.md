<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email Validator (EVA) integrates to validate email addresses on your platform.

---

Email Validator (EVA) **validates email addresses** — checking deliverability/validity via an external
validation service — to reduce fake or undeliverable addresses at registration/form submission. It provides
its own permissions, in the Mail package.

Use it to validate emails against a service. It is a form-validation/anti-abuse feature (reduces fake signups).
Security/data handling: it **sends email addresses to an external validation service** (a data-egress/privacy
consideration — you're sharing users' emails with a third party; confirm this is acceptable and disclosed), and
it authenticates with an **API key** — store it as a secret (env/Key), over HTTPS. It has no access-control
role beyond its permission. Configure the validation service and key.

---

- Validate email addresses.
- Check deliverability via a service.
- Reduce fake/undeliverable emails.
- Provide its own permissions.
- Validate at registration/forms.
- Serve anti-abuse.
- SEND emails to an external service (egress/privacy).
- Confirm the egress is acceptable/disclosed.
- Store the API key as a secret.
- Use HTTPS.
- Have no access-control role beyond permission.
- Configure the service and key.
- Handle email validation.
- Validate emails.
- Configure validation.
- Check emails.
- Handle the integration.
- Validate addresses.
- Secure the key.
- Provide email validation.
