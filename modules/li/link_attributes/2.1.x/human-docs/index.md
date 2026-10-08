# Link attributes — manual setup guide

**Link attributes** (`link_attributes`) adds a field widget that lets editors set
HTML attributes — `target`, `rel`, `class`, `title`, `id`, `aria-label`,
`accesskey`, and custom ones — on individual link‑field values. Core's Link field
stores only a URL and link text, with no way to make a link open in a new tab, mark
it `rel="nofollow"`, attach a CSS class, or add an ARIA label. This module fills
that gap.

It works by providing a replacement widget called **Link (with attributes)**. When
you set a Link field's form‑display widget to this one, editors get a small,
collapsible panel of attribute inputs beneath each link. Which attributes appear is
controlled per form‑display, so a call‑to‑action field can offer `class` and
`target` while a footer field offers only `rel`. Attribute values are saved into the
link field's stored options and rendered automatically wherever the link is output —
no theming changes required.

The available attributes are defined as lightweight **YAML plugins**
(`*.link_attributes.yml`), so other modules can add new attributes without writing
PHP, and `hook_link_attributes_plugin_alter()` lets developers tweak or set defaults.
Built‑in attributes are `id`, `name`, `target` (a select of `_self` / `_blank`),
`rel`, `class`, `accesskey`, `aria-label`, and `title`.

Link attributes depends only on core's **Link** module and works as soon as you
switch a field to its widget — there is no site‑wide settings page to fill in. Two
optional submodules extend it: **`link_attributes_menu_link_content`** brings the
same attributes to content menu links, and **`linkit_attributes`** combines the
attributes with the Linkit autocomplete widget.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — switch a Link field to the widget and
   choose which attributes editors can set.

## Where it lives in the admin menu

Link attributes has **no central settings page**. You configure it per field, on the
entity's **Manage form display** tab — for example **Structure → Content types →
[your type] → Manage form display** (`/admin/structure/types/manage/{type}/form-display`)
for a content type. There you change the Link field's widget to **Link (with
attributes)** and open its settings gear to choose which attributes appear. See
[Configuration](configuration/index.md) for the details.
