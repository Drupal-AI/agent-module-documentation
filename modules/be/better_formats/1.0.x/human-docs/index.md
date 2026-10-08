# Better Formats — manual setup guide

**Better Formats** (`better_formats`) extends Drupal core's text-format system so
you can decide, field by field, which text formats an author may pick, what order
those formats appear in, and which one is the default — and, per role, whether the
format selector and the "About text formats" tips show up at all. If you have ever
wished a particular Body field only offered *Basic HTML*, or that a plain "notes"
field showed no format dropdown at all, this is the module that lets you do it
without writing code.

Out of the box Drupal shows every text format a role is allowed to use on every
text field, always in the same order, with a "text formats" help block underneath.
Better Formats hooks into the field configuration form and adds a **Text Formats**
fieldset to each text field, where you tune those choices. It stores your choices
as third-party settings on the field itself, so they travel with your exported
field configuration. It depends only on core's **Filter** module and ships no
submodules, no Drush commands, and no plugin types.

The module does very little the moment you enable it — there is exactly one small
global toggle. Almost all of its value comes from the per-field settings you add
afterwards and from three permissions it introduces (to hide the format tips, the
"more information" link, and the format selector for a given entity type). So plan
on enabling it and then visiting the fields you want to constrain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the one global setting, the per-field
   Text Formats fieldset, and the permissions, field by field.

## Where it lives in the admin menu

The single global setting sits at **Configuration → Content authoring → Text
formats and editors → Settings**
(`/admin/config/content/formats/settings`), guarded by the **Administer filters**
permission. Everything else lives on individual **field** configuration forms —
open any text field under *Structure → [entity] → Manage fields* and look for the
**Text Formats** fieldset. The three permissions are set on the usual **People →
Permissions** page.
