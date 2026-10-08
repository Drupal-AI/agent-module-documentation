# Configuration

Media Entity PodToo has a small site-wide settings form. The options here apply
globally to **all** PodToo media on the site, not per media item.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → PodToo**, or navigate directly to
   `/admin/config/media/podtoo`.

## Site-wide display settings

- **Display size** — the dimensions at which the PodToo player is rendered.
- **Player color** — the player's background/accent color, applied to every
  embed.

These settings are appended to the request the module makes to PodToo when
resolving an embed, so changing them affects how all PodToo players look across the
site.

## Optional: forwarding viewer information to PodToo

The form also includes an **opt-in privacy setting**. You can choose to send the
current user's information to the PodToo endpoint as part of the embed request:

- the **username**,
- the **email address**, and/or
- the **user ID (uid)**.

This is **off by default**, and it is a genuine privacy consideration: enabling any
of these forwards identifying information about your logged-in visitors to a
third-party service every time a PodToo player is displayed. Turn it on only if you
have a clear reason and it is compatible with your site's privacy policy and any
applicable data-protection rules.

## Permissions

The **Administer site configuration** permission controls who can change this
form. Who can create, edit and delete PodToo media is controlled separately through
the standard per-media-type permissions at **People → Permissions**
(`/admin/people/permissions`) — grant those to the roles that should manage PodToo
content.

## Save

Click **Save configuration**. The display size and color take effect for all PodToo
media immediately.
