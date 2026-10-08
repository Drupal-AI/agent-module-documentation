# Configuration

Go to **Configuration → People → Secure Login**
(`/admin/config/people/securelogin`). The form requires the **Administer site
configuration** permission. All settings are stored in the `securelogin.settings`
config object.

## Redirect form pages to secure URL

- **Redirect form pages to secure URL** *(on by default)* — when a page contains a
  secured form, redirect the whole page to HTTPS rather than only rewriting the
  form's action. This means visitors visibly land on a secure URL before submitting.
  Turn it off if you only want the form's action rewritten (for example when a
  front‑end cache serves the HTTP page).

## Submit all forms to secure URL

- **Submit all forms to secure URL** *(off by default)* — a single toggle that forces
  **every** form on the site over HTTPS, overriding the per‑form list below. This is
  the simplest way to secure everything; when it's ticked, the per‑form checkboxes
  and the "other forms" field are hidden because they no longer apply.

## Which forms to secure

- **Forms checklist** — a list of forms that modules have advertised as securable.
  The core user forms — **user login**, **user edit**, **user register**, **password
  reset**, and **password request** — are secured by default. Secure Login also ships
  support for node, comment, contact, and Webform forms, so those appear here when
  those modules are installed; tick the ones you want.
- **Other forms to secure** — a free‑text field where you can add arbitrary form IDs
  (space‑separated) that aren't in the checklist.

> **Tip: use base form IDs.** To secure *all* node add/edit forms, add the base form
> ID `node_form` rather than a specific one like `article_node_form`. The same
> applies to other entity forms — list the base form ID to catch every bundle.

## Secure base URL

- **Secure base URL** — leave blank to let Drupal work out the HTTPS address
  automatically (recommended). Set an explicit value only when your TLS certificate is
  valid for a single hostname and you need forms directed there. If you do set it, it
  must start with `https://` and have no trailing slash.

Click **Save configuration**. Saving clears the relevant render and HTTP‑response
caches so the new rules take effect.

## For developers

You can opt a custom form in from code with `$form['#https'] = TRUE`, generate an
HTTPS URL with `$options['https'] = TRUE`, or call the `securelogin.manager` service's
`secureForm()` / `secureRedirect()` directly. Contrib modules can advertise their own
forms to the checklist with `hook_securelogin_alter()`. See the sibling
[`agent/`](../agent/start.md) docs for the API details.
