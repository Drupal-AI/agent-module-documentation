# Configuration

One Time Login generates links that log a user in without a password, so its
configuration is really about limiting the blast radius: how long a link lives,
whether it can be reused, how often links can be minted, and who can mint them.
Set these before you put the module into real use.

## Open the settings form

1. Log in as an administrator.
2. Open the settings form from the **Extend** page (**Configure** next to *One
   Time Login*) or the **Configuration** section of the admin menu. It is
   registered as `onetimelogin.settings`.

## Link behavior

- **Expiration** — how long a generated link remains valid. Keep this short: a
  link is a bearer credential, and a shorter window means a leaked or forwarded
  link is useful for less time. Long enough for the recipient to click it, no
  longer.
- **Single‑use enforcement** — when enabled, a link stops working the moment it is
  first used, so it cannot be replayed. Leave this on unless you have a specific
  reason not to.

## Abuse protection

- **Rate limiting** — the module limits how many links can be generated per user
  and per IP address, to prevent someone from mass‑minting links. Tune the limits
  to your support volume; the defaults are there to stop abuse, so only loosen
  them deliberately.

## Optional email delivery

- **Email the link to the user** — instead of displaying the generated URL to the
  operator, the module can email it directly to the target user. Preferring email
  delivery means the *account owner* receives the access rather than the person
  generating it, which is the safer default for support workflows. Requires your
  site's mail system to be working.

## Who can generate links

Generation is gated by the **`access one-time login`** permission (reviewed at
**People → Permissions**). Because holding it amounts to being able to log in as
any user, grant it only to fully trusted staff. Every generation attempt is
logged with its IP address, so keep an eye on the logs and the built‑in usage
statistics (`drush otl:statistics` or the statistics API endpoint) to spot
unexpected activity.

## Revocation

Even with short expiry, you may need to kill a link early — if it was sent to the
wrong person, for example. Use the revoke capability (UI, `drush otl:revoke`, or
the API) to invalidate an outstanding link immediately. Revocations are part of
the module's audit trail.

## Save

Save the form once expiry, single‑use, and rate limits reflect your policy. Paired
with a tightly restricted permission and the habit of revoking stale links, that
keeps this powerful convenience safe to run.
