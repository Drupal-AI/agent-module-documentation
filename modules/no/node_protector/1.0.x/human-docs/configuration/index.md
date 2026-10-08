# Configuration

Node Protector needs to know *which* node to guard. You have two options, and you
can use either.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Node Protector**, or navigate directly to
   `/admin/config/system/node_protector/settings`.

## Choose what to protect

- **Protected node ID (NID)** — enter the numeric node ID of the single node you
  want to protect. You can find a node's ID in its edit URL (for example
  `/node/12/edit` means the NID is `12`). Only one NID is protected at a time;
  change this value to move protection to a different node.
- **Automatically protect the front page** — a toggle. When enabled, Node
  Protector looks up whatever node is configured as the site's front page (Drupal's
  `system.site` front‑page setting) and protects *that* node, following the front
  page automatically if you later point it at a different node.

Click **Save configuration** to apply.

## How protection behaves

When anyone — including an administrator — attempts to delete the protected node,
Node Protector shows a warning message, redirects to the node's own page, and stops
execution so the delete is never carried out. Because the guard runs before the
delete and does not rely on user permissions, it protects the node regardless of
who is trying to remove it, and you do not need to rebuild content permissions
after enabling it.

## Good to know

- Protection covers **one node** at a time (plus the front page, if the automatic
  option is on) — it is not a per‑content‑type or multi‑node guard.
- It is a delete guard, not a backup. Keep your normal backups; Node Protector
  simply removes the most common way a critical landing node gets destroyed by
  accident.
