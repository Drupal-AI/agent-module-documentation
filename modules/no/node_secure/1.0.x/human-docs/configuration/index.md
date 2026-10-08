# Configuration

Node Secure has a single, simple configuration step: choosing which content types
should be protected from deletion.

## Open the configuration form

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Node Secure**, or navigate directly
   to `/admin/config/content/node-secure`.

## Select the protected content types

The form lists your site's content types as checkboxes. Tick every content type
whose nodes should be protected from deletion, then click **Save**.

The moment you save:

- The **Delete** tab is removed from every node of the protected types.
- The **Delete** button is removed from those nodes' edit forms.
- Delete operations are blocked from the administrative content listing
  (**Content**).
- Bulk operations cannot delete protected nodes.
- Direct access to a protected node's deletion route is denied.

Because enforcement runs through Drupal's node access system, these are genuine
access denials, not just hidden links — a protected node cannot be deleted through
the UI, bulk actions, direct URLs, or programmatic paths that respect node access.

## Changing what is protected

Configuration changes take effect dynamically. Untick a content type and save to
allow its nodes to be deleted again; tick a new one to lock it down. There is
nothing to rebuild and no cache to clear manually.

## What this does *not* do

- It protects **whole content types**, not individual nodes. To protect a single
  node while leaving its siblings deletable, use a per‑node tool such as Node Keep
  instead.
- It only prevents **deletion** — editing of protected nodes is unaffected.
- It does not archive or back up content; pair it with your normal backup and (if
  needed) editorial‑workflow modules.
