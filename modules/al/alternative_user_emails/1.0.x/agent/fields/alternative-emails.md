<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `alternative_user_emails` base field + hooks

## Install & enable

```bash
composer require drupal/alternative_user_emails
drush en alternative_user_emails -y
```

Dependencies: core **`user`** and **`field`** only. No sub-modules, no permissions, no Drush
commands, no config objects or schema, no settings form. Enabling the module is the entire setup —
the base field appears on every user account immediately.

## The base field

Defined in `alternative_user_emails_entity_base_field_info()`
(`hook_entity_base_field_info`) in `alternative_user_emails.module`. It is added **only** to the
`user` entity type:

- Machine name: `alternative_user_emails`, type **`email`**, label *"Alternative emails"*.
- **Cardinality UNLIMITED** — any number of addresses per account.
- Form display and view display both default to region **`hidden`** — so out of the box users do
  **not** see or edit it on the account form, and it is not rendered on the profile. Both are
  `setDisplayConfigurable(TRUE)`, so you can move it to a visible region on *Manage form display* /
  *Manage display*.
- Carries constraint **`AlternativeUserEmailsUnique`** (see below).

Because it is a base field (not a configured field), it exists on all bundles of `user` with no
field-config export.

### Reading / writing it in code

```php
// Read all alternative addresses.
$alts = array_column($user->get('alternative_user_emails')->getValue(), 'value');

// Add one (uniqueness is enforced on save/validate).
$user->get('alternative_user_emails')->appendItem('old@example.com');
$user->save();
```

To display the field read-only on the account form, the README recommends the contrib
**Read-only Field Widget** (`readonly_field_widget`) module.

## Hook 1 — auto-store the previous primary

`alternative_user_emails_user_presave()` (`hook_user_presave`): on an existing user
(`$user->original` set) whose `mail` has changed, it:

1. appends the **old** primary (`$user->original->getEmail()`) to `alternative_user_emails` if not
   already present, and
2. removes the **new** primary from the alternatives if it was listed there.

So changing an account's email keeps the history and never leaves the new primary duplicated in the
alternatives. New users and saves that don't change `mail` are untouched.

## Hook 2 — expand `mail` queries to alternatives

`alternative_user_emails_entity_query_user_alter()` (`hook_entity_query_user_alter`) walks the
query's condition tree (recursively, via `_alternative_user_emails_expand_mail_condition()`) and
rewrites every condition on the **`mail`** field into a group matching **either** field:

- Normal operators (`=`, `IN`, `CONTAINS`, …) → an **OR** group
  (`mail <op> value` OR `alternative_user_emails <op> value`).
- Negating operators **`<>`** and **`NOT IN`** → an **AND** group (must not match *either* field).

The original operator, value and langcode are carried across to the alternative-email condition.
Net effect: any code that resolves a user from an email — e.g. `user_load_by_mail()`, the People
admin filter, "login/reset by email" flows, custom entity queries — will also match on an
alternative address. (Verified by `tests/src/Kernel/AlternativeUserEmailsQueryTest.php`.)

Implementation note: the alter reaches the query's condition group through
`ReflectionClass`/`getProperty('condition')` because the entity query exposes no public accessor.
This is intentional but tied to the core query internals.

## Hook 3 + the validator — site-wide email uniqueness

`hook_validation_constraint_alter` replaces core's **`UserMailUnique`** constraint class with
`AlternativeUserEmailsUnique` (core's `UniqueFieldValueValidator` can only look at one field; this
one must span two).

`AlternativeUserEmailsUnique` (constraint, id `AlternativeUserEmailsUnique`, type `string`, message
`notUnique` = *"The email address %value is already associated with another user account."*) is
validated by `AlternativeUserEmailsValidator`:

- Only processes the `alternative_user_emails` and `mail` fields (`VALID_FIELDS`); anything else, or
  a non-user entity, throws `AlternativeEmailsException`.
- For each email in the field, runs a user entity query (`entity_type.manager` → user storage) that
  **excludes the current user** (`condition(id, uid, '<>')`) and matches an OR group on `mail` OR
  `alternative_user_emails` equal to that value; if any other user is found the value is rejected.
- The query uses `accessCheck(FALSE)` — correct here, since uniqueness must be evaluated against all
  accounts regardless of the acting user's view access.

Result: no email address — primary or alternative — can be held by two accounts, and an alternative
cannot collide with anyone else's primary.

## Operating notes

- The `%value` in the violation message is rendered through Drupal's placeholder escaping (safe).
- Uniqueness is enforced at validation time, so always **validate** entities you build
  programmatically (`$user->validate()`), not just `save()`, if you want the constraint to fire.
- There is no verification workflow bundled: whether an alternative address is confirmed as
  belonging to the user is left to your account-form access model / any confirmation module you add.
  By default the field is form-hidden, so only actors with user-edit access set alternatives.
