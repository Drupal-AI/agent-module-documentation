# Configuration

Configuring Pusher mini is a two-part job: first store your credentials in a **Key**
entity, then point the settings form at that Key and fill in your app details.

## Step 1 — Create the credential Key

Pusher mini keeps your app key and secret in a Key entity rather than in module
config, so the secret never lands in exported configuration.

1. Go to **Configuration → System → Keys** (`/admin/config/system/keys`) and click
   **Add key**.
2. Choose the **Pusher** key type (provided by this module). This key type holds
   two values: the **app key** and the **app secret**.
3. Pick a **key provider** for where the value actually lives. For a secret, the
   most robust choice is the **environment** provider, so the value is read from an
   environment variable at runtime rather than stored in the database or a file.
   With DDEV you can set that variable safely:

   ```bash
   ddev dotenv set .ddev/.env --pusher-app-secret=<your-secret>
   ddev restart
   ```

   (`--pusher-app-secret` becomes the environment variable `PUSHER_APP_SECRET`;
   keep `.ddev/.env` out of version control.)
4. Save the key. You will select it by name on the settings form in the next step.

## Step 2 — Fill in the settings form

Go to **Configuration → Web services → Pusher mini**
(`/admin/config/services/pusher-mini`). You need the **administer pusher_mini**
permission.

- **Key** — choose the Key entity you created above. Both the server-side Pusher
  factory and the browser bootstrap read the app key/secret through this Key. Only
  the app key is ever sent to the browser.
- **App id** — your Pusher application id.
- **App cluster** — the Pusher cluster your app lives in (for example `eu`,
  `mt1`), matching what you see in the Pusher dashboard.
- **Disable auth** — when ticked, the user-authentication endpoint is not offered
  to the client. Turn this on if you only use public channels and never need to
  authenticate individual users.

### Front-end client options

These map onto the Pusher JS client configuration that is injected into the page:

- **Force TLS** — keep the browser's WebSocket connection over TLS.
- **Enable stats** — toggle Pusher's client-side stats reporting.
- **WS host / WS port / WSS port** — override the WebSocket host and ports. Leave
  these at their defaults unless you connect to a non-standard or self-hosted
  server.

### Self-hosted (Soketi / Pusher-compatible) server

If you run your own Pusher-compatible backend instead of pusher.com, fill in the
optional **server** settings — **host**, **scheme**, **port**, **timeout**, and
**use TLS**. When no server host is configured (the default, i.e. you are using
pusher.com), outbound connections force TLS on automatically.

## Step 3 — The user-auth endpoint

If you left **Disable auth** unticked, Pusher mini exposes
`POST /pusher/user-auth`. It is available only to authenticated users who also hold
the **pusher_mini authenticate** permission, and it validates the incoming
`socket_id` (rejecting anything missing or longer than 32 characters) before
returning the signed authentication payload for the current user. You do not
configure anything else here — your front-end Pusher client calls this URL
automatically when it subscribes to a user channel.

## Save

Click **Save configuration**. Reload a front-end page as a user with
**pusher_mini use** and confirm the `window.PusherConfiguration` script now
reflects your settings.
