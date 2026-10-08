# Configuration

Everything lives under **Configuration → Web services → Campaign Monitor**
(`/admin/config/services/campaignmonitor`). You need the **Administer campaign
monitor** permission (an administrator by default) to reach it.

## Step 1 — Connect your account

On the main settings form, enter:

- **API Key** — your Campaign Monitor API integration key.
- **Client ID** — your Campaign Monitor Client ID. This one is important:
  entering a valid Client ID is what unlocks the general settings and lets the
  module build the SDK client object.

Save the form. The key is stored in the `campaignmonitor.settings` config
object. If you would rather not type it into the UI — for example when scripting
a deployment — you can set it from the command line:

```bash
ddev drush cset campaignmonitor.settings api_key 'YOUR_KEY' -y
ddev drush cset campaignmonitor.settings client_id 'YOUR_CLIENT_ID' -y
```

> **A note on secrets:** the API key is stored in configuration by design. Treat
> your exported config accordingly, and prefer keeping production keys out of
> version-controlled config where you can.

## Step 2 — General settings

Once a Client ID is in place, the general settings become available:

- **Cache timeout** — how many seconds the module holds on to fetched list,
  subscriber, stats, and archive data before asking Campaign Monitor again.
  Defaults to **360** seconds. A higher value means fewer API calls but staler
  data.
- **Enable newsletter archive** — turns on a viewable newsletter archive for
  users who hold the *access archive* permission.
- **Enable logging** — when ticked, Campaign Monitor API errors are written to
  the Drupal log so you can troubleshoot connection problems.
- **Instructions** — the explanatory text shown above the newsletter selection
  on subscribe forms.
- **Subscription confirmation text** — the message shown after a visitor
  successfully subscribes. You can use the `@name` token (the list name) and
  `@interests` in the text.
- **Use cron** — when ticked, subscribe/unsubscribe operations are queued to the
  `campaignmonitor_queue_cron` queue and processed on the next cron run instead
  of calling the API immediately. This keeps the visitor's page load fast.
- **Batch limit** — how many queued items to process per cron run when cron mode
  is on.

## Step 3 — Enable your lists

Open the **Lists** tab (`/admin/config/services/campaignmonitor/lists`). The
module contacts your account and shows the subscriber lists it finds. For each
list you can:

- **Enable** it — only enabled lists can be used on the site and offered in the
  subscribe block. (There is a matching **Disable** action.)
- **Edit** it — open the per-list settings to choose how its subscribe form
  looks: whether to show a name field and which fields supply the first/last
  name, whether the list appears on the registration form and the user profile
  tab, its description text, and which **custom fields** to collect (and whether
  each is required).
- **Delete** it or **Clear cached list data** — the *Clear cache* action forces
  the module to re-fetch the list data from Campaign Monitor on demand.

## Step 4 — Place the subscribe block

Go to **Structure → Block layout** and place the **Campaign Monitor Signup**
block in a region. In its block settings you choose the list behavior:

- **Single** — the block signs visitors up to one specific list you name.
- **User select** — the block shows several enabled lists and lets the visitor
  pick which one(s) to join.

The block collects an email address (pre-filled with the logged-in user's email
when available) plus any name and custom fields you configured for the list, and
subscribes the visitor on submit. The block itself is not gated by a module
permission — its visibility is controlled by the normal Drupal block placement
rules, and it is meant to be shown to anonymous visitors.

## Permissions

Set these under **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| **Administer campaign monitor** | Full access to the settings form, the lists overview, and enabling/disabling/editing/deleting lists. Treat as a trusted-admin permission. |
| **Access archive** | View the newsletter archive. |
| **Join newsletter** | Join newsletters. |
