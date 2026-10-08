# Require on Publish — manual setup guide

**Require on Publish** (`require_on_publish`) lets you mark a field as required
**only when its entity is published**. Editors can freely save incomplete drafts,
but the moment they try to publish, any field you've flagged must be filled in or
the save is blocked. It's the fix for the awkward all-or-nothing choice core gives
you — where a field is either always required (annoying while drafting) or never
required (so incomplete content can slip out).

You turn the behaviour on per field, with a **Required on Publish** checkbox that
the module adds to each field's configuration form (only for fields on publishable
entity types, such as nodes). There's an optional companion checkbox, **Warning on
Empty**, which shows a soft, non-blocking warning when an *unpublished* entity has
the field empty — a gentle nudge without stopping the save.

Enforcement is done with a proper entity validation constraint rather than a form
tweak, so it applies uniformly to node forms, Paragraphs, and even programmatic or
REST saves. There is no settings page, no permissions, no service, and no Drush
command — the whole configuration is a per-field setting that travels with your
field config.

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the constraint/validator
details and the stored third-party setting keys — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable Required on Publish (and the
   optional warning) on a field.

## Where it lives in the admin menu

There is no admin page. The controls appear on each field's **edit form**, under
the bundle's **Manage fields** area — for example
`/admin/structure/types/manage/article/fields/node.article.<field>`. See
[Configuration](configuration/index.md) for the walkthrough.
