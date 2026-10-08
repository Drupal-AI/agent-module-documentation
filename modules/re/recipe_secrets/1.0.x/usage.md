<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recipe Secrets strips secrets out of recipe config so they aren't committed.

---

Recipe Secrets helps keep secrets out of Drupal recipes — it removes private/sensitive information from the configuration files a recipe ships, so a recipe (a reusable package of config) can be shared/committed without leaking API keys, passwords, or other secrets that happened to be in config.

It's a security/developer tool that supports the recipe workflow. It complements proper secret handling (env vars / Key module) rather than replacing it. Supports Drupal 10 and 11.

---

- Remove secrets from recipe config.
- Strip private information.
- Keep recipes shareable.
- Avoid leaking API keys/passwords.
- Support the recipe workflow.
- Complement env/Key secret handling.
- Act as a security/developer tool.
- Support Drupal 10 and 11.
- Prevent secret leakage.
- Sanitize config files.
- Protect sensitive data.
- Support config packaging.
- Aid recipe authors
- Clean config for sharing
- Handle secrets safely.
- Support recipes.
- Redact config.
- Improve config hygiene
