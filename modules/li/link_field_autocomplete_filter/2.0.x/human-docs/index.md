# Link Field Autocomplete Filter — manual setup guide

**Link Field Autocomplete Filter** (`link_field_autocomplete_filter`) lets you control
which **content types** appear as suggestions when an editor uses a Link field's
internal-link autocomplete. By default a core Link field autocompletes against *every*
node type on the site, which gets noisy and lets editors link to content they
shouldn't. This module lets you restrict a Link field — per field instance — to just
the content types you choose, and it validates the saved value so a link can't slip
through to a disallowed type.

It works by adding an **"Autocomplete Filter"** section to each Link field's settings
form. There you pick an include-or-exclude mode and tick the content types it applies
to. When an editor then types into that field's autocomplete, only nodes of the allowed
types are suggested; and if field settings change later so that an already-linked
node's type is no longer allowed, the form flags it on the next save rather than
letting a broken reference persist silently. If you leave every box unticked, the
field behaves exactly like core (all types allowed).

The settings are stored on the field itself, so the same base field can be filtered
differently on each content type or paragraph type that uses it — and because it's part
of the field's configuration, it exports and deploys like any other field setting.
There is **no central settings page, no permission, and no Drush command** — everything
lives on the individual field. The module depends only on core's **Link** module.

This guide is written for a **human** configuring a Link field in the admin UI. If you
want terse, token-cheap references for an AI coding agent — the third-party settings
keys and the widget/validation mechanism — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the include/exclude mode and content
   types on a Link field, field by field.

## Where it lives in the admin menu

There is no global configuration page. The module's **"Autocomplete Filter"** fieldset
appears on the edit form of any **Link** field instance — for example under
**Structure → Content types → (type) → Manage fields → (your link field) → Edit**. It
only shows up for fields of type *Link*.
