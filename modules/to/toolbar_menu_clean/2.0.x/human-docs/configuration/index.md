# Configuration

Toolbar Menu Clean has no settings form. You configure it entirely through **permissions** —
each of the three toolbar elements it manages is tied to one permission. The logic is
**opt-in**: a role that *has* a permission keeps the corresponding element; a role that
*lacks* it has that element hidden or removed.

## Assign the permissions

1. Log in as an administrator and go to **People → Permissions**
   (`/admin/people/permissions`).
2. Find the three Toolbar Menu Clean permissions and tick them for the roles that should keep
   each standard toolbar element.
3. Save.

## The three permissions

| Permission | Grant it to a role to… | Leave it off to… |
|---|---|---|
| **Show Administration menu in the toolbar** | keep the full core Administration ("Manage") tray | hide the Manage tray. (It is hidden with CSS rather than fully removed, and any still-visible child menu items keep working — the toolbar tree behaviour is re-attached.) |
| **Show Shortcut menu in the toolbar** | keep the Shortcuts tab | remove the Shortcuts tab entirely from the toolbar. |
| **Show Edit button in the toolbar** | keep the contextual **Edit** (pencil) button | remove the Edit button. (This only matters for users who also have core's *access contextual links* — without that, there is no Edit button to begin with.) |

## Typical setup

- **Administrators:** grant all three, so they see the standard, complete toolbar.
- **Editors / clients with a custom Toolbar Menu:** leave all three off, so the Manage tray,
  Shortcuts, and Edit button disappear and your curated Toolbar Menu becomes the primary
  navigation. Grant just the ones you want back — for example only *Show Shortcut menu in the
  toolbar* if power users should still manage shortcuts.

You can do the same from the command line, for example:

```bash
# Let the "editor" role keep the standard Shortcuts tab but nothing else.
ddev drush role:perm:add editor 'show shortcut menu in the toolbar'
```

## Remember: this is presentation only

Hiding these elements does **not** revoke the underlying access. A user whose real
permissions include *access administration pages*, *access shortcuts*, or *access contextual
links* can still reach those routes directly by URL — the toolbar simply won't advertise
them. Use Toolbar Menu Clean to declutter the interface, and rely on ordinary Drupal
permissions for actual access control.
