# Configuration

There are three parts: **(1)** disabling a language, **(2)** the module's settings form for
redirect behavior, and **(3)** the two permissions. Remember throughout: **after any change,
clear caches** (`drush cr`) — the module cannot invalidate its own caches, so changes won't
show until you do.

> **Never disable every language**, and never disable your only or default language, or the
> redirect logic can lock you out of the site.

## 1. Disable a language

1. Go to **Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`). With the module enabled, this overview now shows a
   **Disabled** column (Yes/No per language).
2. Click **Edit** on the language you want to hide
   (`/admin/config/regional/language/edit/<langcode>`). The edit form now has:
   - **Disable language** — tick this to hide the language from the public front end.
   - **Select language to which we redirect** — appears once *Disable language* is ticked.
     Choose the language visitors should be sent to when they hit a URL in this disabled
     language. Leave it and they go to the front page instead.
3. Save the language, then run `drush cr` (or **Configuration → Development → Performance →
   Clear all caches**).

To **re‑enable** a language later, edit it again and untick *Disable language*, save, and
clear caches. The language switches back on instantly.

## 2. The settings form — redirect behavior

Go to **Configuration → Regional and language → Languages → Disable language**
(`/admin/config/regional/language/disable_language`). This form needs the core *Access
administration pages* permission and controls two things:

- **Redirect override routes** — a list of route names that, when hit in a disabled language,
  should redirect **to themselves in an accessible language** rather than bouncing to the
  front page. Two routes are pre‑configured out of the box — the password‑reset login
  (`user.reset.login`) and the user edit form (`entity.user.edit_form`) — which is what keeps
  password‑reset links working. Add your own route names here for any page that must resolve
  in place instead of redirecting away.
- **Excluded paths** — a standard path condition (the same "Pages" style textarea you see
  elsewhere in Drupal, with a negate option). Paths that match are **excluded from the
  disabled‑language redirect entirely**, so they resolve normally even in a disabled language.

Save, then clear caches.

## 3. Permissions

At **People → Permissions** (`/admin/people/permissions`), two permissions relax the public
restrictions for trusted users:

- **View disabled languages** — users with this permission still see disabled languages in
  the language switcher and can preview them. Grant it to admins and translators who need to
  work on a not‑yet‑public language. (Note: this only affects the switcher; the front‑end
  redirect still applies to everyone else.)
- **Create content in disabled language** — users with this permission keep disabled languages
  available in the content‑form language selector, so they can still author content in them.
  Without it, disabled languages disappear from those dropdowns.

Neither permission controls the language edit form or the settings form — those are gated by
core's *Access administration pages* / site‑configuration permissions.

## Verify it works

As an administrator (with *View disabled languages*) you should still see and use the disabled
language. In a private browser window as an anonymous visitor, the disabled language should be
gone from the switcher, and visiting one of its URLs should redirect you to the fallback you
chose. If nothing seems to have changed, you almost certainly need to clear caches.
