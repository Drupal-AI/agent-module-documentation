# Configuration

Setting up the Consumer is a short sequence: connect to the remote server, map its
entities to local types, then use them. This assumes the **External Entity Server**
module is already installed and exposing a resource on the remote Drupal site.

## 1. Add a connection

1. Go to **Configuration → Web services → External Entity → Connection**
   (`/admin/config/services/external-entity/connection`).
2. Add a connection to your External Entity Server: provide the server's **domain**
   and specify an **authentication method** if the server requires one.
3. Supply any credential through the **Key** module or an environment variable
   rather than typing a raw secret into the form, and prefer **HTTPS** for the
   connection.

## 2. Define external entity types

1. Go to **Structure → External entity**
   (`/admin/structure/external-entity/type`).
2. Map an external entity to a local Drupal entity/content type — for example, map
   the remote **News** node type to a local **News** content type.
3. Use the type's **Manage display** to map remote fields to local fields (for
   example `title → title`, `field_tags → field_tags`).

## 3. Use the external entities

Once a type is defined, remote content can be used in two ways:

- **Entity reference** — use the External Entity reference field to render remote
  content through a chosen **view mode**, just like referencing local content.
- **Views** — build External Entity Views to list and filter remote content with
  the standard Views UI, choosing a view mode for rendering.

## A note on access and privacy

Remote content is fetched live and rendered locally. Make sure the connection
targets a **trusted** server, keep credentials secret, and configure access so that
sensitive remote content is not exposed on the consuming site more broadly than
intended.
