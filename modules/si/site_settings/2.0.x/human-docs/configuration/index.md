# Configuration

Setting up Site Settings and Labels has three parts: defining the **types** (and
optionally **groups**) of settings, tuning the module's **options form**, and
granting the right **permissions** so editors can manage values. This page walks
through each.

## 1. Define a settings type

A "settings type" is the template for a setting — its machine name, label, group,
and fields.

1. Go to **Structure → Site settings**
   (`/admin/structure/site-settings`) and add a new settings type.
2. Give it a **label** (e.g. "Phone number"), and optionally assign it to a
   **group**.
3. Decide whether it may have **multiple** entries. Leave this off for a
   single-value setting (one phone number); turn it on when editors should be able
   to create several of the same kind (e.g. multiple office addresses).
4. Save, then use the type's **Manage fields** tab to add whatever fields the
   setting needs — a text field for the number, an image field, a link field, a
   boolean feature-flag, and so on. *Manage form display* and *Manage display*
   work exactly as they do for any content type.

### Groups

Groups (like "Footer settings" or "Contact details") organise types in the admin
menu and let you render a whole group at once in the theme. Create them under
**Structure → Site settings** alongside the types.

### Replicate

From the settings-type listing, a **Replicate** operation lets you mass-create
several similar types in one batch — useful when you need ten near-identical
settings types. You add rows of machine name / label / group and the module
creates them for you.

## 2. The module options form

Go to **Configuration → Site settings → Site settings config**
(`/admin/config/site-settings/config`; requires the **Administer site setting
entities** permission). The options here mostly simplify the editing experience:

- **Template variable name** (`template_key`, default `site_settings`) — the name
  of the Twig variable that the legacy *flattened* loader auto-loads settings
  into. Only relevant if you switch to that loader. Change it if the default name
  clashes with something in your theme.
- **Loader plugin** (default **full**) — how settings are loaded for the Twig
  functions and tokens. **Full** (the default and recommended choice) returns real
  entities and powers all the Twig functions correctly. **Flattened** is a legacy
  mode that flattens settings into arrays and can auto-load them into every
  template — faster in narrow cases but it loses render data and breaks some Twig
  functions.
- **Disable auto-loading** — on by default after install. When off (and the
  flattened loader is active), every template automatically receives a
  `site_settings` variable. Leave it on for performance and use the Twig functions
  instead.
- **Hide the description field** — on by default. Hides (and locks) the built-in
  *description* field on settings forms. Turn it off if you actually want editors
  to fill in a description.
- **Hide the advanced (revision) section** — on by default; keeps the settings
  form uncluttered by hiding the revision log area.
- **Hide the group element** — on by default; hides the per-entity group selector
  on the form (the group is normally fixed by the type).
- **Simple summary** — on by default. Shows a compact, auto-generated teaser in
  the admin listing instead of a full teaser view mode. Turn it off if you want
  your own teaser display to show there.
- **Show groups in the menu** — on by default; adds an admin menu link per group.
- **Edit form on the canonical route** — on by default; shows the edit form when
  you visit a setting's own page, so editors land straight on the form.

Save the form when done.

## 3. Editors add the values

Once types exist and permissions are granted, editors work under **Content → Site
settings** (`/admin/content/site-settings`). They add a setting of the right type
and fill in the fields. For types marked **multiple**, an **Add another** action
lets them create additional entries. Every change is revisioned, and on a
multilingual site each setting can be translated per language.

## Permissions

The module ships ten permissions (under **People → Permissions**). The ones you
will grant most often:

| Permission | Lets a user… |
|------------|--------------|
| **Administer site setting entities** | Define the types and groups, use the config form, and replicate types. This is the powerful "site builder" permission — restrict it. |
| **Access the site settings overview** | See the **Content → Site settings** listing (and, note, the settings content there). |
| **Add site setting entities** | Create new settings values. |
| **Edit site setting entities** | Edit existing settings values. |
| **Delete site setting entities** | Delete settings values. |
| **View published site setting entities** | View published settings (granted to everyone on install). |

There are also permissions for unpublished settings and for viewing, reverting,
and deleting **revisions**.

A common split:

- Give **client editors**: *Access the site settings overview*, *Add*, *Edit*, and
  *View published site setting entities* — they manage values but not structure.
- Give **site builders**: *Administer site setting entities* — they define the
  types.

### Per-type permissions (submodule)

If you enabled the **Site Settings Type Permissions** submodule, you also get
eight permissions **per settings type** (e.g. *edit phone_number site setting*),
so you can let one editor manage only certain settings. These combine with the
global permissions above.

### A field-access quirk

While **Hide the description field** is on (the default), the built-in
*description* field is locked and cannot be edited or rendered by anyone,
regardless of permission. Turn that option off on the config form if you need the
description field.

## Getting settings into your theme

Once values exist, render them with the Twig functions in your templates — for
example:

```twig
{{ site_setting_field('phone_number', 'field_number') }}
{{ site_settings_by_group('Footer settings') }}
```

Or place a **Simple site settings block** / **Rendered site settings block** into
a region under **Structure → Block layout**, or reference a setting as a token
(e.g. in an automated email) when the Token module is installed. The
[`agent/`](../agent/start.md) docs list every Twig function, block, and token.
