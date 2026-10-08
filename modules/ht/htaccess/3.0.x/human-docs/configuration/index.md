# Configuration

Everything Htaccess does happens on one settings form. Because that form writes
your site's live root `.htaccess`, read this whole page before you save — a mistake
here can take the site offline.

## Open the settings form

1. Log in as a user with the **`administer htaccess`** permission (a full
   administrator — see the security note at the end of this page for why this
   permission should not be delegated more widely).
2. Go to **Configuration → System → Htaccess**, or navigate directly to
   `/admin/config/system/htaccess`.

## The fields

- **Default .htaccess content (read‑only preview)** — a read‑only textarea showing
  the current default Drupal `.htaccess`, loaded from core. This is the base that
  your extra directives are appended to. You can't edit it here; it's for reference
  so you can see what's already in force.
- **Path to the default .htaccess** — the file the base content is read from,
  usually `core/assets/scaffold/files/htaccess`. **Leave this at the default unless
  you have a specific reason to change it.** Pointing it elsewhere changes what gets
  used as the base of the written file.
- **Extra configurations** — an editable textarea for the custom Apache directives
  you want to add (redirects, security headers, caching rules, `FilesMatch`
  blocks, and so on). These are appended below the default content.
- **Automatically replace on cron** — a checkbox that, when ticked, has the module
  rewrite the docroot `.htaccess` from your saved settings on every cron run. This
  keeps the file in sync with configuration, which is convenient for deployments —
  but be aware that with it on, any hand‑edit you make to `.htaccess` on disk will
  be overwritten at the next cron.

## Save

Saving concatenates the default content and your extra directives and writes the
result to the docroot `.htaccess`. Reload a page or two to confirm the site still
responds normally.

## Operational precautions

- **Back up your current `.htaccess` before you save the first time.** The write
  replaces the existing file.
- **Test on a non‑production environment first.** If the resulting file doesn't
  parse, Apache returns HTTP 500 for the whole directory — including this admin
  page, so you may not be able to undo the change from the UI.
- **If you turned on "automatically replace on cron",** remember that fixing the
  file on disk isn't enough — the next cron run rewrites it from configuration.
  Correct the problem in the settings form (or turn the option off) rather than only
  editing the file directly.
- **On a read‑only production docroot** the write fails safely and the file is left
  untouched.

## Security note — treat `administer htaccess` as administrator‑only

The `administer htaccess` permission is marked as restricted for good reason, and it
is far more powerful than "edit a settings form" suggests:

- On Apache, the **extra‑directives** field controls real server configuration and
  is inherently capable of influencing how the server runs — that's the whole point
  of the module, but it means the permission is effectively equivalent to deep
  server access.
- The write replaces core's `.htaccess`, which is what enforces directory‑listing
  prevention (`Options -Indexes`) and the rules that deny web access to sensitive
  files such as `*.yml`, `*.module`, `*.install`, and editor backups. Replacing it
  carelessly removes those protections.

Because of this, grant `administer htaccess` **only to people who are already full
site administrators**. Do not delegate it to content editors or lower‑privileged
roles.
