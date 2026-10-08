# Configuration

Simple Access is configured in two places: you create **access groups** on the
module's admin page, and then you assign individual **nodes** to those groups from
the node edit form.

## Create access groups

1. Log in as a user with the module's administration permission (an administrator
   by default). Simple Access provides its own permissions — review them at
   **People → Permissions** and grant them deliberately, since they govern who can
   manage access restrictions.
2. Go to the Simple Access administration page (the `simple_access.admin` route).
3. Create an **access group** and give it a name that describes the audience — for
   example *Coaches*.
4. Assign one or more **roles** to the group. Everyone who has any of those roles
   becomes a member of the group. Using the earlier example, you might add *Coach
   Level 1*, *Coach Level 2*, and *Coach Level 3* to the *Coaches* group.
5. Save.

You can create as many groups as you need, each mapping a set of roles to an
audience you want to grant access to.

## Assign nodes to groups

Once groups exist, restrict a node by assigning it:

1. Edit the node you want to make private.
2. Open the **Access** section on the node add/edit form.
3. Choose which access group(s) may **view**, **edit**, and/or **delete** the
   node. Simple Access lets you control these three capabilities independently, so
   you can, for instance, let a group view a node without being able to change it.
4. Save the node.

A node with no group assigned stays viewable by everyone. A node becomes private
only for the capabilities you restrict — so assigning a view group hides it from
everyone outside that group in listings, search, and on the page itself, because
the restriction is enforced through Drupal's node-grants system at the query
level.

## Test your setup

Node-access rules are easy to get subtly wrong, so always verify. Log in (or use a
second browser) as a user who *should* have access and confirm they can see or
edit the node, then as a user who should *not* and confirm the node is absent from
listings and search as well as its own page. If restrictions do not seem to take
effect, clear caches and rebuild node access permissions from the status report.
