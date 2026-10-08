# Configuration

Webform Encrypt has no settings form of its own. You configure it in two places:
once per site you create an **encryption profile**, then per element you flip on
the **Encryption** option. A single permission decides who can read the decrypted
values.

## Step 1 — Create an encryption profile

Encryption is done by an **Encrypt**-module *encryption profile*, which in turn
points at a **Key**. If no profile exists yet, the Encryption section on a webform
element shows the message *"Please configure the encryption profile to enable
encryption for the element."*

Create one at **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`). You will pick an encryption method
and a key. (Storing the key with the Key module's environment or file provider,
rather than in the database, keeps it out of your configuration exports — see the
site's own key-management guidance.)

## Step 2 — Turn encryption on for an element

1. Edit the webform and open the element you want to protect — on the **Build** tab,
   click the element's **Edit**.
2. Switch to the element's **Advanced** tab and find the **Encryption** section.
3. Tick **Encrypt this field's value** and choose an **Encryption Profile**.
4. Save the element, then save the webform.

Only **input** elements (text fields, textareas, and the like) offer the Encryption
section — markup and layout/container elements do not, because they hold no
submitted value. You can encrypt a different set of elements on each webform, and
even use a different profile per element if different data classes need different
keys.

An important detail: turning encryption on affects **new** submissions saved after
the change. Existing rows keep their current form until they are re-saved.

## Step 3 — Grant the permission that reveals values

The module defines exactly one permission:

| Permission | What it controls |
|---|---|
| **View Encrypted Values in Webform Results** (`view encrypted values`) | Whether a user sees decrypted submission values, and whether they may edit submissions that contain encrypted elements. |

- **Without** the permission, every encrypted value is shown as the literal text
  `[Value Encrypted]` — in results tables and on the submission view — and the user
  is **not allowed to edit** any submission that contains an encrypted element.
- **With** the permission, values are decrypted and shown normally, and editing is
  allowed.

Grant it only to trusted roles, at **People → Permissions**
(`/admin/people/permissions`), or from the command line:

```bash
drush role:perm:add trusted_staff 'view encrypted values'
```

There is no separate "administer" permission for this module — enabling encryption
on an element only requires the standard Webform permission to administer webforms,
since the setting is stored on the webform itself.

## How it behaves at a glance

- Values are encrypted when a submission is saved and decrypted when it is loaded
  (for permitted users), so multi-step wizards and normal form logic keep working.
- Each encrypted value remembers which profile encrypted it, so you can change an
  element's profile later without losing the ability to decrypt older data.
- Uninstalling the module first decrypts every stored value back to plain text, so
  removing it never leaves unreadable data behind.
