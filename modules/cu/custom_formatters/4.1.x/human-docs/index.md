# Custom Formatters — manual setup guide

**Custom Formatters** (`custom_formatters`) lets site builders create reusable
**field formatters** through the admin UI — by writing a small PHP, Twig, or
HTML+Token snippet (or wrapping an existing formatter as a preset) — instead of
building and deploying a custom module. Each formatter you create is saved as a
configuration entity and then shows up in Field UI's *Manage display* screen
exactly like any built‑in formatter, available to the field types you chose.

You pick an engine when you create a formatter. **PHP** runs your snippet to
compute the output, **Twig** renders your template, **HTML+Token** wraps the
value in markup with token replacement, and **Formatter Preset** packages an
existing core/contrib formatter with pre‑locked settings. Formatters can also
carry their own per‑instance settings fields, so an editor choosing your formatter
on a field can supply values (a CSS class, a toggle) that your snippet reads. It
integrates optionally with CodeMirror (syntax highlighting for the code fields),
Token / Field Tokens, Insert, and Devel (preview debugging and sample content).

> **Important — this tool runs code you write.** The PHP and Twig engines execute
> the snippet you save, which means anyone who can create or edit a formatter can
> run **arbitrary code on your server**. All formatter management is gated by a
> single permission, *Administer Custom Formatters*. Treat it exactly like the PHP
> Filter or "Administer software updates" permission: grant it **only to fully
> trusted site administrators**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and the optional companion modules.
2. [Configuration](configuration/index.md) — create and manage formatters, choose
   an engine, and add per‑instance settings.

## Where it lives in the admin menu

Formatters are managed at **Structure → Formatters**
(`/admin/structure/formatters`), gated by the *Administer Custom Formatters*
permission. The formatters you create then appear as display options under each
field's **Manage display** tab (**Structure → Content types → *(type)* → Manage
display**, and the equivalent for other entity types).
