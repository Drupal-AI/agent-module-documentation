# Configuration

Configuration is a single step — set a secret token — but that token is
effectively a password, so treat it with care.

## Open the settings form

1. Log in as a user with the **Administer maintenance VIP**
   (`administer maintenance vip`) permission — grant this restricted permission
   only to trusted administrators.
2. Go to **Configuration → Development → Maintenance VIP**
   (`/admin/config/development/maintenance-vip`).

## Maintenance VIP Token

Enter a **secure, unique string** in the token field — for example something long
and random rather than a guessable phrase like `preview`. This value becomes the
secret in the bypass URL:

```
https://yoursite.com/vip/<your-token>
```

Save the configuration. A few things to keep in mind:

- **The token is a bearer secret.** Anyone who has the `/vip/<token>` URL gets
  access — no account needed — so share it only over trusted channels and treat
  it like a password.
- **Access lasts 24 hours** per visit. When a VIP opens the link, the module sets
  a secure, HTTP-only cookie good for 24 hours; after that they'd need to open
  the link again.
- **Make it long and random.** The token comparison is exact, so the only real
  protection is the token being hard to guess. A short or predictable token
  weakens the whole scheme.
- **An empty token is refused.** If no token is configured, the bypass URL simply
  returns the maintenance response — you cannot accidentally leave an
  empty-token backdoor open. Always set a real token before relying on it.
- **Rotate it when you're done.** After a review window closes, change the token
  (or clear it) so old links stop working.

## Using and ending a VIP session

1. Enable Drupal's **maintenance mode** as usual.
2. Share `https://yoursite.com/vip/<your-token>` with your reviewers.
3. To end a session, a VIP can visit **`/vip-logout`**, which clears the cookie
   and returns them to the front page.

## Save

Click **Save configuration**. The token takes effect immediately for new visits
to the VIP URL.
