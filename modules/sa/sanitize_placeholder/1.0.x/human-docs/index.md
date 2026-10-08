# Sanitize Placeholder — manual setup guide

**Sanitize Placeholder** (`sanitize_placeholder`) makes sanitized copies of your
database both safer and more useful. When you run `drush sql:sanitize` — the usual
step for turning a production dump into a development or staging copy — Drupal
replaces sensitive values with generic placeholders. This module runs right after
that and improves the result: it shortens and normalises overlong or invalid
usernames, and it replaces configured fields with realistic fake data (first
names, last names, institutions, domains, patterns and more) so your dev database
looks believable rather than full of lorem‑ipsum strings.

It solves two everyday problems with sanitized databases. First, sanitization can
leave usernames that are too long or contain characters like `+` and `@`; this
module cleans them up (and normalises dots to underscores). Second, plain
sanitized values are unrealistic and unhelpful for UX work, search testing and
demos; per‑field fake data fixes that while keeping real personal data out. By
default generation is **deterministic** — the same entity gets the same values on
every run, which is ideal for repeatable tests — and generated values are trimmed
to each field's configured maximum length.

The module needs configuration to do the interesting part: it works after
`sql:sanitize` automatically, but only acts on fields that both Drush actually
sanitized and that match rules you define. You add those rules on its settings
page. It also provides an on‑demand Drush command, `drush sp:fake` (alias
`sp:fake-fields`), for applying the field strategies whenever you like. It has no
required dependencies. An optional companion submodule,
**`sanitize_placeholder_extra`**, ships country‑specific example strategies you
can enable and learn from, and the strategy system is pluggable so you can add
your own in custom code.

Fake‑data quality can optionally be improved by installing the **Faker** library
(`fakerphp/faker`) via Composer — with it you get richer name and address
vocabularies and proper locale support; without it, a lightweight built‑in
generator covers all the shipped strategies (and the "Faker locale" setting is
simply ignored).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally add Faker and the extra‑examples submodule.
2. [Configuration](configuration/index.md) — the settings page and the
   `sp:fake` command, field by field.

## Where it lives in the admin menu

The settings page is at **Configuration → Development → Sanitize Placeholder**
(`/admin/config/development/sanitize-placeholder`), where you add field rules and
tune the username length and determinism options.

## How to use it

Configure your field rules, then run `drush sql:sanitize` to produce a sanitized
database — the module's post‑hook applies your rules automatically to the fields
Drush sanitized. You can also run `drush sp:fake` yourself at any time to apply
the field strategies with your choice of scope.
