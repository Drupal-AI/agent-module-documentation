# Configuration

## Before you start

- Make sure **Linkit** and **Node** are enabled.
- Make sure the `ezyang/htmlpurifier` library is installed (see
  [Installation](../installation/index.md)) — SafeDelete relies on it to parse
  links out of body fields.

## Open the settings form

Go to **Configuration → Development → SafeDelete**
(`/admin/config/development/safedelete`, config route `safedelete.settings`). You
need the **SafeDelete administration** permission to reach it.

## Settings, field by field

- **Protected content types** — enable or disable SafeDelete's guard **per
  bundle**. SafeDelete only checks the content types you tick here, so nothing is
  protected until you turn it on for at least one type.
- **Record limit** — how many referencing records to list on the node delete form.
  Useful when a node is linked from a great many places and you do not want an
  unwieldy list; SafeDelete shows up to this many.
- **Disable the delete button for dependent content** — when enabled, the delete
  button is hidden entirely for a node that other content links to. Users who hold
  the **SafeDelete show delete button** permission still see it, so trusted roles
  can override the block when they genuinely need to.

## How the protection behaves

Once configured, SafeDelete acts automatically. When someone tries to **delete** a
guarded node — or change it into an **archived** moderation state — the module
checks whether the node is linked from other nodes' body fields via Linkit. If it
is, the operation is blocked and the referencing content is listed so the editor
can fix or repoint those links first.

## Orphaned-node reports

SafeDelete can also surface content that nothing links to:

- **Generate the report** at `/admin/content/safedelete-orphanedpages` — requires
  the **SafeDelete create orphans report** permission.
- **View the report** at `/admin/content/safedelete-orphanedpages/viewreport` —
  requires the **SafeDelete view orphans report** permission.

## Permissions summary

All of SafeDelete's routes and controls are permission-gated:

| Permission | What it allows |
|---|---|
| **SafeDelete administration** | Reach and change the settings form |
| **SafeDelete create orphans report** | Generate the orphaned-nodes report |
| **SafeDelete view orphans report** | View the orphaned-nodes report |
| **SafeDelete show delete button** | Still see the delete button on dependent content when it is otherwise hidden |
