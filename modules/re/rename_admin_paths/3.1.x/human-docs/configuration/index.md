# Configuration

## Open the settings form

1. Log in as a user with the **Administer path admin** permission (this is a
   restricted permission — grant it only to trusted administrators).
2. Go to **Configuration → System → Rename Admin Paths**, or navigate directly to
   `/admin/config/system/rename-admin-paths`.

The form saves to the `rename_admin_paths.settings` configuration object, which has a
schema and so exports and deploys with `drush config:export`. Both renames are
switched **off** by default.

## The form

The form has two independent fieldsets — one for each prefix — and each works the
same way: a checkbox to enable the rename, and a text field for the replacement term.

### Rename admin path

- **Checkbox** — when ticked, every route that begins with `/admin` is served under
  your replacement prefix instead.
- **Replacement term** *(default: `backend`)* — the word that replaces `admin` in the
  URL. For example, with the term `backend`, `/admin/content` becomes
  `/backend/content`.

### Rename user path

- **Checkbox** — when ticked, every route that begins with `/user` is served under
  your replacement prefix instead.
- **Replacement term** *(default: `member`)* — the word that replaces `user`. For
  example, with the term `member`, `/user/login` becomes `/member/login`.

## Rules for replacement terms

Before saving, the module validates each replacement term. A term must:

- **not be empty**;
- **contain only** letters, numbers, hyphens, and underscores (`a`–`z`, `A`–`Z`,
  `0`–`9`, `-`, `_`); and
- **not reuse the reserved names** `admin` or `user`.

These rules exist partly to keep the URLs valid and partly to prevent you from
accidentally locking yourself out.

## Save

Click **Save configuration**. The module rebuilds the router immediately, so the
renamed paths are live at once — no separate cache clear is needed — and the form
redirects you to itself at its new address. Your admin menu, toolbar, and other
route‑based links update automatically.

To reverse a rename, untick its checkbox and save again; the original `/admin` or
`/user` prefix is restored instantly.

## Remember what this does and doesn't do

Renaming the paths hides the default URLs and can reduce bot spam, but it is **not**
access control. Keep real permissions and authentication hardening in place. Note too
that a handful of hard‑coded paths — in some contrib modules and in Views‑generated
admin report links — are **not** rewritten by this module.
