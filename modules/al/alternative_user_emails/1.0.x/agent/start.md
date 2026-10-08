<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alternative user email addresses (alternative_user_emails) — agent index

Adds a single unlimited-cardinality **base field `alternative_user_emails`** to the core **user**
entity so an account can hold extra email addresses beyond its primary `mail`. Depends only on core
**`user`** and **`field`**. Core `^10.3 || ^11`, PHP `^8.3`. License GPL-2.0-or-later. Version 1.0.1.

**No config, no UI, no permission, no route, no service, no Drush, no config schema, no submodules.**
Everything is one base field + three hooks + one validation-constraint plugin. All logic lives in
`alternative_user_emails.module` plus `src/Plugin/Validation/Constraint/`.

- **The field, the three hooks (auto-append old primary, query expansion, constraint override), the
  uniqueness validator, and how to operate it** → [fields/alternative-emails.md](fields/alternative-emails.md)

## What it actually is (from source)

- `hook_entity_base_field_info` (`alternative_user_emails_entity_base_field_info`) — defines the
  `alternative_user_emails` email base field on `user`, cardinality UNLIMITED, form+view display
  **hidden** by default, with constraint `AlternativeUserEmailsUnique`.
- `hook_user_presave` (`alternative_user_emails_user_presave`) — when `mail` changes, moves the
  **old** primary into the alternatives and drops the new primary from them.
- `hook_entity_query_user_alter` (`alternative_user_emails_entity_query_user_alter`) — rewrites any
  condition on the `mail` field into `mail OR alternative_user_emails` (uses `andConditionGroup` for
  `<>`/`NOT IN`). So user lookups by email also match alternatives.
- `hook_validation_constraint_alter` — replaces core `UserMailUnique` with `AlternativeUserEmailsUnique`.
- Plugin `AlternativeUserEmailsUnique` (constraint, id `AlternativeUserEmailsUnique`) +
  `AlternativeUserEmailsValidator` — enforce that each primary/alternative email is unique across all
  users (queries `mail` and `alternative_user_emails`, excludes the current user).
- `Exception\AlternativeEmailsException` — thrown if the validator is handed a non-user entity or a
  non-mail field.

## Operate it

Install with `composer require drupal/alternative_user_emails` then `drush en alternative_user_emails`.
The field is form-hidden out of the box; expose or read it via the standard field display or by
`$user->get('alternative_user_emails')`. See the field doc for the widget recommendation and code
examples.
