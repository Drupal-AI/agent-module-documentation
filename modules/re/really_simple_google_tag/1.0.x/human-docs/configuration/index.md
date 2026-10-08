# Configuration

Configuring Really Simple Google Tag is intentionally a five‑step affair: enter
your container ID(s), decide on a couple of path conditions, optionally exclude
some roles, and save.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Open the module's settings form — via **Extend**, then the module's
   **Configure** link, or from the site's configuration section.

## The settings, field by field

- **Google Tag Manager tag IDs** — a text area where you enter one or more
  container IDs in the format `GTM-XXXXX`, **one per line**. Every ID you list gets
  its snippet added to the qualifying pages, so you can run several containers at
  once.
- **Include on `/admin` paths** — whether the tag should also load on
  administrative pages (paths beginning with `/admin`). **Default: no** — leave it
  off so you're not tracking backend activity.
- **Include on `/user` paths** — whether the tag should load on user pages (paths
  beginning with `/user`, such as login and account pages). **Default: yes**.
- **Excluded roles** — optionally choose one or more roles that should **not** load
  Google Tags. Use this to keep, say, authenticated editors or administrators out
  of your analytics.

## Save

Click **Save**. That's it — the module now inserts your container snippet(s) on
every page that matches your conditions. To confirm, load a front‑end page and
check the HTML source for the GTM snippet.

> **Remember:** what your tags actually do (which trackers and cookies they load)
> is configured in the GTM console, not here. Make sure your cookie‑consent and
> privacy handling covers whatever those tags load.
