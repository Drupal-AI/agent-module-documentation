# Configuration

Content Access by Path works by giving each editor a **taxonomy field on their user
account** that lists the site sections (path prefixes) they're allowed to edit. The
module then uses Drupal's access layer to allow editing of content whose URL alias
falls under one of those sections — plus content the editor authored (see below).

## Who can configure it

The settings form (route `content_access_by_path.settings`, under the site's
**Configuration** area) is gated by the **"Administer content access by path"**
permission — spelled with spaces and capitalised exactly as shown. Grant it only to
trusted administrators.

## Setting up sections and editors

1. **Define the sections** as the path prefixes teams should own — for example
   `/news`, `/news/sports`, `/news/sports/rugby`. These are represented as taxonomy
   terms used by the module's user field.
2. **Assign an editor to one or more sections** by setting the taxonomy field on
   their **user account** (People → the user → edit). An editor with the `/news`
   section can edit content whose alias begins with `/news`.
3. **Test the result** by logging in as that editor and checking exactly which nodes
   they can and cannot edit — across the rendered site *and* any API surface
   (JSON:API/REST/Views), since the module enforces through the real access layer.

## How matching works — things to keep in mind

Configure the module with these behaviours in mind:

- **A user with an empty section field is not restricted** — the module only narrows a
  user once at least one section is assigned. Assign sections to exactly the editors
  you want scoped.
- **Editors can always edit content they authored.** This is by design (so a wrong
  alias never locks an author out of their own node). If you don't want a role editing
  its own past content, keep that behaviour in mind when granting the role.
- **Sections are matched as path prefixes** — a `/news` section covers every node
  whose alias begins with `/news`. Choose section paths and aliases so that a prefix
  maps to exactly the branch you mean to delegate.
- **Matching uses the node's URL alias.** A node's section follows its alias, so keep
  control of who can edit aliases when you rely on sections to route editing.

## Caching

The module sets cache metadata deliberately (the user, the node, and each section
term as dependencies, with `user` and `user.permissions` cache contexts), so access
decisions update correctly when those change.
