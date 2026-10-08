# Configuration

Configuring LocalGov KeyNav has two parts: deciding **who** may use the keyboard
shortcuts (permissions), and optionally **adding your own** key sequences on the
settings form. Individual users then have the final say through a per-user opt-out.

## Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and set two permissions:

- **Use LocalGov keynav** — users in a role with this permission receive the shortcut
  library and can navigate by key sequences (unless they have opted out — see below).
  Nobody gets shortcuts until you grant this.
- **Add LocalGov Keynav shortcuts** — required to reach and edit the settings form.
  Grant it only to administrators who should manage the shortcut patterns.

## Open the settings form

1. Log in as a user with the **Add LocalGov Keynav shortcuts** permission.
2. Go to **Configuration → User interface → LocalGov KeyNav**, or navigate directly to
   `/admin/config/user-interface/localgov-keynav`.

## Custom key sequences

The main setting on the form is **custom key-sequence patterns** — a textarea where an
administrator can define additional key sequences and the destinations they map to,
on top of the default sequences that ship with the module. Add your patterns here and
save; the settings are pushed to the browser and take effect for permitted users.

Default sequences are provided by the module out of the box, so KeyNav is useful even
if you never add a custom pattern.

## The per-user opt-out

Enabling the shortcuts for a role does not force them on every member of that role.
Each user account has a **LocalGov KeyNav** checkbox on their profile: when a user
ticks it, KeyNav is disabled for that user, and the shortcut library is no longer
attached for them. This lets people who rely on assistive technology or prefer their
own keyboard habits turn the feature off without affecting anyone else. The visibility
of this field is itself limited to users who have the *Use LocalGov keynav*
permission.

## Save

Click **Save configuration** on the settings form. Changes take effect the next time a
permitted user loads a page.
