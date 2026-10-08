# Configuration

Configuring Gammu SMS Daemon has two parts: pointing Drupal at the Gammu SMSD
backend, and — just as important — **securing the inbound send endpoint**. The
admin interface is gated by the **administer gammu** permission.

## Connect to the Gammu SMSD backend

Provide the details the module needs to talk to your Gammu SMSD installation:

- **Database / connection details** — how the module reaches the Gammu SMSD
  database (host, database name, credentials), plus the **communication method**
  and **port** your Gammu setup uses.
- Any **authentication details** your Gammu SMSD requires.

Gammu SMSD must already be installed and running on the server (see
[Installation](../installation/index.md)); this form only tells Drupal how to
reach it.

## Set a strong send token — do this first

The module's inbound HTTP endpoint, **`api/gammu/send`**, authenticates callers by
matching the request's `Authorization` header against a configured token,
`gammu_token`.

> ## ⚠️ The token is empty by default, and that is dangerous
>
> As shipped (`8.x-1.2`), the endpoint is declared `_access: 'TRUE'` (no Drupal
> permission required) and uses a **loose `==`** comparison. With an **empty
> default token**, a request that sends no `Authorization` header is evaluated as
> `null == null` — which passes. **Until you set a token, anyone on the internet
> can call `api/gammu/send` and send SMS through your gateway**, at your expense.
>
> **Set a strong, random `gammu_token` immediately.** A long, unpredictable value
> ensures the empty default can never be matched and that a missing/blank header is
> rejected.

## Handle the token as a secret

The send token is effectively a credential — treat it like one:

- **Never commit it** to version control or paste it anywhere it will be exported
  with configuration.
- Prefer storing the value in an environment variable. With DDEV:
  `ddev dotenv set .ddev/.env --gammu-token=<value>` then `ddev restart` (keep
  `.ddev/.env` out of version control), and reference it from Drupal via a **Key**
  entity or `getenv()` where possible.

## Restrict the inbound endpoint at the network layer

Setting a token is necessary but, given the module's *Unsupported* status, not
sufficient on its own. Also **restrict `api/gammu/send`** at the web server or
firewall so only trusted systems can reach it — for example an IP allow‑list, or
keeping the route on an internal‑only network path. This limits exposure even if
the token check is weaker than it should be.

## Build your recipient list and personalisation

Recipients come from your content — for example a *Client* content type with a
telephone field. Map name fields so message variables such as `Dear {{name}}...`
resolve when you compose and send.

## Save

Save the configuration form, then verify by sending a single test message to a
number you control before doing any bulk send — and re‑confirm that
`api/gammu/send` rejects a request that carries no valid token.
