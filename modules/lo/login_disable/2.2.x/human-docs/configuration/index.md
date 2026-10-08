# Configuration

## Open the settings form

Log in as a user with the **Administer permissions** permission and go to
**Configuration → People → Login Disable**
(`/admin/config/people/login-disable`).

## The settings

| Setting | What it does |
|---|---|
| **Prevent user log in** (active) | The master switch. Off by default — while it's off the module does nothing. Turn it on to disable login. |
| **Access key** | A secret word that must be present as a query argument on the login URL (e.g. `/user/login?yourkey`) for the login form to be usable. Leave it **empty** to skip this gate entirely and just refuse login by role. |
| **Message** | The warning text shown to a blocked user (defaults to a "member access has been temporarily disabled" message). |
| **Force logout on save** | When ticked (and the feature is active), saving the form ends everyone else's sessions immediately — every logged‑in user except user 1 and you. |

Click **Save configuration** to apply. You can also drive these from Drush:

```bash
drush cset login_disable.settings login_disable_is_active true -y
drush cset login_disable.settings login_disable_key 's3cr3t-word' -y
```

## Change the default access key before you rely on it

The module **ships with the access key set to `admin`**. If you activate the
feature without changing it, the "secret" URL that reveals the login form is the
trivially guessable `/user/login?admin`. Set your own key (or clear it) before
you turn the feature on.

The good news is that the access key is only an **obscurity gate on the login
form**, not the authentication boundary — see how the two layers work below — so a
guessed key alone does not let anyone in. Still, change it so the "hide the form"
protection actually protects.

## Choose who can still log in

The real boundary is the **Bypass disabled login** permission (a restricted
permission, on the normal *People → Permissions* screen). Grant it to the roles
that should still be able to log in while the feature is active. Any role without
it is logged straight back out after authenticating, even if that user knows the
access key. User 1 always bypasses.

## How enforcement actually works

Three layers combine:

1. **The login form is disabled** (name/password fields and the submit handlers
   are removed) unless the access key is present in the URL. This layer is only
   there to hide the form — it's obscurity, not authentication. It's skipped
   entirely when the access key is empty.
2. **Post‑login session clear** — the moment any account authenticates, if it
   lacks *Bypass disabled login* its session is cleared and the message is shown,
   so it never actually gets in. This is the genuine boundary, and it runs whether
   or not a key is set. It applies to the login form, the login block, the REST
   login, and one‑time‑login / password‑reset links, because they all finalize
   login through the same code path.
3. **The REST/JSON login endpoint** (`user.login.http`) is also gated behind the
   access key when one is configured (returning HTTP 403 when the key is missing),
   so the programmatic login route is covered too.

## Turning it back off

Uncheck **Prevent user log in** and save — normal login resumes instantly, with
no code changes needed.
