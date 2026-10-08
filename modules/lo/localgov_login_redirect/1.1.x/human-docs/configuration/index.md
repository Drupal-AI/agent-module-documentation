# Configuration

LocalGov Login Redirect has a single job — deciding where users land after they log in
— and one small settings form to configure it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → LocalGov Login Redirect**, or navigate directly to
   `/admin/config/system/localgov_login_redirect`.

## Set the destination

On the form, set the path you want users to be sent to after they log in — for
example the admin content list (`/admin/content`), a dashboard, a members' area, a
particular View, or the front page (`<front>`). Save the form, and the new destination
takes effect on the next login.

Because the destination is stored as configuration, it is included when you export
configuration with `drush cex`, and you can change it directly on a live site without
a code deployment.

## Save

Click **Save configuration**. Log out and back in to confirm you are taken to the new
destination instead of your user profile page.
