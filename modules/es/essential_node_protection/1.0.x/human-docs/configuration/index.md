# Configuration

Essential Node Protection protects all three essential pages by default, so you
only need this form if you want to change which slots are guarded.

## Open the settings form

1. Log in as a user with the **Administer essential node protection configuration**
   permission (an administrator by default).
2. Go to **Configuration → System → Essential Node Protection**, or navigate
   directly to `/admin/config/system/essential-node-protection`.

## The settings

The form gives you three independent checkboxes, one per essential slot. Each is
**on** by default:

- **Protect the front page** — forbids deletion of the node configured as your
  site's front page.
- **Protect the 403 (access denied) page** — forbids deletion of the node
  configured as your 403 page.
- **Protect the 404 (not found) page** — forbids deletion of the node configured as
  your 404 page.

Tick a box to protect that slot; untick it to allow that page's node to be deleted
again. Which node each slot refers to comes from your site's path settings
(**Configuration → System → Basic site settings**), so the protection always
follows whatever node is currently assigned to that role.

## Save

Click **Save configuration**. Your changes apply immediately.

> **Tip:** If you later change *which* node is the front / 403 / 404 page, clear
> caches (`drush cr`) so the delete protection is recalculated for the newly
> assigned node — a previously cached "allowed to delete" result could otherwise
> linger briefly until caches are cleared.
