# Author Field — manual setup guide

**Author Field** (`author_field`) provides field types for storing author
information that is keyed to an **ORCID** identifier — the standard persistent
digital identifier for researchers. It is aimed at academic and research sites
that need to attach structured, ORCID-linked author metadata to their content.

Rather than free-typing an author's name into a plain text field, you add an
Author Field to a content type (or other entity) and capture the author's
details alongside their ORCID iD. That keeps attribution structured and linked
to a durable identifier, which supports citation, attribution, and researcher
metadata use cases.

This is a field-provider module: it adds field types you attach through Drupal's
normal *Manage fields* UI, and it renders their output like any other field.
Administration is gated by the `administer author_field` permission; the module
has no front-end access role of its own, and its output is escaped normally. It
supports Drupal 10 and 11. (Note the packaged release is `1.1.0-beta1`, a beta.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Author Field has no central settings page. Once enabled, you use it from
**Structure → Content types → (your type) → Manage fields**
(`/admin/structure/types`): add a new field and choose one of the Author Field
types, then configure it there as you would any field. Administering the field
requires the `administer author_field` permission, set at **People →
Permissions** (`/admin/people/permissions`).
