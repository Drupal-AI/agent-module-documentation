# Configuration

Admin User Language has a single small settings form with two options. Together
they decide **which** administration language is forced onto users and **how
strictly** it is enforced.

## Open the settings form

1. Log in as a user with the **Administer admin interface language** permission
   (an administrator by default).
2. Go to **Configuration → Admin User Language settings**, or navigate directly
   to `/admin/config/admin_user_language/settings`.

Remember you need at least two active languages for any of this to be meaningful.

## Default language to assign

This is the language written to each user's *administration pages language*
(their `preferred_admin_langcode`). The dropdown offers:

- **- No preference -** *(shipped default)* — the module does nothing; no
  language is forced. This is the state you're in right after enabling the
  module.
- **The user's site language** — instead of a fixed language, each user's own
  site/content language preference is copied into their admin language. Good when
  you want each person's back end to match the language they already work in.
- **Any of your active languages** (for example English, Nederlands) — that
  specific language is assigned to users' admin language.

The language is only actually applied if the resolved value is one of the site's
currently active languages, so removing a language later won't leave users
pointed at something that no longer exists.

## Prevent user override

This checkbox decides how firmly the choice is enforced:

- **Unchecked** *(shipped default)* — a **soft default**. The language is set
  only when a user account is **new** (at creation). Existing users keep whatever
  they chose, and everyone remains free to change their own administration
  language afterwards.
- **Checked** — a **hard lock**. The language is **re‑applied every time any user
  account is saved**, so it always stays on policy. In addition, the
  *administration pages language* field on the user edit form is disabled, so
  users cannot change it themselves. (Drupal only shows that field to users who
  already have admin privileges, so ordinary users never see it either way.)

## Save

Click **Save configuration**. The new policy applies going forward: new accounts
always get the chosen language, and — if you enabled the override lock — existing
accounts are brought onto it the next time each one is saved.

## Setting it from the command line

If you prefer Drush or are managing config in code:

```bash
drush cset admin_user_language.settings default_language_to_assign en -y
drush cset admin_user_language.settings prevent_user_override true -y
drush cget admin_user_language.settings
```

Use `-1` for "- No preference -" or `preferred_langcode` for "the user's site
language" as the value of `default_language_to_assign`.

## Don't forget the negotiation module

Setting a user's stored admin language does not, by itself, make the interface
appear in that language. Install and configure **Admin Language Negotiation**
(`admin_language_negotiation`) alongside this module so the forced preference is
actually used to render the admin UI.
