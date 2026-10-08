# Author Bulk Assignment — manual setup guide

**Author Bulk Assignment** (`author_bulk_assignment`) adds a Views bulk
operation that reassigns the author of the content you select to a different
account. You tick the rows you want in a View of content, choose the bulk
action, pick the new author, and every selected node's authorship is rewritten
in one pass.

The need usually arrives with a departure. Someone leaves, their account has to
be blocked or removed, and hundreds of nodes still name them as author. Deleting
the account offers only the blunt option of handing everything to *Anonymous*,
which loses the record entirely. Reassigning deliberately to a named successor
or an archive account keeps the content editable and its history honest. The
same operation covers a reorganisation, a migration that landed everything under
one account, or a section handed from one team to another.

Because this is a bulk write with real consequences, three things are worth
holding in mind before you run it. The byline is published, so reassigning
changes what readers are told about who wrote something — an editorial (and
sometimes ethical) decision rather than plain data cleanup. Revisions carry
their own author, so reassigning a node does not rewrite its history; the
departed user stays in the revision log. And "own content" permissions follow
the change, so the new author gains edit and delete rights over everything you
reassign — which is the point, and worth checking against whose account that is.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the permissions it adds and how to
   run the bulk operation from a View.

## Where it lives in the admin menu

The module adds a **bulk operation**, so it shows up wherever content is listed
in a View that has a bulk-operations field — most commonly the
**Content** admin listing at **Content** (`/admin/content`). Select the rows you
want, then choose the "assign author" action from the bulk-actions dropdown and
apply it. Access is gated by the `assign author to selected content` permission,
with a separate administrative permission for the module's settings.
