# Site Settings and Labels — manual setup guide

**Site Settings and Labels** (`site_settings`) gives you a clean place to store
the small, editable bits of a site — a phone number, a footer copyright line, a
list of social links, reusable labels like "Read more" or "Book now" — so that a
client or editor can change them without touching Drupal's configuration or
needing admin access.

The clever part is how it splits things. The **shape** of each setting (what
fields it has, how its form and display look) is stored as configuration, so it
lives in version control and moves cleanly between environments. The **values**
(the actual phone number, the actual strapline) are stored as content, so editors
can change them at any time and translate them per language, with a full revision
history. A setting is really just a fieldable content entity, which means you can
put any fields you like on it — text, images, links, booleans — and even list them
in Views.

You define **settings types** (the bundles), optionally organise them into
**groups** like "Footer settings" or "Social", and then editors create and edit
the values under a friendly *Site settings* area. Getting a setting back out into
your theme is done with a handful of Twig functions (for example
`{{ site_setting_field('phone_number', 'field_number') }}`), two ready-made
blocks, or tokens for use in emails.

There's a small submodule, **Site Settings Type Permissions**
(`site_settings_type_permissions`), which lets you control edit/view rights per
settings type — handy when different editors should only manage certain settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional per-type permissions submodule.
2. [Configuration](configuration/index.md) — defining settings types and groups,
   the module's options form, permissions, and how editors add values.

## Where it lives in the admin menu

The module spreads across three areas:

- **Content → Site settings** (`/admin/content/site-settings`) — where editors
  create and edit the actual **values**.
- **Structure → Site settings** (`/admin/structure/site-settings`) — where site
  builders define the **types** and **groups** (and add fields to them).
- **Configuration → Site settings → Site settings config**
  (`/admin/config/site-settings/config`) — the module's own options form.

## How to use it

A typical flow:

1. As a site builder, define a **settings type** (e.g. "Phone number"), optionally
   assign it to a **group**, and add whatever fields it needs on the type's
   *Manage fields* tab.
2. Grant your editors the value-editing permissions (see
   [Configuration](configuration/index.md#permissions)).
3. An editor opens **Content → Site settings**, adds a Phone number setting, and
   fills in the value.
4. In your theme, print it with a Twig function such as
   `{{ site_setting_field('phone_number', 'field_number') }}`, drop a **Site
   settings block** into a region, or reference it as a token — for example in an
   automated email.
