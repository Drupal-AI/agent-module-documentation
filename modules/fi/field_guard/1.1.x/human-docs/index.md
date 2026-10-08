# Field Guard — manual setup guide

**Field Guard** (`field_guard`) is a **config‑driven, fail‑closed per‑field
access control** module. When you guard a field, Field Guard denies access to it
with a verdict that **nothing can override** — not a permission, not an
administrator role, not even user 1. It only ever denies; it never grants. And
it ships with an empty configuration, so installing it changes nothing until you
deliberately guard a field.

Field Guard exists to close two gaps that are easy to get wrong by hand. First,
definition‑level access checks (the ones JSON:API and Views make when they ask
"may this field be filtered or sorted on at all?") can fail *open* — leaving a
guarded value probeable through an exposed filter or sort even when it's never
rendered. Field Guard denies those too. Second, a hand‑rolled deny that tests
`hasPermission()` silently exempts your administrators and user 1, because they
pass every permission check by definition. Field Guard instead walks each
account's roles, skips the admin roles, and requires the access to be **named
explicitly in a role's own configuration** — so granting access is a visible,
reviewable line in a config diff rather than something inherited by being an
admin.

Because a guarded field is enforced through Drupal's authoritative field‑access
system, the protection applies everywhere: entity forms, entity view, and
REST/JSON:API. Note two deliberate consequences. **Guarded fields become
unfilterable and unsortable for everyone**, including permission holders, because
there's no entity in scope at filter time to tell a legitimate query from a
probe. And **guarded fields are hidden even from administrators and user 1** — so
configure them carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Security coverage note.** At the documented version Field Guard is **not
> covered by Drupal's security advisory policy**. Review it yourself before
> relying on it to protect sensitive data in production.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** for this module. Field Guard is configured
entirely through a configuration file (there is no admin UI page), described in
"How to configure it" below — this keeps the access map diffable, reviewable, and
re‑applied on every `drush config:import`.

## Where it lives in the admin menu

Field Guard adds **no admin page**. Its behaviour is driven by the
`field_guard.settings` configuration only. You edit that configuration in code
(your site's config sync directory) and import it, rather than clicking through
a form.

## How to configure it

Field Guard reads a nested map from its configuration: **entity type → bundle →
field name → operation → the permission required for that operation**. For
example:

```yaml
protected:
  profile:
    compliance_record:
      field_evidence_date:
        view: 'view compliance evidence'
        edit: 'record compliance evidence'
```

A few rules follow from the design, all documented by the module:

- **`view` and `edit` are the only operations** Drupal's field‑access API passes,
  so those are the only ones Field Guard acts on. Anything else is treated as
  unprotected — a future core operation cannot accidentally lock a site out of
  its own data.
- **An omitted operation is not protected.** Omission is how you leave a field
  open for a given operation.
- **An empty permission string is treated as unset, not as "a permission nobody
  holds."** A total, invisible denial would be very hard to diagnose, so the
  module refuses to create one that way.
- Because it's configuration rather than code, the map is **reverted to the
  repository on every deploy** that runs `drush config:import` — a live edit
  that widens access does not survive a release.

### What Field Guard does *not* cover

These are properties of Drupal itself, true of every field‑access approach, not
gaps specific to this module:

- **Programmatic reads.** Loading an entity and reading the value in code, or via
  Drush, never calls the field‑access system.
- **Views filters, sorts, and arguments on *unguarded* fields** — core permits
  those unconditionally.

Guard the specific fields that must be locked down, keep the map under version
control, and treat each granted permission line as the reviewable decision it is.
