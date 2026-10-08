# Configuration

Liveblog's global settings — the notification channel and its credentials — live on
one admin form. After that, most of the work is content: creating liveblog nodes
and adding posts.

## Open the settings

1. Log in as a user with the **administer liveblog settings** permission.
2. Go to **Configuration → Content authoring → Liveblog**
   (`/admin/config/content/liveblog`).

## Choose a notification channel

Real‑time delivery is abstracted behind a notification‑channel plugin. On the
settings form you select the active channel:

- **Pusher** (from the bundled `liveblog_pusher` submodule) pushes new and updated
  posts to readers over Pusher's socket service in real time.
- **No push channel** — if you don't select one, the front end falls back to
  polling the JSON post‑list endpoint. This still updates readers, just less
  instantly and with more requests.

Developers can add support for another websocket provider by implementing a custom
notification‑channel plugin; it then becomes selectable here.

## Enter your Pusher credentials

With the Pusher channel selected, enter the credentials from your Pusher app:

- **App ID**
- **Key**
- **Secret**
- **Cluster**

> **Treat the Pusher secret as sensitive and keep it out of Git.** The secret grants
> the ability to publish to your Pusher channels. If you export and deploy Drupal
> configuration, avoid committing the secret value — prefer a per‑environment
> override. A clean pattern with DDEV is to store the value in an environment
> variable and reference it from your site rather than hard‑coding it:
>
> ```bash
> ddev dotenv set .ddev/.env --pusher-secret=<value>   # never commit .ddev/.env
> ddev restart
> ```
>
> Then supply the value to Drupal through a settings override (`getenv('PUSHER_SECRET')`)
> so the secret never lands in exported config or the repository.

Also note that pushing posts to Pusher is an **outbound call to a third‑party
service** — confirm that this egress is acceptable for your site before enabling
it.

## Set permissions

Liveblog defines per‑operation permissions:

- **add liveblog_post entity**, **edit liveblog_post entity**, **delete
  liveblog_post entity** — grant these to your editorial roles so they can manage
  posts.
- **administer liveblog settings** — restrict this to administrators, since it
  controls the notification channel and its credentials.

Review and assign these at **People → Permissions** (`/admin/people/permissions`).
Remember that *reading* the published post stream is intentionally open to
anonymous visitors.

## Create a liveblog and post to it

1. Create a **Liveblog** node (the `liveblog` node type). You can set per‑liveblog
   fields such as the default number of posts to load and the initial post count.
2. Add `liveblog_post` entries through the AJAX‑driven post form — each can include
   a title and body, an optional highlights taxonomy term, and an optional location
   via Simple Google Maps.
3. Posts stream to readers automatically — pushed over Pusher if configured, or
   picked up by the polling fallback otherwise.

Liveblog also exposes posts over core REST, which supports headless posting if you
need it.
