# Configurable Anonymizer OIDC — manual setup guide

**Configurable Anonymizer OIDC** (`configurable_anonymizer_oidc`) is an add-on that
connects the [Configurable Anonymizer](https://www.drupal.org/project/configurable_anonymizer)
module with the [OIDC](https://www.drupal.org/project/oidc) (OpenID Connect) module.
Its single job is to let you **exclude certain users from anonymization based on
their OIDC realm** — so when you run the anonymizer (for example to scrub a database
copy for a lower environment or for GDPR reasons), users who belong to a configured
OpenID Connect realm are left untouched.

The typical use is a mixed set of accounts where some users authenticate through an
OIDC provider and you have a deliberate, compliant reason to keep their real data on
non-production environments — while everyone else's data is anonymized as usual. When
you run `drush anonymizer:run`, users in the excluded realm(s) are skipped.

This is a privacy and data-handling module, and the implication of what it does needs
to be understood clearly, because it is the reverse of the parent module's purpose:

- **Excluding a realm means those users' real data is retained** while other users'
  data is scrubbed. On a non-production copy that means real personal data stays
  present for the excluded users.
- **Only exclude realms where retaining real data is genuinely intended and
  compliant** with your privacy obligations. This is a data-protection decision, not a
  convenience toggle.
- **Review the exclusion against your privacy requirements** whenever you set or
  change it, and confirm the outcome after a run.

It depends on both Configurable Anonymizer and the OIDC module, and provides its own
permission; it has no access-control role beyond that permission. This is the 1.0.0
release for core 10 or 11, and it is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its dependencies.

The module adds its own settings page at **Configuration → Development → Anonymizer →
Configurable Anonymizer OIDC** (`/admin/config/development/anonymizer/oidc`, also shown
as a tab under the parent Configurable Anonymizer settings). It offers a single
**Disabled realms** checkbox list of the OIDC realms configured on your site — see
"How to use it" below, and read the parent module's guide for the core field setup.

## How to use it

1. Make sure Configurable Anonymizer and the OIDC module are installed and working,
   then enable this add-on (see [Installation](installation/index.md)).
2. Go to `/admin/config/development/anonymizer/oidc` and tick the OIDC realm(s) under
   **Disabled realms** whose users should be **excluded** from anonymization.
   Users in those realms will be skipped when the anonymizer runs.
3. Run the anonymizer as usual with `drush anonymizer:run`. Users in the excluded
   realms keep their real data; all other configured PII is anonymized.
4. Because excluding a realm retains real personal data, only exclude realms where
   that retention is intended and compliant, and review the choice against your
   privacy requirements before and after each run.
