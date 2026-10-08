# Configuration

You configure Required Menu Link **per content type**, on the content type edit
form. There is no separate settings page.

## Open the settings

1. Go to **Structure → Content types**
   (`/admin/structure/types`) and **Edit** the content type you want to change (or
   set the options while adding a new content type).
2. In the vertical tabs at the bottom of the form, open **Menu link settings**
   (added by this module).

## The three options

- **Require menu link** — the main switch. When on, every node of this type must
  have a menu link: on the node form the *Provide a menu link* checkbox is forced
  on and disabled, the menu fieldset is opened automatically, and the menu link
  **title** field becomes required. Editors can't save without it.

- **Do not enforce menu link** (a "soft require") — shown only when *Require menu
  link* is ticked. With this on, the menu link checkbox is merely **pre‑enabled by
  default** rather than forced — editors can still untick it. Use this when you
  want to nudge editors toward adding a menu link without making it mandatory.

- **Disable automatic menu title** — by default, Drupal copies the node title into
  the menu link title as you type. Turn this on to stop that mirroring, so editors
  must type a deliberate menu label. (This attaches a small JavaScript behaviour to
  the node form to flag the menu title as manually overridden.)

Save the content type. The chosen options are stored as that content type's
settings, so each type can have its own combination — for example hard‑require on
your "Landing page" type and soft‑require on "Article."

## How it changes the node form

When you then add or edit a node of a configured type:

- **Hard require** (*Require menu link* on, *Do not enforce* off): the menu
  fieldset is expanded, the *Provide a menu link* checkbox is checked and can't be
  turned off, and the menu link title is required.
- **Soft require** (*Require menu link* on, *Do not enforce* on): the checkbox
  just defaults to checked; nothing is forced.
- **Auto‑title disabled**: the menu title no longer auto‑fills from the node
  title, so editors type it themselves.

## Good to know

- **This is form‑level enforcement.** The requirement is applied on the standard
  node add/edit form only. It is **not** an entity‑level validation constraint, so
  content created through other paths — REST, JSON:API, migrations, or
  programmatic `Node::save()` — is not forced to have a menu link.
- **Removing the requirement** is as simple as unticking *Require menu link* and
  saving; the stored settings are cleared.
