# Configuration

Author Bulk Assignment has very little to configure — its value is the bulk
operation itself. The main things to set up are the permissions that decide who
can reassign authorship, and knowing where to run the action.

## Permissions

The module adds two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **`assign author to selected content`** — lets a role use the bulk operation
  to reassign content authorship. Grant this only to roles you trust to change
  bylines and hand over edit/delete rights, because the new author gains "own
  content" access to everything reassigned.
- A separate **administrative permission** governs the module's own settings
  form (config object `author_bulk_assignment.settings`).

## Run the bulk operation

1. Go to a View of content that has a bulk-operations column — the built-in
   **Content** listing at **Content** (`/admin/content`) is the usual place.
2. Tick the checkboxes for the nodes whose author you want to change.
3. From the action dropdown, choose the "assign author" bulk action and select
   the destination account.
4. Apply the action. Every selected node's author is rewritten to the account
   you chose.

## Before you run it

- **The byline is published.** Reassigning changes what readers are told about
  who wrote each item — an editorial decision, not just a data fix.
- **Revisions keep their own author.** The node's current author changes, but its
  revision history still shows the original author. That is usually correct, but
  worth knowing before anyone assumes the history was rewritten too.
- **"Own content" permissions follow the change.** The new author can now edit
  and delete everything you reassigned. Make sure that account is the right one.
- Reassigning to a named successor or an archive account is almost always better
  than letting a deleted account dump its content onto *Anonymous*, which loses
  the attribution entirely.
