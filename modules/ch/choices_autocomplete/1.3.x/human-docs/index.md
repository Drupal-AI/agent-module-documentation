# Choices.js Autocomplete — manual setup guide

**Choices.js Autocomplete** (`choices_autocomplete`) replaces the plain Drupal
select box and entity-reference autocomplete with a richer widget powered by the
[Choices.js](https://github.com/Choices-js/Choices) JavaScript library. Editors get
a searchable, tag-style selector with support for rich (HTML + CSS) formatting of
both the options and the autocomplete results — handy when you want option labels
to carry a little markup, an image, or styling rather than being plain text.

It provides a form widget for **List (text)**, **List (integer)**, **List
(float)**, and **Entity reference** field types, and it works with both the
standard and Views entity-reference selection handlers — including autocreate
("tags") for entity-reference fields. Styles are included for the **Olivero** and
**Claro** themes out of the box. You can also use it on a custom form element by
setting `#type => 'choices_autocomplete'`. Everything is configured per field on
the **Manage form display** tab; there is no site-wide settings page.

> **Please read before adopting:** the maintainers recommend using the
> [Tagify](https://www.drupal.org/project/tagify) module instead. This project is
> only minimally maintained and is slated to be marked **obsolete** unless a new
> maintainer steps up. For new sites, prefer Tagify; use Choices.js Autocomplete
> mainly where you're maintaining an existing site that already relies on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, provide the
   Choices.js library, and enable the module.

There is **no configuration page** for this module. You set it up per field on the
entity's **Manage form display** tab, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage form display**.

## How to use it

1. Go to the bundle's **Manage form display** tab.
2. For a supported field (a List field or an Entity reference field), choose the
   **Choices.js Autocomplete** widget in the **Widget** column.
3. Open the widget's settings (the gear icon), adjust the options, and **Update**,
   then **Save**.
4. Open the entity's add/edit form and the field now renders as a searchable
   Choices.js selector.
