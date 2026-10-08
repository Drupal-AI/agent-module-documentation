# Configuration

Secure Nodes works immediately for the **Article** content type. Everything on this
page is about extending that protection to other content types and managing who can
use it.

## Choose which content types can be protected

1. Log in as an administrator.
2. Go to **`/admin/config/content/secure_nodes`** (Configuration → Content →
   Secure Nodes).
3. Select the content types you want to make protectable — Article is enabled by
   default, and you can add any others (Basic page, and your own custom types).
4. Save.

Once a content type is enabled here, its add/edit form gains the **"Protect this
Node?"** checkbox in the sidebar, and its nodes become eligible for the protect/
unprotect bulk actions.

## Protecting and unprotecting nodes

There are two ways to mark content as protected:

- **One node at a time** — edit the node and tick **"Protect this Node?"** in the
  sidebar, then save. Untick it to remove protection.
- **In bulk** — go to the content listing (`/admin/content`), select the nodes, and
  choose the **Protect content** action (or **Unprotect content** to reverse it).

Protected nodes resist deletion, including through the core *Delete content* bulk
operation.

## Reviewing what is protected

Open the **Protected Nodes** tab next to **Content** (`/admin/content`). It lists every
node currently marked as protected, so you can audit exactly what is locked down.

## Permissions and coverage

- The **protect / unprotect** actions are gated by the permissions this module
  provides. Grant them only to trusted administrators under **People → Permissions**,
  so ordinary editors cannot silently unprotect critical content.
- Protection is enforced on the edit and delete flows, including bulk delete. For your
  particular site, it is worth confirming the guard also covers any programmatic or
  API-driven deletions you rely on before treating a node as fully un-deletable.
