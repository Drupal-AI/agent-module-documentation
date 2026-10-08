# Token Content Access — manual setup guide

**Token Content Access** (`tca`) — often shortened to **TCA** — lets you protect
an individual piece of content behind a secret token that travels in the URL.
Turn TCA on for an entity, share the tokenized link (it looks like
`https://example.com/node/42?tca=<token>`), and only visitors whose URL carries
the matching token — or users you've given a bypass permission — are allowed to
view it. Anyone else is forbidden.

This is a handy way to share a private preview of an unpublished page with an
outside reviewer, hand a client a "secret link" to a page without making them
create an account, or gate a marketing landing page behind a unique URL. Because
the check is only about *viewing*, TCA layers on top of Drupal's normal
permission system: the token has to match first, and then the usual access rules
still apply — unless you also mark the entity **public**, in which case a correct
token lets even anonymous visitors see otherwise‑restricted content.

Out of the box, the base module doesn't protect anything yet — it doesn't know
which entity types you care about. You pick those by enabling one of the bundled
submodules: **TCA Node** (`tca_node`) for content/nodes, or **TCA Commerce
Product** (`tca_commerce_product`) for Commerce products. (Developers can add
support for any other entity type by writing a small plugin.) Once a submodule is
on, a **TCA** section appears on that entity's edit form where you flip TCA on
and copy the auto‑generated token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   base module, and choose the submodule for the entity type you want to protect.
2. [Configuration](configuration/index.md) — the per‑entity TCA settings, the
   per‑bundle "enforce" option, and the two permissions that control who can use
   them.

## Where it lives in the admin menu

TCA has no standalone settings page (`configure` is `null`). You control it in
two places instead:

- On each **content item's add/edit form**, in a **TCA** fieldset (active flag,
  public flag, and the token).
- On the **bundle's edit form** (for example the content type at
  **Structure → Content types → *your type* → Edit**), where an **Enforce Token
  usage** option can force TCA on for every item of that bundle.

Who sees these controls is governed by permissions at
**People → Permissions** (`/admin/people/permissions`).

## How to use it

1. Enable the base module plus the submodule for your entity type (see
   [Installation](installation/index.md)).
2. Edit the content item you want to protect. In the **TCA** fieldset, tick
   **TCA Active**. A token is generated automatically when you save.
3. Optionally tick **TCA Public** so a correct token lets anyone view the item,
   even if it is unpublished or otherwise restricted.
4. Save, then share the item's URL with `?tca=<token>` appended. Only that link
   works; regenerating the token instantly invalidates any links you shared
   before.
