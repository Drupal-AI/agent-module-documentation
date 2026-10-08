# Advanced Sanitize — manual setup guide

**Advanced Sanitize** (`advanced_sanitize`) is a **developer tool** that extends
Drush's built-in `sql:sanitize` command. When you copy a production database down
to a development or staging environment, `sql:sanitize` scrubs some personal data
(such as user emails and passwords) so real people's details do not end up in a
less-protected environment. Core's sanitize only covers a handful of standard
fields, though — anything custom is left untouched.

This module adds plugins that extend that scrubbing to **additional fields**:
extra emails, names, phone numbers, or any custom fields on your site that hold
personally identifiable information (PII). It provides Drush commands and its own
permission, and lives in the Development package.

Using it is a **security- and privacy-positive** practice: sanitising a database
dump removes real personal data before it lands somewhere with weaker
protections, reducing the risk of a PII leak from a dev copy. The important caveat
is completeness — a sanitize is only as good as its coverage. If a field holding
PII is not included in your sanitize plugins, that field still leaks. Review your
coverage so that *every* field containing personal data is scrubbed.

This guide is written for a **human** working at the command line. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Advanced Sanitize has no admin UI. It works entirely through Drush at
the command line and does not add configuration pages. It does add a permission,
which you can review under **People → Permissions**
(`/admin/people/permissions`), but it plays no runtime access-control role.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)) on
   the environment where you run the database sanitize — typically as part of your
   deployment/CI process that refreshes a dev or staging database.
2. Run Drush's sanitize command as usual:

   ```bash
   drush sql:sanitize
   ```

   With Advanced Sanitize enabled, its plugins run alongside core's, scrubbing the
   extra PII fields they cover in addition to the core defaults.
3. **Review coverage.** Confirm the plugins scrub every field on your site that
   contains personal data — an incomplete sanitize still leaks whatever fields it
   misses. This is the one thing to get right before trusting a sanitized dump in
   a less-protected environment.
