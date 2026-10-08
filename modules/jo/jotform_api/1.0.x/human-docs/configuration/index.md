# Configuration

Setting up Jotform API has three parts: store your API key as a Key, point the
module at it, and place a form.

## Step 1 — Store your Jotform API key as a Key

The module reads the API key through the **Key** module rather than from plain
configuration, so the secret never ends up in a config export or in code.

The cleanest approach under **DDEV** is to keep the key in an environment variable
and reference it from a Key entity:

```bash
ddev dotenv set .ddev/.env --jotform-api-key=<your-full-access-key>
ddev restart
```

That exposes it inside the container as `JOTFORM_API_KEY` (never commit
`.ddev/.env`). Then create a Key that reads from that variable — either in the UI at
**Configuration → System → Keys** (`/admin/config/system/keys`) with the
**Environment** provider, or from the command line:

```bash
ddev drush key:save jotform_api_key --label='Jotform API Key' \
  --key-type=authentication --key-provider=env \
  --key-provider-settings='{"env_variable":"JOTFORM_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

Remember the key must be scoped to **Full Access** on the Jotform side; a read‑only
key can list forms but can't create submissions.

## Step 2 — Configure the module

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Jotform API**
   (`/admin/config/services/jotform-api`).
3. Select the **Key** that holds your Jotform API key.
4. Review the **cache** settings (with the admin **Refresh** action for forcing a
   reload of form structure) and the **rate‑limiting** options, and save.

## Step 3 — Place a form

You have three ways to surface a Jotform form:

- **Block** — place a form block in a region at **Structure → Block layout**.
- **Field** — add the module's field to a content type at **Structure → Content
  types → *(bundle)* → Manage fields**.
- **Auto‑route** — reach a form directly at **`/jotform/{form_id}`**.

## Outbound network access (egress)

The module makes **outbound HTTPS requests to the Jotform REST API** to read form
structure and to submit and trigger automations. If your site runs behind an egress
firewall, allow outbound access to Jotform's API host, otherwise forms won't render
and submissions won't reach Jotform.

## Going further

The module's README covers the full step‑by‑step setup, the permissions table,
supported field types, validation behaviour, cache management, custom‑renderer
examples, and the event reference (subscribe to `JotformEvents::POST_SUBMIT` to add
site‑specific tracking without forking the module).
