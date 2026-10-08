<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Everything happens under **Structure → Custom Tokens**
(`/admin/structure/token-custom`). There is no global settings form — you simply
create tokens and, optionally, token types.

## Permissions first

Custom Tokens adds three permissions (**People → Permissions**):

- **Administer custom tokens** — create, edit, and delete tokens. This is
  security-sensitive because a token's content is rendered through a text format
  and can contain HTML, so grant it only to trusted roles.
- **Administer custom token types** — create, edit, and delete token *types*
  (the groups). Also trust-sensitive.
- **Access custom tokens overview** — view the tokens listing page without full
  admin rights (read-only).

## Add a token

1. Go to **Structure → Custom Tokens** and click **Add Token**.
2. **Name** — the human-readable admin label for the token.
3. **Machine name** — the id used in the token itself (up to 64 characters,
   lowercase letters, numbers, hyphens, and underscores). This becomes the part
   after the colon: `[custom:this_machine_name]`.
4. **Token Type** — pick which type this token belongs to. The default is
   **custom**. The type's machine name is the part *before* the colon.
5. **Content** — the value the token expands to, edited with a text format
   selector. Choose a plain-text format for simple values, or a rich-text format
   if you want the token to output HTML.
6. **Description** *(optional)* — a note explaining what the token is for; it
   shows in the Token browser.
7. Click **Save**.

Your token now resolves as `[<type>:<machine_name>]` — for example
`[custom:company_name]` — anywhere Drupal accepts tokens.

> **A note on formatting:** the content is run through the text format you pick.
> A plain-text format wraps the value in a `<p>…</p>` paragraph, so if you need
> the raw value with no wrapper, choose an appropriate format.

## Add a token type

Token types let you group related tokens (for example an `department` type for
org-chart data).

1. On the **Custom Tokens** page, open the **Custom Token Types** tab
   (`/admin/structure/token-custom/type`).
2. Click **Add Token Type**.
3. Enter a **Name** and a **Machine name** (and an optional description).
4. Click **Save**.

New types become usable immediately — the module rebuilds its internal list of
valid types automatically, so tokens under a brand-new type resolve without a
manual cache clear.

## Editing, deleting, and translating

- Edit a token from its row on the overview page, or at
  `/admin/structure/token-custom/manage/{id}/edit`.
- Delete from the same row, or at `.../manage/{id}/delete`.
- Because tokens are translatable content entities, you can provide a per-language
  value using Drupal's normal translation workflow, and the token resolves to the
  value for the current language.

## A note on exporting

Token **types** are configuration and export with your site config
(`token_custom.type.<machine_name>`). The **tokens** themselves are content
entities, not configuration — they do not appear in a config export. Move them
between environments with a default-content mechanism or an update hook rather
than `config/install`.
