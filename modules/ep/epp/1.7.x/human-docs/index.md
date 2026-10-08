# Entity Prepopulate — manual setup guide

**Entity Prepopulate** (`epp`) prefills a field's value on an entity add or edit
form from a small, token-enabled template you store on the field itself. Instead
of writing a custom module to set default values, you type a value (which may
contain tokens) into an **Entity Prepopulate** box on the field's settings form,
and the module applies it whenever a matching entity form is built.

What makes it robust is that it works at the **entity level** rather than just the
form widget: the value is set on the entity and then validated, so it plays nicely
with multi-property fields such as text-with-format, link, geofield or address. It
uses YAML for the value, which is what lets you target individual field properties
when you need to.

It is a small, focused module — no admin settings page, no permissions, no plugins,
no Drush commands. Its only persistent footprint is two settings stored on each
field you configure. Prepopulation runs only when the entity is **new**, unless you
tick **Also on update**. And it is safe by design: a value is applied only when
*every* token in it resolves and the resulting value passes validation — otherwise
the field is simply left untouched.

Installing the **Token** module is optional but recommended: it adds a token
browser and richer token support to the settings box. Without it, basic core
tokens still work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (plus the optional Token module).
2. [Configuration](configuration/index.md) — the per-field **Entity Prepopulate**
   settings, field by field, with YAML value examples.

## Where it lives in the admin menu

Entity Prepopulate has **no central settings page**. You configure it on each
individual field, under **Structure → Content types → [type] → Manage fields →
[edit a field]**, in the **Entity Prepopulate** fieldset. See
[Configuration](configuration/index.md) for details.
