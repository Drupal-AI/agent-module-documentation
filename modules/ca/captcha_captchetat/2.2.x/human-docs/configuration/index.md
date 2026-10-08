# Configuration

CaptchEtat needs its API credentials before it can issue any challenges, so this
step is required rather than optional.

## Open the settings form

1. Log in as a user with the **`administer captcha_captchetat`** permission (grant
   this only to trusted administrators).
2. Go to the CaptchEtat settings form in the CAPTCHA administration area (route
   `captcha_captchetat.settings_form`).

## Enter your credentials

On the PISTE administration site, open the **Applications** tab to find your
`client_id` and `client_secret` keys, then enter them on the settings form. These
authenticate every request the module makes to the CaptchEtat API, so without them
the challenge cannot be generated.

### Keep the client secret out of your codebase

Treat `client_secret` as a secret — never commit it or hard-code it. On DDEV, store
it in an environment variable and load it through a **Key** entity rather than
typing it into configuration that gets exported:

```bash
ddev dotenv set .ddev/.env --captchetat-client-secret=<value>
ddev restart
```

That makes the value available as `CAPTCHETAT_CLIENT_SECRET` inside the container
(keep `.ddev/.env` out of version control). You can then reference it from a Key
entity using the environment provider, and point the module's secret at that Key
where it supports one.

## Choose the challenge type

CaptchEtat challenge types are configurable: **alphabetical**, **alphanumeric**, or
**numeric**, with a length from **4 to 12 characters**. Pick the combination that
balances readability for your users against difficulty for bots. A separate texts
form lets you customize the visible wording shown to users.

## Flood control

To avoid hammering (and being rate-limited by) the CaptchEtat API, the module
caches API responses and includes its own flood-control system. By default each
unique IP is limited to **50 challenge requests per sliding hour**; both the
request count and the sliding period are configurable. Lower these limits if you
want tighter protection, or raise them for a very busy public form — but keep some
limit in place, since it both protects the upstream service and guards against
abuse.

## Save

Click **Save configuration**. Then head to the CAPTCHA module's administration
pages to assign the CaptchEtat challenge to the forms you want to protect.
