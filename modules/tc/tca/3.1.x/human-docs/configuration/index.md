# Configuration

TCA has **no central settings page**. You configure it in two places — on each
content item, and on the bundle (content type / product type) — and you decide
who can touch those controls with two permissions. This page walks through all
three.

## Prerequisite: enable a submodule first

The **TCA** controls only appear for entity types TCA has been told to protect.
Enable **TCA Node** (`tca_node`) for content, or **TCA Commerce Product**
(`tca_commerce_product`) for Commerce products, before you expect to see
anything (see [Installation](../installation/index.md)).

## Per‑item settings — the TCA fieldset

Open the add/edit form of a protected entity type. If you have permission (see
below), you'll see a **TCA** fieldset with three fields:

- **TCA Active** (`tca_active`) — tick this to require a matching `?tca` token
  before anyone can view this item. If the bundle *forces* TCA (see below), this
  is switched on and locked.
- **TCA Public** (`tca_public`) — when the token matches, allow the item to be
  viewed even by users who wouldn't normally have "view published content"
  access. Use this to share unpublished or otherwise gated content with people
  who have the link. Leave it unticked to keep normal permissions in force after
  the token check passes.
- **TCA Token** (`tca_token`) — the secret string that must appear in the URL as
  `?tca=<token>`. It is generated automatically when you save (keyed to your
  site's private key and hash salt, so it's hard to guess), and there's a
  generate action to make a fresh one. **Regenerating the token immediately
  breaks every link you shared with the old token** — that's how you revoke
  access.

The link you share is simply the item's normal URL with `?tca=<token>` added on
the end.

## Per‑bundle setting — enforce token usage

On the bundle's edit form (for example **Structure → Content types → *your type*
→ Edit**), a **TCA** section adds an **Enforce Token usage** checkbox. When it's
ticked, every item of that bundle has TCA switched on automatically and editors
cannot turn it off. Use this when a whole category of content must never be
viewable without a token — editors can't accidentally publish it in the open.

This bundle‑level setting is stored as configuration, so it moves between
environments with a normal config export/import.

## Permissions — who can use TCA

TCA creates **two permissions for each protected entity type**, at
**People → Permissions** (`/admin/people/permissions`). With TCA Node enabled,
for instance, you get `tca administer node` and `tca bypass node`; with TCA
Commerce Product you also get `tca administer commerce_product` and
`tca bypass commerce_product`.

- **`tca administer <entity type>`** — controls whether a user sees and can edit
  the **TCA fieldset** (active / public / token) on that entity type's form. A
  holder can only set the token and flags on items they're already allowed to
  edit, so it's a scoped capability, not a site‑wide power. (Even without it, if
  a bundle *forces* TCA the token is still generated on save.)
- **`tca bypass <entity type>`** — lets a user **skip the token check entirely**
  for that entity type — they can view every token‑protected item of that type
  without a link, and (with TCA Node) protected nodes appear normally in search
  and Views for them. Grant this only to trusted roles such as support, QA, or
  editors who need to see everything.

## How the check actually behaves

When someone tries to view a protected item, TCA compares the `?tca` value in
the URL against the stored token using a constant‑time comparison (to resist
timing attacks):

- **No token or wrong token** → access **forbidden**.
- **Correct token, item marked public** → access **allowed**, bypassing the
  normal "view published content" requirement.
- **Correct token, not public** → TCA stays neutral and Drupal's usual
  permissions decide the rest.
- **User has `tca bypass <type>`** → the check is skipped entirely and they see
  the item regardless.
