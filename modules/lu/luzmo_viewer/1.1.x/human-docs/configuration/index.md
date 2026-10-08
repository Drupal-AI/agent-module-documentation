# Configuration

Luzmo Viewer needs two things set up: the **module‑wide connection settings**
(your Luzmo credentials and endpoints), and a **Luzmo viewer field** on the
entity where you want dashboards to appear.

## Store the Luzmo credentials safely first

Your Luzmo **API key** and **token** are account‑level credentials. Do not paste
them into a file that gets committed, and do not hard‑code them. The recommended
pattern on this project is to keep the value in an environment variable and load
it through DDEV's dotenv support:

```bash
ddev dotenv set .ddev/.env --luzmo-authkey=<your-key> --luzmo-authtoken=<your-token>
ddev restart
```

That makes `LUZMO_AUTHKEY` and `LUZMO_AUTHTOKEN` available inside the web
container (keep `.ddev/.env` out of version control). Where the module or your
settings support it, reference the variable rather than typing the secret into
config — for provider‑style keys the [Key](https://www.drupal.org/project/key)
module lets you create a Key entity backed by the environment variable so the
secret never lands in exported configuration.

Also note that the embed talks to Luzmo's servers, so the site needs **outbound
network access** to Luzmo (and, if you use the remote embed library, so does the
visitor's browser).

## Open the settings form

Go to **Configuration → System → Luzmo settings**
(`/admin/config/system/luzmo-settings`). Fill in the following:

- **Authkey** — your Luzmo API key.
- **Authtoken** — your Luzmo token / API token key.
- **luzmo.js location** — where the Luzmo embed library `.js` file lives. The
  default uses the remote (hosted) version of the library; point it at a local
  copy if you prefer to self‑host for performance, privacy, or offline reasons.
- **Luzmo App Server** — the Luzmo app server URL. The default is
  `https://app.luzmo.com/`; change it only if your Luzmo instance uses a
  different server.

There is also an **Account settings** section for logged‑in and anonymous users,
where you define the user information Luzmo needs when the field **requests an
authorisation**. You only need this if you use authorisation (per‑viewer,
data‑scoped embedding); it is not required for simple key‑and‑token embedding.

Click **Save configuration**.

## Create an integration in Luzmo

In your Luzmo account, create an integration at
[app.luzmo.com/integrations](https://app.luzmo.com/integrations), select the
dashboard(s) you want to embed, and complete the process to obtain the key and
token. You can add more dashboards to the integration later **without**
regenerating the key and token.

## Add a Luzmo viewer field

1. On your content type (or other fieldable entity), go to **Manage fields** and
   add a **Luzmo viewer** field.
2. The form **widget** has no settings — you simply enter a dashboard ID on each
   piece of content.
3. On **Manage display**, the field's **formatter** lets you choose whether it
   should **request an authorisation**. Enable this only when you need per‑viewer,
   data‑scoped dashboards; if you turn it on, make sure the relevant users or
   sub‑organisations actually have permission to access the underlying data in
   Luzmo.

## Advanced: caching and altering authorisation

Two developer hooks are available for teams that need them:

- When authorisation is requested, the field uses a **per‑user cache** whose
  max‑age matches the authorisation inactivity interval. You can adjust the cache
  contexts from a `hook_preprocess_field()` implementation (for example to vary by
  a filter cookie).
- `hook_luzmo_viewer_dashboard_javascript_authorisation_alter()` lets a module or
  theme alter the authorisation settings before they are requested — for example
  to pre‑fill dashboard filters based on a cookie.

These are optional; a straightforward embed needs neither.
