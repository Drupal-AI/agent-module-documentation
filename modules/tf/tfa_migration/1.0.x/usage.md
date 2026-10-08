<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TFA Migration migrates TFAs of users.

---

TFA Migration **migrates users' Two-Factor Authentication (TFA) settings/secrets** — moving TFA
configuration (e.g. TOTP seeds) into Drupal's TFA module during a migration, so users don't have to re-enrol. It
depends on the TFA, core Migrate and Encrypt modules, in the Migration package.

Use it when migrating TFA data into a new Drupal site. It is a developer/migration tool handling
**highly sensitive** data: TFA secrets (TOTP seeds) are **credential material** — they must be handled via the
**Encrypt** module (encrypted at rest), never logged or exported in plaintext, and the migration run as a
trusted operator on a secure channel. A leaked TOTP seed defeats the user's second factor, so treat these
migrations with the same care as passwords. It has no access-control role. Configure and run the TFA
migration.

---

- Migrate users' TFA settings/secrets.
- Move TOTP seeds into TFA.
- Avoid re-enrolment.
- Depend on TFA/Migrate/Encrypt.
- Serve migration.
- Handle TFA config.
- TREAT TFA secrets as credential material (highly sensitive).
- Handle them via Encrypt (encrypted at rest).
- Never log/export seeds in plaintext.
- Run as a trusted operator on a secure channel.
- Have no access-control role.
- Configure and run the migration.
- Handle TFA migration.
- Migrate TFA.
- Configure the migration.
- Move secrets.
- Handle the migration.
- Import TFA.
- Protect the seeds.
- Provide TFA migration.
