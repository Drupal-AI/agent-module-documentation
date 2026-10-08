# Field Validation — manual setup guide

**Field Validation** (`field_validation`) lets site builders attach reusable
validation rules to any entity field through the admin UI — no code required. You
can enforce formats, ranges, lengths, uniqueness, and dozens of other checks that
fire whenever the entity is validated: on the node/user/term form, and again when
the entity is saved through the API or a migration. When a rule is violated, the
save is blocked and your custom error message is shown.

The module organizes rules into **rule sets**. A rule set is a small piece of
configuration scoped to one entity type and bundle (for example *node / article*),
and it holds an ordered list of **rules**. Each rule is bound to a specific field
and column, carries its own settings and error message, and can optionally be
limited to certain user roles or made conditional on another field's value. Rule
sets are pure config, so they export with `drush config:export` and deploy
cleanly between environments.

The installed **3.0.x branch is a beta rewrite**. Most of its shipped rules are
thin wrappers around Drupal/Symfony validation *Constraints* (Length, Regex,
Range, Email, Unique, Count, Expression, IBAN, ISBN, country/locale, card scheme,
and many more) — their plugin ids all end in `_constraint_rule`. The older,
hand-written rules from the 8.x/1.x era (pattern, phone, words blocklist,
plain-text, item-count, and so on) now live in the separate
**field_validation_legacy** submodule for sites upgrading from the old line.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether you need the legacy submodule.
2. [Configuration](configuration/index.md) — create rule sets, add rules field by
   field, and apply roles and conditions.

## Where it lives in the admin menu

Field Validation adds an admin section at **Structure → Field validation rule
sets** (`/admin/structure/field_validation`), gated by the *Administer field
validation rule set* permission. From there you create rule sets and add rules to
them.

## How to use it

At a high level: create a rule set for the entity type and bundle you want to
protect, then add one or more rules to it, each targeting a field and choosing a
validation type. The next section walks through the form field by field.
