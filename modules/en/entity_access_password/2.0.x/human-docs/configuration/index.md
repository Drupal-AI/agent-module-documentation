# Configuration

Setting up password protection has three parts: the site-wide **global settings**,
adding the **protection field** to a content type, and choosing which **view
modes** the field protects. This page walks through each.

## Permissions

Two permissions are defined, both **restricted** (grant only to trusted roles),
under **People → Permissions**:

- **Administer entity access password** — access the global settings form and the
  module's admin pages.
- **Bypass password protection** — the holder always sees protected content; the
  password form is never shown to them. Useful for editors and administrators.

## Global settings

Go to **Configuration → Content authoring → Entity Access Password → Settings**
(`/admin/config/content/entity_access_password/settings`). Two options:

- **Global password** — a single site-wide password. Any field with the "global"
  check enabled unlocks when this password is entered. It is stored **hashed**;
  submitting the form with the field left empty keeps the current password
  unchanged.
- **Random password length** — how many characters the editor widget's
  "generate random password" button produces (between 8 and 50, default 8).

## Add the protection field to a content type

1. Go to **Structure → Content types → *(your type)* → Manage fields → Add field**.
2. Choose the field type **Password protection** (listed under the *access*
   category). It has a fixed cardinality of one.
3. On the field's settings, enable one or more **password checks** and pick the
   view modes to protect:

   - **Per-entity password** — each entity carries its own password, set by the
     editor when they create/edit it.
   - **Bundle password** — one password shared by every entity of this type. You
     type the bundle password here in the field settings (stored hashed).
   - **Global password** — use the site-wide password from the global settings
     above.
   - **View modes** — check the view modes on which protection is enforced (for
     example *Full content*). A view mode you do not check is **not** protected —
     which is why the teaser can stay visible while the full page is gated (or vice
     versa). Leaving this empty means nothing is enforced.

   When more than one check is enabled, entering the password for **any** of them
   unlocks the content (the module tries entity, then bundle, then global).

## Configure the editor widget

On the content type's **Manage form display**, the **Password protection** widget
has options for:

- whether the field's details section is **open** by default,
- whether to show the **entity title** toggle,
- whether to show the **hint** field,
- whether to offer the **generate random password** button.

When editing a piece of content, the editor can then:

- tick **Protected** to turn protection on for that entity,
- optionally hide the title (visitors see "Protected entity" instead of the real
  title until they unlock it),
- add an optional **hint** shown above the password form,
- set the per-entity **password** (or generate a random one).

## Configure the display (the password form)

On **Manage display**, the protection field uses the **Password form** formatter,
which renders the unlock form. It has an optional **help text** setting shown above
the form. There is also a **boolean** formatter you can use elsewhere to display
simply *whether* an entity is protected.

Behind the scenes, when a protected entity is requested in a protected view mode
and the visitor has not unlocked it, the module swaps the display to a dedicated
`password_protected` view mode that shows this form.

## Remembering unlocked access

Make sure at least one storage backend submodule is enabled (see
[Installation](../installation/index.md)) — the **session backend** for anonymous
visitors and/or the **user-data backend** for logged-in users. The user-data
backend additionally provides admin forms (behind their own restricted
permissions) to grant a specific user access without them entering the password.

## A reminder on scope

Protection is enforced at the **display layer only**. It does not implement entity
access or node grants, so the raw content remains reachable via JSON:API/REST,
Views raw fields, search indexing, and any non-protected view mode. Private-file
downloads attached to a protected entity are gated, but the field data is not. For
genuinely sensitive content, restrict those paths separately or combine this module
with a real access-control module.
