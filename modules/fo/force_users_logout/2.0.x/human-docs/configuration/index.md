# Using the logout forms

Force Users Logout has no settings to save — instead it gives you three action
forms, one per tab, under **Configuration → Development → Force users logout
settings**. Each form ends users' sessions immediately when you submit it. All
three require core's **Administer users** permission.

Everything here is an action, not a stored setting: nothing is persisted, and
submitting a form takes effect on the affected users' next request.

## Individual User

Path: `/admin/config/force-users-logout/individualuser`

Signs out a single user.

- **Name of the user to be logged out** — start typing a username and pick the
  matching account from the autocomplete list. Choosing from the list is
  important: the field expects the value in the `username (uid)` form the
  autocomplete provides, so select the suggestion rather than typing a bare name.

Submit to destroy that user's session. Their account is untouched — they are
simply signed out and will need to log in again.

## Role Based

Path: `/admin/config/force-users-logout/rolebasedlogout`

Signs out everyone who holds one or more selected roles.

- **Select role(s)** — a list of checkboxes, one per role. Check the roles whose
  members you want to log out, then submit. Every active user holding any checked
  role has their session destroyed.

Note that the built-in **Administrator**, **Authenticated user** and **Anonymous
user** roles are deliberately excluded from this list, so you cannot target them
here. On a site that has no custom roles, this list will therefore be empty.

## All Other Users

Path: `/admin/config/force-users-logout/otheruserslogout`

Signs out every authenticated user *except* administrators — useful before a
maintenance window, database restore, or as an incident response.

- **Force logout all users except admin** — a single confirmation checkbox. Tick
  it and submit to destroy the sessions of every active user who is neither in
  the Administrator role nor anonymous.

Important: this exempts users based on the **Administrator role** specifically —
not on "user 1" and not on the generic admin flag. If your site's admin role has
a different machine name, its members will *not* be exempt, so double-check your
role setup before using this on production.

## A note on blocked users

All three forms only act on **active** (unblocked) accounts. If you have just
*blocked* a user and want to end their current session too, block them and then
run the logout — blocking alone does not end an existing session.
