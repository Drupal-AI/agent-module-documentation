# Configuration

## Register an application with PBS

Ask **PBS Digital Support** for an OAuth2 application and obtain its **client ID**
and **client secret**. Set the application's redirect / callback URL to:

```
https://<your-site>/user/login/pbs/callback
```

(Use your real domain and HTTPS.)

## Enter the credentials in Drupal

1. Log in as an administrator.
2. Go to **Configuration → Social API → Social Auth → PBS**
   (`/admin/config/social-api/social-auth/pbs`).
3. Enter the **client ID** and **client secret** from PBS.
4. Set the **scopes** you want to request from PBS.
5. Click **Save configuration**.

Treat the client secret like a password — keep it in an environment variable /
site secret rather than in exported configuration where practical.

## Sign-in variants

This one module offers several PBS sign-in paths, all sharing the same
configuration and callback:

- **PBS Account** — the base PBS.org login.
- **Apple**, **Facebook**, **Google** — PBS-federated sign-in through those
  providers.
- **Register** — sends new users through PBS's own account-registration page
  (`/oauth2/register/`) before the normal authorization step, and forces PBS's
  **VPPA activation** check (`activation=true`) so PBS runs its viewer-privacy
  activation.

You do not configure these separately; the base credentials cover them. The
authorization request always adds `activation=true` and your configured scopes.

## Show the login button

Go to **Structure → Block Layout** and place a **Social Auth login block**
somewhere on the site (if you have not already). That block renders the PBS
button(s). You can alternatively place or theme your own link pointing to
`user/login/pbs`.

## Test it

Log out, open the login page, and click **PBS**. You should be redirected to PBS to
sign in and returned to your site logged in — matched to an existing account or
newly created, per your Social Auth settings. If a sign-in cannot be completed,
the module logs the failure to its `social_auth_pbs` log channel, which is a good
first place to look.
