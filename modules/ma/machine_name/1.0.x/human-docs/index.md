# Machine Name — manual setup guide

**Machine Name** (`machine_name`) adds a reusable **machine name** field type to
Drupal, so you can store a short, machine-readable identifier — a slug, a code, a
handle — on any content type, taxonomy vocabulary, user, paragraph, media bundle,
or other fieldable entity. It uses the same familiar auto-transliterating
`machine_name` element you already know from creating content types and views:
editors type a human label and Drupal proposes a lowercased, underscored
identifier, constrained to the machine-name character set.

The field stores a 64-character text value and can optionally enforce that the
value is **unique** across all entities of that type — useful when editors create
many similar records and you need to prevent duplicate identifiers. It can also
be **locked** after first save so an identifier can't drift once other systems
start relying on it. A matching formatter displays the stored value as plain,
escaped text.

There is nothing site-wide to configure — no settings page, no permissions, no
dependencies beyond Drupal core. You simply add the field to a bundle like any
other field and choose two widget options. It's a handy way to give editors a
predictable key for use in Views, URLs, migrations, or integrations without
writing a custom field type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure a Machine Name field
per bundle under **Structure**, on that bundle's **Manage fields**, **Manage form
display**, and **Manage display** tabs.

## How to use it

1. Go to the bundle you want to add the field to — for example **Structure →
   Content types → *(your type)* → Manage fields** — and click **Add field**.
2. Choose **Machine name** as the field type, give it a label, and save. The
   storage is a 64-character text value.
3. On **Manage form display**, make sure the field uses the **Machine name**
   widget, then open its settings (the cog) to set:
   - **Editable** *(default off)* — when off, the value becomes read-only once the
     entity has been saved the first time, locking the identifier. Turn it on to
     allow ongoing edits.
   - **Unique** *(default on)* — when on, Drupal rejects a value that another
     entity of the same type already uses, showing "The machine name … is already
     in use."
4. On **Manage display**, place the field and (optionally) use the **Machine
   name** formatter to show the value as plain text.

A couple of details worth knowing:

- The uniqueness check reads the widget settings from the bundle's **default**
  form display. If you want uniqueness enforced everywhere (including other form
  modes or programmatic saves), make sure **Unique** is enabled on the *default*
  form display.
- Uniqueness is checked against *all* entities of that type regardless of access,
  so a value already used by content the current editor can't see will still be
  reported as taken.
- You can add more than one Machine Name field to a bundle, each with its own
  Editable/Unique behaviour.
