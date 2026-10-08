# File defaults by type — manual setup guide

**File defaults by type** (`file_defaults_by_type`) lets you attach a set of
named "types" — each with its own default file — to a File field. Instead of a
plain empty upload widget, the person filling in the field is offered a dropdown
of the types you defined (for example *Text*, *Spreadsheet*, *Presentation*), and
choosing one attaches the matching default file as a starting point.

It is especially handy alongside collaborative editing tools such as Collabora
Online: you define a "template" file per type, and content starts from the right
template ready to be edited, rather than from a blank upload. Each type is
identified by a label and requires a default file to be assigned to it.

The module depends on core's **File** module and on the contributed
**Multivalue Form Element** module (`multivalue_form_element`), which provides the
repeatable widget used to define the list of types. It targets Drupal 10.2 and
11. A companion UI helper (`file_defaults_by_type_ui`, described in the project's
own documentation) can make setting and replacing the default files more
convenient.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   pull in its dependencies, and enable it.

There is no central settings form for this module — everything is configured
directly on each File field, as described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit a **File** field on any content type (or other fieldable entity) under
   **Structure → Content types → *(type)* → Manage fields**.
3. In the field's settings, define the **types** you want to offer — give each a
   label and assign the default file that represents it.
4. When authors add content, the field presents a dropdown of those types; the
   author picks one and its default file is attached to the field as a starting
   point.
