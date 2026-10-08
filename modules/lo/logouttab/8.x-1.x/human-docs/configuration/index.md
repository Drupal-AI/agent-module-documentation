# Configuration

Logout Tab has two settings: where the tab sits among the other profile tabs, and
where it sends the user.

## Open the settings form

1. Log in as a user with the **Administer users** permission.
2. Go to **Configuration → People → Logout Tab**, or navigate directly to
   `/admin/config/people/logouttab`.

## Tab weight

Sets the tab's **weight**, which controls its position relative to the other local
tasks on the profile page (View, Edit, and any others). A lower weight moves the
tab earlier (further left); a higher weight moves it later. Adjust this if you
want **Log out** to appear before or after the other tabs.

## Logout URL

The path the tab links to. It **defaults to `user/logout`**. You can point it at a
different logout path — for example a custom or SSO logout route — if your site
handles logout somewhere other than core's route.

> **Keep the Drupal 10/11 caveat in mind:** on those versions, redirecting to
> `user/logout` without a CSRF token lands on core's logout **confirmation** page
> rather than ending the session in one click. Changing this URL to an
> alternative logout route that carries the appropriate token (or one provided by
> your SSO setup) is the way to get a smoother experience if you need it.

## Save

Click **Save configuration**. The tab's new position and target take effect
immediately.
