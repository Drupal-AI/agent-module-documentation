# Field Formatter Class — manual setup guide

**Field Formatter Class** (`field_formatter_class`) lets site builders add CSS
classes to a field's outer HTML wrapper straight from *Manage display* — no theme
code required. It adds a small **"Field Formatter Class"** text box to the settings
of *every* field formatter (and every field widget), on any fieldable entity:
content types, users, taxonomy, media, and so on. Whatever classes you type there
are attached to the field's wrapper `<div>` when it renders.

This is a lightweight styling helper. It is especially handy for CSS grid systems
(drop `col-md-6` onto a field), for utility classes like `text-center`, and for
giving JavaScript plugins (sliders, masonry, tabs) a hook class to target — all
without overriding a Twig template.

The classes you enter are stored as a *third‑party setting* on the display
configuration, so they travel with configuration export/import like any other
display setting, and you can set a different class for the same field in different
view modes (Teaser vs. Full). The value also runs through Drupal's **token**
system, so you can build dynamic classes from entity data — for example
`status-[node:field_state]` — and if the Token module is installed you get a
token‑browser link next to the box. Values are escaped, so this is a safe
class‑string mechanism, not a way to inject markup.

It requires only core's **Field** module, adds no permissions or admin pages of its
own, and needs no per‑field setup to activate — the extra setting simply appears on
every field once the module is enabled. A migration is bundled to carry values
forward from the Drupal 7 version.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is **no dedicated settings page** — the module has no configuration form of
its own. Instead it adds one extra field to the settings of every formatter and
widget:

1. Go to **Structure → *entity type* → Manage display** (for example
   `/admin/structure/types/manage/article/display`), or **Manage form** if you want
   to add a class to a field's *edit* widget instead.
2. Click the **gear / edit icon** on the field's row to open its formatter
   settings.
3. In the **Field Formatter Class** text box, type one or more classes separated by
   spaces — for example `col-md-6 my-hook`. (Tokens like `[node:field_state]` are
   allowed and resolved per entity.)
4. Click **Update**, then **Save**. The Manage display row summary then shows
   `Class: <value>` so you can confirm at a glance which class the field carries.

At render time the classes land on the field's outer wrapper, alongside Drupal's
default `field field--name-…` classes:

```html
<div class="field field--name-field-foo … col-md-6 my-hook"> … </div>
```

Leaving the box blank is a no‑op, so installing the module changes nothing until
you actually type a class somewhere. If your theme overrides `field.html.twig`,
just make sure it still prints `{{ attributes }}` on the wrapper for the classes to
appear.
