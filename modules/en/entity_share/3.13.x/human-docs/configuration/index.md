# Configuration

Configuring Entity Share means setting up the server side (what content to expose),
the client side (where to pull from and how to import), and then running a pull.
This page follows that flow. Everything is managed under **Configuration → Web
services → Entity Share** (`/admin/config/services/entity_share`), with the pull
itself under **Content → Entity Share**.

## On the server: create a Channel

A **Channel** exposes one set of content — an entity type, bundle, and language — as
a JSON:API collection that clients can read.

1. On the server site, with **Entity Share Server** enabled, go to **Configuration →
   Web services → Entity Share → Channels** and add a channel.
2. Set:
   - **Label** — a human name for the channel.
   - **Entity type** and **Bundle** — the content to expose, e.g. *Content (node)* /
     *Article*.
   - **Language** — the language of the content to expose.
   - **Filters, sorts, and groups** *(optional)* — JSON:API conditions to narrow and
     order what the channel returns (for example only published content, or content
     with a given taxonomy term), and a maximum page size.
3. Control **who may read the channel**:
   - **Authorize by permission** — allow any user holding the pull permission, or
   - **Authorized roles / users** — restrict the channel to specific roles or
     specific users.
4. Save. Repeat for each set of content you want to share.

## On the client: create a Remote

A **Remote** tells the client which server to connect to and how to authenticate.

1. On the client site, with **Entity Share Client** enabled, go to **Configuration →
   Web services → Entity Share → Remotes** and add a remote.
2. Set:
   - **Label** — a name for this connection.
   - **URL** — the base URL of the server site, e.g. `https://hub.example.com`.
   - **Authorization** — how to authenticate to the server. The options are:
     - **Anonymous** — no credentials (only works for channels the server exposes
       publicly).
     - **HTTP Basic** — a username and password.
     - **Request header** — a header/API key.
     - **OAuth2** — OAuth authentication (pairs with Simple OAuth on the server).
3. For anything other than Anonymous, store the credentials securely. Entity Share
   integrates with the **Key** module, so you point the remote at a Key entity that
   holds the secret rather than typing it into plain config.
4. Save.

## On the client: create an Import config

An **Import config** describes *how* pulled content is created and updated on the
client. It is a pipeline of **import processors**, each handling one aspect of the
import.

1. Go to **Configuration → Web services → Entity Share → Import config** and add one.
2. Give it a **Label** and a maximum import page size.
3. Enable and order the **import processors** you need. Common ones include:
   - **Default data** — the core import **policy** and update policy (for example,
     whether pulled content is published immediately or held for review).
   - **Entity reference / embedded entity importer** — also import referenced
     entities, up to a configured **recursion depth**.
   - **Physical file** — import the actual image/document files behind media and file
     references.
   - **Revision** — create new revisions and preserve translation-affected flags.
   - **Language fallback** — provide a fallback language when a translation is
     missing on the client.
   - **Path alias** and **internal link importers** — bring over URL aliases and
     rewrite internal links to point at the local copies.
4. Save.

## Pull content

With a remote, a channel to read, and an import config in place:

1. On the client, go to **Content → Entity Share** (`/admin/content/entity_share`).
2. Choose the **remote**, the **channel** to read, and the **import config** to
   apply.
3. Select the entities you want and **pull** them. The client fetches them over
   JSON:API and creates or updates the local entities per your import processors.

You can also run pulls from the command line (or cron) with the client's Drush
commands — run `drush list --filter=entity_share` on the client to see the exact
command names installed.

## Permissions

Entity Share defines a number of permissions across the base module and submodules —
for example *administer channel entity* (server), *administer remote entity* and
*administer import config entity* (client), and *pull content* (client). Grant them
at **People → Permissions** to the roles that manage sharing and run pulls.

## Optional extras

- **Entity Share Async** — queue large imports so they run in the background rather
  than in one long request.
- **Entity Share Lock** — lock imported content on the client so local editors do not
  accidentally overwrite synced content.
- **Entity Share Diff** — review a field-by-field diff of local vs remote before you
  import.

## A note on testing

Creating and inspecting channels, remotes, and import configs works on a single
site. But an actual pull needs a reachable second Drupal site running Entity Share
Server, so plan to test the full flow against two environments.
