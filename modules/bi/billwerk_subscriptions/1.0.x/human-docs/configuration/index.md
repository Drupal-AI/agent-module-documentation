# Configuration

Setup has four parts: the Billwerk API credentials, the plan-to-role mapping, the
webhook, and the self-service permissions. Because this drives roles from a paying
subscription platform, treat the API key and the webhook secret as sensitive
credentials throughout.

## 1. API credentials and environment

Open the settings form at **Configuration → Web services → Billwerk Subscriptions**
(`/admin/config/services/billwerk-subscriptions/settings`), which requires the
`administer billwerk_subscriptions configuration` permission. Enter the Billwerk API
key and select the environment (the module resolves the correct API base URL from
that choice).

### Keep the API key out of committed config

The API key is a credential. Prefer supplying it from an environment variable rather
than committing it. With DDEV:

```bash
ddev dotenv set .ddev/.env --billwerk-api-key=YOUR_KEY_HERE
ddev restart
```

The flag `--billwerk-api-key` becomes the environment variable `BILLWERK_API_KEY`
inside the web container. Never commit `.ddev/.env`. Confirm it is set without
printing it:

```bash
ddev exec 'test -n "$BILLWERK_API_KEY" && echo set || echo missing'
```

If you need to debug the outbound API calls, the suggested `http_client_logger`
module traces the Guzzle traffic.

## 2. Map subscription plans to roles

Still in the settings form, configure which Billwerk subscription plans map to which
Drupal roles. The module grants a mapped role when a user's contract for that plan is
active and revokes it when the contract lapses.

## 3. Register the webhook

Billwerk notifies your site of changes through a webhook listener at:

```
/billwerk-subscriptions/webhook-listener/{secret}
```

Register that URL in the Billwerk dashboard, substituting the shared secret you
configured in Drupal for `{secret}`. The route is intentionally public, but the
controller authenticates each call by comparing the secret in the path against the
stored value with a strict check, and then **re-fetches the authoritative
subscription details from the Billwerk API** rather than trusting the request body —
so a forged POST cannot change subscription state. Keep the webhook secret out of
logs and version control, exactly as you would the API key.

## 4. Self-service and actions

- **Refresh own subscription** — logged-in users can trigger a resync at
  `/user/{user}/subscription/refresh` (a custom access check applies).
- **Self-service permissions** — `billwerk_subscriptions_selfservice_manage_own_contract`
  lets a user manage their own contract; `..._manage_any_contract` lets privileged
  staff manage any user's contract. These gate the embedded Billwerk self-service UI
  on user profiles.
- **Fetch & assign contract IDs** — the
  `billwerk_subscriptions_fetch_assign_contract_ids` permission enables the action
  that matches a Billwerk ExternalId to a Drupal user ID.

Set these under **People → Permissions** (`/admin/people/permissions`).

## Security notes

- The API key and webhook secret are sensitive — store the API key in the environment
  and keep both out of logs and version control.
- The webhook is public by design but authenticated by a strict secret comparison and
  re-fetches authoritative data from Billwerk; this pattern was reviewed and found
  sound.
- The admin settings form is restricted-access; the refresh form requires login plus
  a custom access check.
