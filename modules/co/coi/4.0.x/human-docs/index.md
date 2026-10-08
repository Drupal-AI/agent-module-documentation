# Config Override Inspector (COI) — manual setup guide

**Config Override Inspector** (`coi`) flags configuration form fields whose value
is **overridden** — for example by a `$config[...]` line in `settings.php` or an
environment-specific override. When a setting is pinned by code, changing it in the
admin UI has no effect, which quietly confuses administrators. COI makes that
visible: it adds a message, CSS classes, and — if you want — disables or hides the
overridden field so nobody edits a value that won't apply.

It works hand in hand with its dependency,
[Config Override Core Fields](https://www.drupal.org/project/config_override_core_fields),
which tags core system-settings fields with a hint saying which config key each one
edits. On every form, COI checks those hinted fields against the live config and, if
an override is present, acts according to your chosen behavior: **disable** the field
(and optionally show the overridden value in it), **hide** it entirely, or leave it
editable as an **indicator only**. An optional message — built with the
`coi:active-value` and `coi:overridden-value` tokens — explains what is happening, and
secret values can be masked or revealed.

All of COI's behavior is driven by a single settings page. It defines one permission,
**Administer config override inspector**, and suggests the **Token** module for a token
browser on the settings form. Coverage for the standard core settings forms comes from
Config Override Core Fields; developers can extend it to custom forms by adding their own
hints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependency
   with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings page: override behavior,
   message, value display, and styling.

## Where it lives in the admin menu

Once enabled, COI's settings sit at **Configuration → User interface → Config
Override Inspector** (`/admin/config/user-interface/coi`), gated by the **Administer
config override inspector** permission. The indicators themselves appear on the
core settings forms (Basic site settings, Performance, and so on) whenever an
override exists for a field.
