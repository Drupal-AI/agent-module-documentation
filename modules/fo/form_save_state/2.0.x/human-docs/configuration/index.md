# Configuration

Form Save State does nothing until you tell it which forms to protect. It works
by **form ID**, so you enable autosave selectively rather than site‑wide.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Form Save State**
   (`/admin/config/user-interface/form-save-state`).

## Choose which forms get autosave

Enable autosave for the specific **form IDs** you care about — for example a
node edit form, a comment form, or a webform submission form. For each form ID
you turn on, the module attaches its autosave JavaScript to that form; as a
visitor fills it in, their input is periodically written to the browser's
localStorage and restored if they come back to the page.

Save the settings. The change takes effect the next time the form is loaded.

## What to enable — and what not to

Good candidates are forms where accidental loss is costly and the content is not
sensitive:

- Long **content/article** edit forms.
- **Webforms** and multi‑step application or survey forms.
- **Comment** forms and other large text entry.

Deliberately **leave out** any form that carries sensitive data — login,
password change, or forms collecting personal information — because the recovered
values are cached in the browser's localStorage and would be readable by anyone
sharing that browser profile.

## Good to know

- **Everything is client‑side.** Recovery data is stored only in the visitor's
  own browser localStorage; nothing is written to the server, so this is not a
  server‑side draft system.
- **Rich‑text editors.** Classic Sisyphus does not capture WYSIWYG editors out of
  the box; if you rely on a WYSIWYG editor, test recovery on that specific form
  before depending on it.
