<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce SQL Sanitize extends Drush's `sql:sanitize` command to scrub Commerce-specific data — order email and IP, customer addresses, tax numbers, carts, logs, and stored payment methods — when a production database is copied to a development environment.

---

Copying production to a laptop is how most Drupal development is done, and it is also how customer data ends up in unmonitored environments and in database dumps attached to issue trackers; `drush sql:sanitize` exists for this but core only knows about user emails and passwords, a small fraction of what a Commerce site stores. Install with `composer require drupal/commerce_sql_sanitize` and enable it (`drush en commerce_sql_sanitize`); it has **no configuration and no UI**, registering instead as a set of Drush `sql:sanitize` plugins. From then on, running `drush sql:sanitize` — or, more usefully, `drush sql:sync @prod @self --sanitize` when pulling production down — additionally, and by default: replaces `commerce_order.mail` with `sanitized@local.test` and `ip_address` with `127.0.0.1`; deletes all cart orders (draft orders that are not carts are kept); overwrites the address columns on customer `profile` entities with placeholder values (`[Sanitized]`, and a generic `US`/`DC`/`20500` location); truncates all Commerce Log and stored payment-method tables; and truncates the tax-number field on profiles. Each operation can be switched off individually by passing its option with the value `no` or `0`, for example `drush sql:sanitize --sanitize-commerce-log=no --sanitize-commerce-payment-method=no`, and `--sanitize-address-fields=address,field_billing` restricts address scrubbing to named fields. Because it is plain Drush integration with no stored configuration, the same behaviour is reproducible on every environment and scriptable into a team's standard down-sync command, and each operation reports what it did (or was skipped) in the command output.

---

- Sanitize Commerce data before local development.
- Remove customer email and IP from orders in a database copy.
- Replace customer addresses on profiles with placeholder values.
- Delete stored payment methods so live gateway tokens do not reach a dev environment.
- Delete all carts before working on a copied database.
- Delete tax numbers from customer profiles.
- Clear the Commerce Log / order activity stream from a dump.
- Wire sanitization into a `drush sql:sync --sanitize` down-sync workflow.
- Make sanitization the default so an unsanitized copy takes a deliberate act.
- Reduce personal-data exposure on developer machines.
- Support a GDPR / data-protection obligation for database copies.
- Prepare a sanitized database for an external contractor.
- Sanitize a dump before attaching it to an issue tracker.
- Reduce risk when refreshing a staging environment from production.
- Keep specific address fields intact while sanitizing others.
- Disable individual scrub operations for a particular test scenario.
- Protect customer data flowing into CI pipelines.
- Support a compliance or security-review requirement for non-production data.
- Give QA realistic-looking but non-personal order and address data.
- Establish a repeatable, scriptable sanitization step for the team.
