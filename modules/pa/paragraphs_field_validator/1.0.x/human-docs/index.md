# Paragraph Field Validator — manual setup guide

**Paragraph Field Validator** (`paragraphs_field_validator`) lets you enforce
**conditional validation rules** on Paragraph fields without writing custom PHP. It
validates one field's value against another field's value in the same paragraph:
when a "key" field contains an expected text, a second field must match a pattern.
A common example is a paragraph with a *type* field and a *value* field — when
*type* is `email`, the *value* must match an email pattern; when it is `phone`, it
must match a phone pattern.

This is useful when editors regularly build content with Paragraphs and you want to
guarantee consistent data — URL formats, phone numbers, conditional requirements —
without relying on developers to write validators. It lets you define rules like
"if field X equals Y, then field Z must match this regex," and apply a rule only on
specific nodes.

Its features include: validation rules defined **per Paragraph bundle**;
conditional validation triggered by a key field's value; **regex** pattern matching
with a customizable error example shown to editors; an optional **case‑insensitive**
match; and the option to **restrict a rule to specific nodes**. It depends on the
[Paragraphs](https://www.drupal.org/project/paragraphs) module and supports Drupal
10 and 11.

Note that this module is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form where you define
   the validation rules, field by field.

## Where it lives in the admin menu

Unlike most modules in the Paragraphs family, this one has a real settings form. It
lives at **Configuration → Content authoring → Paragraphs Field Validator**, where
you add and manage your validation rules. See
[Configuration](configuration/index.md) for a walk‑through.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open **Configuration → Content authoring → Paragraphs Field Validator** and add
   a rule: pick the Paragraph bundle, choose the key field and the value that
   triggers the rule, and give the field that must match plus the regex pattern
   (and optionally an example message, case‑insensitive matching, and the specific
   nodes it applies to). See [Configuration](configuration/index.md) for the full
   field‑by‑field detail.
3. Save. From then on, when an editor saves content whose paragraph matches the
   trigger condition, the target field is validated against your pattern and the
   save is blocked with your error message if it does not match.
