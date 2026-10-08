<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# International Personal Documentation Validator (ipd_validator) — agent index

**Backend plugin API that validates national identity documents (DNI, CUIT, CPF, PAN, NIN, ...) per country; no UI.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Service:** `plugin.manager.ipd_validator` (`ValidatorPluginManager`) — discovers `@Validator` plugins.
- **Plugin base/interface:** `ValidatorPluginBase`, `ValidatorInterface` (`isValid`, `format`, `countryCode`, `country`, `isActive`).
- **Plugins:** ~30 country validators under `src/Plugin/Validator/`.
- **Routes/permissions:** none. **Config:** none.
- **Security:** pure local validation logic; no routes, no external calls, no persistence, no user input sinks. No security findings.

See [extend/validators.md](extend/validators.md)
