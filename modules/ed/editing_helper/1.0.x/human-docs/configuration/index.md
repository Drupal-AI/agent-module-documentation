# Configuration

Setting up Editing Helper has three parts: the **default help text** on the
settings form, optional **per‑field** and **per‑view** overrides, and the two
**permissions** that decide who configures help and who sees it.

## Step 1 — set the default help text

1. Log in as a user with the **"Administer editing helper permissions"**
   permission.
2. Go to **Configuration → Content authoring → Description Helper**
   (`/admin/config/content/editing_helper/config`).
3. Fill in the fields (all stored in `editing_helper.help_config`):
   - **Block Title** — the heading shown on the help panel.
   - **Block Inline Text** — default help for *inline* block content.
   - **Block Reusable Text** — default help for *reusable* block content.
   - **View Field Text** — default help for a view's field context.
   - **View Node Text** — default help for a node view context.
   - **View Taxonomy Term Text** — default help for a taxonomy term view context.
4. Text can be plain or **HTML** for richer formatting. **Save.**

## Step 2 — per‑field help (optional)

Editing any field's configuration form now shows an **Editing Helper Description**
textarea. Whatever you enter there is stored as that field's `editing_helper`
third‑party setting and **takes precedence** over the generic defaults from Step 1
for that specific field.

## Step 3 — per‑view help (optional)

Enable the **Editing Helper** *display extender* on a view to attach a help
description to a display. This overrides the node/taxonomy defaults for that view.

## Step 4 — grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`). Two permissions
control the module:

| Permission | What it grants |
|------------|----------------|
| **Administer editing helper permissions** | Configure the help text (the settings form, and the per‑field/per‑view help). Keep this with administrators. |
| **Access to editing helper** | See the helper button and its help panel while editing. Grant this to your editor roles. |

The help button and panel are shown **only** to users with **"Access to editing
helper"**. At render time the module picks the most specific help available for a
block — block content falls back to its reusable/inline default, a field block uses
its per‑field help or the default, and a views block uses the view/extender help or
the node/taxonomy default.

## A note on trust

Help text is authored by administrators through the config form, field settings,
and view settings, and it may contain HTML — so it's a trusted‑role surface, the
same as any admin‑entered markup. There are no anonymous or content‑mutating
endpoints in this module.
