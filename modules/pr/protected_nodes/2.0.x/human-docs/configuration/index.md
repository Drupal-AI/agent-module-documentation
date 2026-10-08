# Configuration

Setting up Protected Nodes is a short sequence: decide which content types can be
protected, grant the right permissions, put the protection control on the node form,
and then protect individual nodes.

## 1. Choose which content types support protection

In the module's settings, enable node protection for the content types you want. This
makes the per‑node "Protected" control available on those types; types you don't enable
are unaffected.

## 2. Set the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and grant the module's
permissions to the appropriate roles. Keep these tight — protection is only as trusted
as the people who can turn it on and off:

- The permission to mark content types as supported / administer the module — grant to
  administrators only.
- The permission to set or unset the "Protected" state on an individual node — grant to
  the editors you trust to gate content. The per‑node control is only visible to users
  who hold this permission.

## 3. Add the protection control to the node form

For each supported content type, place the "Protected" widget on the node form via
**Structure → Content types → *(type)* → Manage form display**. This is what lets a
permitted editor mark a node as protected and set its password while editing.

## 4. Protect an individual node

Edit a node of a supported type. If you have the right permission, you'll see the
"Protected" control on the form — turn it on and set the password. From then on,
visitors who reach that node see a password form until they enter the correct password.

## Things to keep in mind

- The password is **shared** — everyone who unlocks the node uses the same one. Rotate
  it periodically, and don't lean on it for content that really needs role‑based
  access control.
- Protecting a node does **not** automatically protect its files if they live in the
  public file system, since those files have their own public URLs. Use the private
  file system for attachments that must stay gated.
