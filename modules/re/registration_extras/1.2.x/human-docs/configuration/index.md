# Configuration

Registration Extras is configured from its own settings form. Open it as a user
with the **Administer site configuration** permission (an administrator by
default). The module stores its settings in configuration, so whatever you set
here can be exported and deployed like any other Drupal config.

The form offers two settings:

## Submit button label

This overrides the text shown on the button at the bottom of the user
registration form. By default Drupal shows a generic label; set this field to
whatever wording fits your site's voice — for example "Create my account",
"Sign up", or "Join the community". Leave it empty to keep Drupal's default
label. The change applies to the registration form only, not to other forms on
your site.

## Post-registration redirect path

This sets where a visitor lands immediately **after** they successfully create an
account. Enter an internal path (for example `/welcome`, `/user`, or a custom
onboarding page). When set, the new user is redirected there instead of following
Drupal's default post-registration behavior. This is handy for sending people
straight to a welcome page, a "complete your profile" step, or a members-only
landing area.

Leave it empty to keep Drupal's normal behavior after registration.

## Save

Click **Save configuration**. The new button label and redirect take effect on
the next registration — test them by visiting `/user/register` as an anonymous
visitor.

## A note on security

These options are purely cosmetic (the button label) and navigational (the
redirect). They do not change who may register, what roles a new account
receives, or whether email verification and admin approval apply. Keep those
controls — configured under **Configuration → People → Account settings** and via
your anti-spam modules — exactly as your policy requires. Registration is a common
abuse target, so do not treat a friendlier button or a redirect as a substitute
for verification, approval, and spam protection.
