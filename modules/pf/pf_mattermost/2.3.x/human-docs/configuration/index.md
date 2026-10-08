# Configuration

To connect Drupal to Mattermost you fill in a short settings form and then enable
the channel in the Push Framework. You'll need three values from Mattermost: the
server domain, a personal access token, and the target channel's id.

## 1. Create a Mattermost personal access token

In Mattermost, generate a **personal access token** (follow Mattermost's own
personal‑access‑token documentation). The token acts as the credentials Drupal
uses to post, so create it under an account with only the access it needs. You'll
also want the **id of the channel** you intend to post into.

## 2. Fill in the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → System → Push framework → Mattermost**
   (`/admin/config/system/push_framework/mattermost`).
3. Complete the fields:
   - **Domain** — your Mattermost server URL.
   - **Token** — the personal access token you generated. *(This is stored in the
     module's configuration in plain text, so keep the settings form restricted to
     trusted administrators.)*
   - **Channel id** — the id of the Mattermost channel to post to.
4. Save.

## 3. Enable the channel and test

In the Push Framework, make sure the **Mattermost** channel is **enabled** so
notifications are routed through it. Then trigger or send a test notification and
confirm a post appears in your Mattermost channel. When a notification is sent,
the module authenticates with the token, converts the notification's HTML to
Markdown/plain text, and creates the post.

## Using it with DANSE

The module also ships a **DANSE recipient‑selection plugin**, so if you use DANSE
you can choose Mattermost as a recipient for content events — for example, to
alert a team channel whenever certain content is created or changed.

## Notes on the token

- The transport uses the driver's default Guzzle behavior, which keeps **TLS
  certificate verification on** — connections to Mattermost are verified.
- The token is held in the module's config (plain text). This is standard for the
  channel and there is no Key‑entity option here, so the practical protection is
  to **limit who can reach the settings form** (it requires *Administer site
  configuration*) and to scope the Mattermost token narrowly. If you export
  configuration, be mindful that the token travels with it.
