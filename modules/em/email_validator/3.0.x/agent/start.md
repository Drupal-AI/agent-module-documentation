<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EVA - Email Validator — agent index

**Validates email addresses via the external e-va.io service** and rejects addresses whose state is not allowed. Version **3.0.0** (`3.0.x`). Core `^8.8 || ^9 || ^10 || ^11`. Requires `guzzlehttp/guzzle`.

Overrides core's `email.validator` service with its `EVA` subclass and adds a validator to forms you list. **Sends submitted emails to a third party** (data-egress/privacy — confirm acceptable + disclosed); **Access Key** sent in an `api-key` header over HTTPS (default TLS verification on). No access role beyond its config permission.

- **Configure** the service, target forms, allowed states, logging and fail policy → [configure/email_validator.md](configure/email_validator.md)
- **Call it programmatically** (the `email_validator.eva` service, service override) → [api/email_validator.md](api/email_validator.md)
- **Permission** that gates the config form → [permissions/email_validator.md](permissions/email_validator.md)
