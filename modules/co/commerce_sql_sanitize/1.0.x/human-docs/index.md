# Commerce SQL Sanitize — manual setup guide

**Commerce SQL Sanitize** (`commerce_sql_sanitize`) extends Drush's built-in
`sql:sanitize` command so it also scrubs **Commerce-specific** personal data when you copy
a production database down to a development or staging environment. Core's sanitizer only
knows about user email addresses and passwords — but on a Commerce site that is a small
fraction of the personal data present. Orders carry billing and shipping addresses,
telephone numbers, and the customer's name and email again; customer profiles hold the
same; payment records hold partial card details, gateway references, and transaction IDs.
This module fills that gap.

It has **no user interface and no configuration** — it simply hooks into the Drush
`sql:sanitize` command. When you run `drush sql:sanitize` (directly or as part of
`drush sql:sync`), it additionally sanitizes order email and IP addresses, sanitizes
addresses (replacing most values with `[Sanitized]`), deletes all Commerce logs (the order
activity stream), deletes all carts (though not all draft orders), deletes all tax numbers
from customer profiles, and deletes all stored payment methods. Command-line options let
you disable any individual one of these operations.

It works with Drupal 9.1, 10, and 11 and has no module dependencies of its own — you only
need Drush and a Commerce site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** — the module works entirely through the Drush
`sql:sanitize` command once enabled.

## How to use it

Once the module is enabled, run the standard Drush command wherever you want a sanitized
copy of the database:

```bash
drush sql:sanitize
```

Or, most usefully, let it run automatically as part of pulling production down to a
development environment:

```bash
drush sql:sync @prod @self --sanitize
```

The extra Commerce operations run alongside core's own sanitization. Each of the module's
operations can be switched off with a command-line option if you need to keep a particular
data set intact for testing.

## Important data-safety notes

- **Enforce sanitization; don't rely on remembering it.** The real value comes from
  configuring your `sql:sync` workflow to sanitize **by default**, so that producing an
  *unsanitized* copy takes a deliberate act rather than the reverse. A one-off command that
  someone forgets to add is not protection.
- **Verify coverage against your actual data model.** A generic sanitizer cannot see your
  custom order fields, a customer-notes field, or a third-party gateway's stored API
  response — and those are exactly where surprises hide. Check what personal data your site
  stores and confirm this module (or your own additions) covers it.
- **Sanitization is not anonymization.** Scrambled data can often be re-identified from the
  order amounts, timestamps, and any addresses left intact. A sanitized copy is still a copy
  of real customer data and deserves care — it is not a public artefact you can attach to an
  issue or hand to a contractor without thought.
