# Configuration

Configuring Private Files Download Permission has two parts: **registering
directories** (with the users and roles allowed to download from each), and the
**Settings** form for a few behavioural options. Both live under **Configuration
→ Media → Private files download permission** and need the **Administer Private
files download permission** permission.

## How access is decided

For every private-file download the module works out whether to allow it:

- Users with the **Bypass** permission (or administrators) are always allowed.
- Otherwise the module finds the most specific registered directory that the
  file's path falls under (the longest matching path wins) and allows the
  download only if that directory's rules grant it — via its allowed roles,
  allowed users, the "grant file owners" option, or its bypass flag.
- If none of that grants access — including when the file is in **no** registered
  directory at all — the download is denied.

So the safe mental model is: register the directories you care about, grant
access explicitly, and everything else stays locked.

## Registering a directory

1. Go to **Configuration → Media → Private files download permission** and click
   **Add**.
2. Fill in the fields:
   - **Path** — the directory path *relative to your private files path*. The form
     shows your configured private path as a prefix; you enter the part after it.
     It must start with a `/`, have no trailing slash and no doubled slashes. Use
     `/` on its own to mean the entire private file system.
   - **Bypass** — when ticked, the module ignores this path entirely and leaves
     the decision to Drupal / other modules. Use it to carve out an exception
     inside a broader locked-down rule.
   - **Grant file owners** — when ticked, the user who uploaded a file may always
     download it, regardless of the roles and users below.
   - **Enabled roles** — check the roles allowed to download from this directory.
   - **Enabled users** — pick individual users allowed to download from this
     directory. (This fieldset only appears when *Enable by-user checks* is turned
     on in the Settings form, below.)
3. Save.

You can register several nested directories and rely on longest-path matching so
the most specific rule applies. To review or revoke access later, edit or delete
the directory from the list.

### Common patterns

- **Lock down everything, open nothing:** register `/` with no roles or users —
  the whole private tree is then closed except to bypass users.
- **Open one folder to a role:** register `/downloads` and check the *member*
  role.
- **Owner-only:** register a directory and tick *Grant file owners* with no roles,
  so only each file's uploader can re-download it.

## The Settings form

Go to the **Settings** tab
(`/admin/config/media/private-files-download-permission/settings`). The options
are:

- **Enable by-user checks** — turns on per-user grants. When off, the "Enabled
  users" list on directory forms is ignored and not even shown. Leave it off on
  sites with very large user tables to keep downloads fast.
- **Cache users** — caches the user list shown in the directory form's user
  selector, so that form stays responsive on large sites. Only relevant when
  by-user checks are on.
- **Attachment mode** — serve files as downloads (`Content-Disposition:
  attachment`) so the browser saves them, rather than opening them inline.
- **Override mode** — stream the file immediately, bypassing other modules' file
  download handling. Useful for large private files or when another module's file
  handling is interfering.
- **Debug mode** — log every grant and denial to the `pfdp` log channel, so you
  can answer "why was this download allowed/denied?" by reading the logs
  (`drush watchdog:show --type=pfdp`).

Click **Save configuration** to apply.

> **Remember:** on a fresh 3.1.x install you must save this form once for the
> settings object to exist at all — see
> [Installation](../installation/index.md#first-run-note-save-the-settings-form-once).

## Deploying permissions

Directories and settings are stored as configuration, so you can export them and
import them into another environment with the usual configuration workflow —
handy for keeping download rules consistent, and for demonstrating to auditors
exactly which roles can read each private directory.
