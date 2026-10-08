# Configuration

oEmbed Configuration adds a single settings page where you set parameters for each
supported provider. The options adjust how embeds render and behave — they don't
change which media you can embed, just how each embed is requested and displayed.

## Open the settings form

1. Log in as a user with the module's permission (an administrator by default).
2. Go to **Configuration → Media → oEmbed Configuration**.

## Per‑provider options

Set the parameters for the providers you use. The currently supported options are:

- **YouTube** — **autoplay** (start the video automatically when it loads).
- **Vimeo** — **autoplay**, **do not track**, **background**, and related
  parameters.
- **X / Twitter** — **hide threads**, **do not track**, **theme** (light/dark), and
  related parameters.
- **Instagram** — **omit script**, and **authentication**.

Set only what you need for each provider; leave the rest at their defaults.

## Base‑path override (privacy)

For **every** provider, you can override the **base path** used for the embed
request. The headline use is privacy: swap `youtube.com` for
`youtube-nocookie.com` so embeds don't set tracking cookies until the visitor
interacts. Use the same mechanism for any provider whose privacy‑friendly host you
prefer.

## Handling the Instagram authentication credential

If you enable Instagram **authentication**, that involves a credential. Treat it as
a secret: rather than pasting it into plain configuration, prefer storing it in an
environment variable and referencing it through the
[Key](https://www.drupal.org/project/key) module (which the project recommends for
a more secure experience). With DDEV, `ddev dotenv set .ddev/.env
--instagram-token=<value>` then `ddev restart`, and reference the value by name.
Make sure your outbound egress rules allow the site to reach the provider's oEmbed
endpoint.

## Save

Click **Save configuration**. Reload a page containing an oEmbed video (clearing
caches if needed) and confirm the behavior — autoplay, do‑not‑track, the nocookie
host, and so on — matches what you set.

## A note on trust

oEmbed embeds pull in third‑party content. Core sandboxes those embeds and this
module doesn't loosen that, but as always, only enable providers you actually trust
to serve content on your pages.
