# Configuration

There are two setup steps: enable the text-format filter on the formats your body
fields use, and choose which content types the module rewrites links for. You also
need to grant reviewers the right per-bundle permission.

## 1. Enable the text filter

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the text format your body content
   uses (for example *Full HTML*).
2. Under **Enabled filters**, tick **Access Unpublished Linked Nodes**.
3. It is a reversible transform filter and should generally run **late** in the
   order, so if you arrange filter weights, place it near the end.
4. Save the format.

## 2. Choose the processed content types

1. Go to **Configuration → Content authoring → Access Unpublished Linked Nodes**
   (`/admin/config/content/access-unpublished-linked-nodes`). This form needs the
   **Administer site configuration** permission.
2. Tick the content types whose links should be rewritten during preview.
3. Save.

If you leave nothing selected, the module falls back to processing the
`landing_page` and `page` content types by default.

## 3. Grant the minting permission

For each bundle a reviewer should be able to mint token links for, grant the
per-bundle **`access unpublished node <bundle>`** permission (at
**People → Permissions**). Without it, the module will not generate token URLs for
that bundle.

## How preview works

1. A reviewer opens an unpublished node with a valid `?auHash=<token>` — an Access
   Unpublished token.
2. The module validates that token. If it is valid, the page is marked as an
   authorized preview (a CSS class `access-unpublished-pass` is added and the
   module's library attached).
3. The filter validates the token again and rewrites `<a data-entity-uuid>` links
   that point at *unpublished* nodes so their `href` becomes that node's token URL
   — so clicking through keeps the preview session alive.
4. With `embed_block` installed, embedded custom blocks render their latest
   revision during the preview.

## Security notes

- The module **never bypasses Access Unpublished**. If the token is absent or
  invalid, no rewriting happens and no draft is exposed.
- Rewriting runs **only** for low-privilege roles (`anonymous`, `authenticated`,
  `viewer`); editors and other roles are skipped by design, so their normal
  editing experience is unaffected.
- Because token URLs are built from Access Unpublished's tokens, the security of
  this feature rests on those tokens remaining unguessable.
