# Configuration

There are three parts to setting AhaSend up: store the API credential securely,
grant the administration permission, and tell Mail System to send through AhaSend.

## 1. Store the AhaSend API credential securely

AhaSend needs an API credential to send mail on your behalf. Keep it in an
**environment variable** rather than typing it into configuration, so the secret
stays out of version control. Under DDEV you can set one like this:

```bash
ddev dotenv set .ddev/.env --ahasend-api-key=<your-key>
ddev restart
```

The flag `--ahasend-api-key` becomes the environment variable `AHASEND_API_KEY`
inside the container. Keep `.ddev/.env` out of version control. You can confirm the
variable is present without printing its value:

```bash
ddev exec 'test -n "$AHASEND_API_KEY"'   # exit status 0 means it is set
```

Provide this credential to the module's settings (see step 3). Depending on how
your site is set up, you may reference the environment variable directly, or via a
[Key](https://www.drupal.org/project/key) entity if you prefer to manage secrets
that way.

## 2. Grant the permission

Go to **People → Permissions** (`/admin/people/permissions`) and grant
**administer ahasend** to the roles that should manage the AhaSend connection.
Because it controls how your site sends mail, keep it to trusted administrators.

## 3. Select AhaSend in Mail System

AhaSend delivers mail by acting as a Mail System plugin, so you need to tell Mail
System to use it:

1. Go to **Configuration → System → Mail System**
   (`/admin/config/system/mailsystem`).
2. Set the **AhaSend** plugin as the sender (formatter/sender) — either for the
   site-wide default, or for a specific module/mail key if you only want certain
   mail to go through AhaSend.
3. Save.

Enter your AhaSend credential where the module asks for it (the AhaSend settings,
reachable by users with the *administer ahasend* permission), then send a test
email to confirm messages are being delivered through AhaSend.

## If mail is not delivered

- Confirm the API credential is set correctly and your AhaSend account is active.
- Confirm Mail System is actually routing the relevant mail to the AhaSend plugin
  (check both the default and any per-module overrides).
- Clear caches after configuration changes (`drush cr`).
