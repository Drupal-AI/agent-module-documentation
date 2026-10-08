# Configuration

Configuring this module has two parts that matter equally: entering your Meta
credentials, and making sure events are only sent when you have a lawful basis and
consent to send them. Because the tracking happens server-side, the second part is
your responsibility — nothing in the visitor's browser will stop an event you send.

## Open the settings form

1. Log in as a user with the **Administer meta conversions api** permission.
2. Open the module's settings form via the `meta_conversions_api.settings` route under
   **Configuration**.

## Enter the credentials

- **Pixel ID** — the ID of the Meta pixel/dataset that events should be attributed to,
  from your Meta Events Manager.
- **Access Token** — the Conversions API token that authenticates your site to Meta.
  This is a **secret**: treat it like a password.

### Keep the access token out of version control

Do not commit the token or leave it only in exported configuration. Store it in an
environment variable and reference it from Drupal. With DDEV:

```bash
ddev dotenv set .ddev/.env --meta-capi-access-token=<your-token>
ddev restart
```

That exposes it as `META_CAPI_ACCESS_TOKEN` in the container (keep `.ddev/.env` out of
git). Where the module supports a [Key](https://www.drupal.org/project/key) entity,
prefer a Key backed by the environment provider; otherwise reference the variable in
`settings.php` with `getenv('META_CAPI_ACCESS_TOKEN')` and override the config value
from there. Either way the raw token stays out of the database and out of git.

## Enforce consent (required, and it is in code)

Server-side events are invisible to the visitor and cannot be blocked by them, so the
site must decide whether to send. The module gives you the hook to make that decision:

- Implement **`hook_meta_conversions_api_allowed()`** to return whether sending is
  allowed for the current request — for example, by checking your consent cookie. If a
  visitor declined tracking, this hook must prevent the event.
- It is also recommended to override the
  `Drupal.meta_conversions_api.allowedCallback` JavaScript function in your own
  library, so the browser does not even make unnecessary requests to the server when
  consent has not been given.

Wire these to your cookie banner / consent manager before you go live. Without them,
the module will report to Meta regardless of what the visitor chose.

## Manage events

- The module ships a **PageView** event out of the box.
- Each event can be **enabled or disabled** on the settings form.
- Developers can add new events with **`hook_meta_conversions_api_event_names()`**,
  rename existing ones with **`hook_meta_conversions_api_event_names_alter()`**, and
  send custom events by calling the `sendRequest()` method of the `MetaClient` service.

## Privacy and data-handling checklist

- A **hashed email is still personal data** under GDPR — hashing is pseudonymisation,
  not anonymisation.
- Record this server-side transfer to Meta in your **records of processing** and name
  it in your **privacy notice**.
- Make sure you have a **lawful basis** and, where required, **consent** — enforced by
  the hook above — before any event is sent.

## Save

Save the form. Test with consent granted and consent declined to confirm events are
sent only in the case you intend, then verify receipt in Meta Events Manager.
