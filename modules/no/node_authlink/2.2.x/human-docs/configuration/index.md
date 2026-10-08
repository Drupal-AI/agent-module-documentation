# Configuration

Node Authorize Link has no central settings page. You enable it per content type on that type's
edit form, then mint links per node. This page walks through both, the permissions, and — since
these links are access credentials — the security model in full.

## 1. Enable authlinks for a content type

1. Log in as a user with the **Configure node_authlink module** permission (in practice, someone
   who administers content types).
2. Go to **Structure → Content types → [your type] → Edit**
   (`/admin/structure/types/manage/{type}`).
3. Find the **Node authorize link** section and configure:
   - **Enable** — turns authlinks on for this content type. (Un‑ticking this later and saving
     **erases all keys** for this type's nodes.)
   - **Grants to give** — checkboxes for which operations a valid key authorizes: **view**,
     **view revision**, **update** (edit), and **delete**. Tick only what you need — see the
     security note about how all enabled operations share one key.
   - **Regenerate authkeys after** — how old a key may get before cron rotates it: disabled
     (never), 1 day, 1 week, 4 weeks, 3 months, 6 months, or 1 year. Rotating keys bounds how long
     a leaked link stays valid; the default is never.
   - **Generate authkeys** *(batch button)* — creates keys for all existing nodes of this type
     that don't have one. Save the form first.
   - **Delete all authkeys** *(batch button)* — deletes every key for this type. Save the form
     first.
4. Save the content type.

## 2. Create and copy a node's links

Keys aren't created automatically when a node is added — you mint them per node:

1. Open the node, then its **Authlink** tab (`/node/{node}/authlink`). This requires the content
   type to be authlink‑enabled and the user to hold a create/delete permission (below).
2. Click **Create authlink**. The page then lists ready‑made links for each enabled operation —
   the current revision's view link, links to other revisions, the edit link, and the delete link
   — each already carrying `?authkey=<key>`.
3. Copy the link you want and share it with the intended recipient. To revoke access, come back
   and click **Delete authlink** (or delete it from the audit view below); regenerate a fresh key
   if you want a new link.

## 3. Put links in emails or fields (tokens)

When a node has a key, these tokens are available on the `node` token type:

- `[node:authlink:view-url]` — absolute view URL with the key.
- `[node:authlink:edit-url]` — absolute edit URL with the key.
- `[node:authlink:delete-url]` — absolute delete URL with the key.
- `[node:authlink:authkey]` — the raw key.

Use them in notification emails, fields, or blocks to hand each recipient a personalized,
node‑scoped link. Remember that anywhere one of these renders, it embeds a live access credential.

## 4. Audit and revoke

A bundled view, **node_authlinks**, lists every issued key with a *Delete Authlink* link, so you
can review and revoke links site‑wide from one place.

## 5. Permissions

Grant these under **People → Permissions** (`/admin/people/permissions`):

- **Configure node_authlink module** — access the *Node authorize link* section on the
  content‑type edit form (enable, grants, rotation, and the bulk generate/delete buttons). This
  sits alongside administering content types, so grant it only to those trusted roles.
- **Create and delete node authlinks** *(restricted permission)* — mint or delete a key for **any**
  node, via the per‑node Authlink tab and the audit view. Whoever holds this can hand out
  anonymous view/edit/delete access, so treat it as a trusted capability.
- **Create and delete node <type> authlinks** — the same capability, but scoped to a single content
  type. A per‑type version of this permission is generated for each content type.

Note that the visitor who *uses* a link needs **no permission at all** — the key itself is the
credential.

## Security model — read before sharing links

The token itself is strong: a 256‑bit value from a cryptographic random source, unique per node,
so it can't be guessed, forged, or enumerated. The risks to manage are operational:

- **Scope is what you granted.** A link authorizes only the operations you enabled for the content
  type, and those default to none until you tick them. But the **same key authorizes every enabled
  operation** — there is no separate key per operation — so if edit and delete are enabled, a
  "view" link you share is *also* the edit and delete link. Enable only the operations you actually
  intend to expose.
- **Publish status is not checked.** A valid key grants the configured operation whether or not the
  node is published — that's the whole point of a preview link. Treat any leaked link as full
  (configured) access to that node.
- **The key travels in the URL.** Because it's in the `?authkey=` query string, it can leak through
  web‑server logs, browser history, and `Referer` headers sent to third‑party assets. Share links
  through private channels and be mindful of where recipients might paste them.
- **Keys are permanent by default.** Set **Regenerate authkeys after** to a sensible interval to
  bound how long any given link stays valid, and delete a node's key when the sharing is done.

Used deliberately — minimal grants, private sharing, and rotation — Node Authorize Link is a
convenient way to grant scoped, login‑free access to individual nodes.
