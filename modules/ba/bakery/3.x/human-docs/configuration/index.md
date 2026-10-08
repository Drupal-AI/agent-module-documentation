# Configuration

Bakery's configuration has two sides: the **roles** (which site is the parent,
which are the children, and the URLs that tie them together) and the **shared
secret** (`bakery_key`) that makes the whole thing trustworthy. The security of
your SSO is entirely in how you handle that secret, so this page leads with it.

## The `bakery_key` is a master credential — treat it like one

Every site in the group must use the **same** `bakery_key`. Whoever holds that
key can forge a signed cookie for **any user on any site** in the group. That
makes it as sensitive as a root password. Rules:

- **Never commit it** to version control, a configuration export, or a settings
  file that is tracked in Git.
- **Never let it into a database dump** you share or copy to a non-production
  environment without rotating it.
- **Generate it randomly and long** — it is an HMAC key, not a memorable
  passphrase. Use plenty of high-entropy random bytes.
- **Rotate it** if you suspect any site in the group, or any backup, was
  compromised. A leaked key is a full authentication bypass for the whole group.

### Storing the key out of committed config

Put the secret in an environment variable rather than in tracked configuration.
With DDEV, set it and restart so the container loads it (do this identically on
every site in the group so they share the same value):

```bash
ddev dotenv set .ddev/.env --bakery-key=<the-same-long-random-value-everywhere>
ddev restart
```

`.ddev/.env` must stay out of version control. Confirm the variable reached the
container **without printing its value**:

```bash
ddev exec 'test -n "$BAKERY_KEY" && echo set'
```

Then reference it from `settings.php` via `getenv('BAKERY_KEY')` when providing
Bakery's key configuration, so the secret lives only in the environment — never
in a file you commit or a config export you share.

## Parent and child roles

Bakery works as a **parent** site (the one users actually log in on, which issues
the SSO cookie) and one or more **child** sites (which read the cookie and trust
it). In each site's Bakery configuration you set:

- Which role this site plays — **parent** or **child**.
- The **master/parent site URL** the children point at for login and
  registration.
- The list of **child site URLs**, on the parent.
- The **`bakery_key`**, identical everywhere (sourced from the environment as
  above).
- A **freshness** window (`bakery_freshness`) that bounds how long an issued
  cookie is accepted, limiting replay. Keep it short enough to be safe and long
  enough to be usable.

The parent and child URLs must all sit under the shared second-level domain so
the cookie is valid across them.

## Verify it worked

Log in on the **parent** site, then visit a **child** site. You should already be
recognised as the same user without logging in again. If you are not, the usual
culprits are a mismatched `bakery_key` between sites, a clock skew larger than the
freshness window, or the sites not actually sharing the same second-level domain
in the cookie's scope.

## Serve everything over HTTPS

The SSO cookie is an authentication token in transit between sites. Serve all
parent and child sites over HTTPS so the cookie is never exposed on the wire.
