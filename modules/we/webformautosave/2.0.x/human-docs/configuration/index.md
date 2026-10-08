# Configuration

Webform Autosave has no dedicated admin page. You turn it on through **Webform
third‑party settings** — either on one webform or, as a default, globally.

## Turn autosave on for a webform

1. Go to **Structure → Webforms** and edit the webform you want.
2. Open **Settings → General**.
3. Scroll to the **Webform auto‑save settings** section.

You'll find three settings:

- **Automatically save the submission as a draft** (`auto_save`) — the master
  switch. Tick it to have the form save itself as a draft whenever an input
  changes. Off by default.
- **Auto‑save wait time** (`auto_save_time`) — how long, in milliseconds, the
  module waits after the last change before saving. The default is **5000** (five
  seconds). This "debounce" keeps it from saving on every keystroke; raise it if
  you also use optimistic locking, so saves are less frequent.
- **Use an optimistic locking strategy** (`optimistic_locking`) — when ticked, if
  another user or session has changed the same submission since it was loaded, the
  editor gets a validation error with a reload link instead of overwriting the
  newer data. Off by default.

Save the webform when you're done.

## What changes automatically when you enable it

Because autosave relies on Webform's own draft system, turning it on will adjust a
few of the webform's other settings for you the next time it's saved:

- **Drafts are enabled** if they were off (set to "Allow all users to save
  drafts").
- **Purge settings** are switched to include drafts, and the purge period defaults
  to **182 days** if it wasn't already set — so stale autosaved drafts are cleaned
  up over time.
- If you enabled **optimistic locking**, the **submission log** is turned on
  (it's needed to detect competing changes).

This is expected behavior — just know that enabling autosave flips those
draft/purge/log settings on.

## Setting a global default

The same three settings also exist in the global Webform settings' third‑party
settings section, so you can establish a site‑wide default and then override it
per webform as needed.

## Setting it from the command line

If you prefer to configure a webform programmatically (replace `contact` with your
webform's ID):

```bash
ddev drush php:eval '$w=\Drupal\webform\Entity\Webform::load("contact");
$w->setThirdPartySetting("webformautosave","auto_save",TRUE);
$w->setThirdPartySetting("webformautosave","auto_save_time",8000);
$w->setThirdPartySetting("webformautosave","optimistic_locking",TRUE);
$w->save();'
```
