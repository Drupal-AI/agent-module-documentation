# Configuration

Announcement Modal has one settings form and one block. Setting it up is a matter
of writing the announcement, switching it on, and choosing where the modal
appears.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (or the
   module's own **Administer announcement modal configuration** permission).
2. Go to **Configuration → Announcement Modal**, or navigate directly to
   `/admin/config/announcement_modal`.

On this form you enter the announcement content and use the toggle to turn the
announcement on or off. Your changes save into configuration and — because the
page is marked "no cache" — take effect immediately.

> The announcement content is shown to every visitor exactly as you enter it, so
> only enter markup you trust.

## Place the Announcement block

The modal is rendered by a block, so it only appears once the block is placed in a
region:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find a region (for example *Header* or *Content*) and click **Place block**.
3. Choose the **Announcement** block and save.

The modal then opens on page load for visitors, following the CSS/JS behaviour the
module ships. If a change to the styling or script does not appear, clear the site
cache.

## Delegating to editors

Grant the **Administer announcement modal configuration** permission (under
**People → Permissions**) to editors who should manage the notice without having
full site‑configuration rights.
