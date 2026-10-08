<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configurable Anonymizer lets you configure which sensitive fields to anonymize and scrubs them after a database sync, using pluggable field anonymizer plugins and a Drush command.

---

Configurable Anonymizer lets a site define which sensitive fields hold PII and anonymize them after
a database sync — the classic need when copying a production database to staging/development, where
real user data must be scrubbed. It uses pluggable field-anonymizer plugins (a default anonymizer, a
UUID anonymizer, and custom plugins via an attribute-based plugin type), a configuration form to map
fields to anonymizers, and a Drush command to run the anonymization. It also alters user entity queries
via a tagged-query hook.

Use it as part of a data-refresh pipeline: after pulling a prod DB down, run the anonymizer to replace
configured PII fields before the environment is used. The critical operational rule is sequencing —
anonymization must run before anyone accesses the non-prod copy, and it must never run against
production. It is a developer/privacy tool with a Drush command; treat its configuration (which fields
are PII) as part of your data-protection process.

---

- Anonymize sensitive fields after a DB sync.
- Scrub PII when copying prod to staging.
- Configure which fields to anonymize.
- Use pluggable field-anonymizer plugins.
- Run anonymization via a Drush command.
- Use the default or UUID anonymizer.
- Add custom anonymizer plugins.
- Map fields to anonymizers via a form.
- Run before the non-prod copy is used.
- Never run against production.
- Alter user queries via a tagged hook.
- Replace real user data in dev/staging.
- Support a data-refresh pipeline.
- Treat PII config as data-protection process.
- Sequence anonymization correctly.
- Protect user privacy in non-prod.
- Scrub emails/names/PII.
- Provide a Drush anonymize command.
- Define sensitive fields.
- Serve as a developer/privacy tool.
