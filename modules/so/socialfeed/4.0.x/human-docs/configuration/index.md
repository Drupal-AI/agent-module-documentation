# Configuration

Social Feed is configured per platform: you enter credentials and display
options on the relevant settings form, then place the matching block. All the
settings pages require the **Administer socialfeed** permission.

## Where the settings live

Start at **Configuration → Web services → Social Feed**
(`/admin/config/services/socialfeed`). It links to three platform forms:

| Platform | Path |
|----------|------|
| Facebook | `/admin/config/socialfeed/facebook` |
| X (Twitter) | `/admin/config/socialfeed/twitter` |
| Instagram | `/admin/config/socialfeed/instagram` |

> **A note on credentials and secrets.** These forms store API keys and tokens
> in Drupal configuration. If you export configuration to code, treat those
> values as secrets: keep them out of version control (for example by overriding
> them from an environment variable in `settings.php`, or excluding them from
> your config export). Grant the **Administer socialfeed** permission only to
> trusted administrators.

## Facebook

The Facebook form collects the app and page details: **Page name**, **App ID**,
and **Secret key**. Its built‑in test/connect step resolves the page name to a
numeric **Page ID** and stores a permanent **Page access token** for you. Display
options include:

- **Number of posts** to show (default 10).
- **Post type** — show all types, or filter to status / photo / video /
  shared / published‑story posts.
- Toggles to **display the post picture** and **display video**.
- **Trim length** for long post text (default 120), and the **"Read More"**
  teaser text.
- **Hashtag** linking, whether to show a **timestamp**, and the **time format**
  (default `d-M-Y`).
- **Use Facebook style** — toggle the module's bundled default CSS.

Note that only **Page** posts are supported, not personal profiles.

## X (Twitter)

The X form collects **Consumer key**, **Consumer secret**, **Access token**,
**Access token secret**, **Bearer token**, and the numeric **Account ID** (a
bearer token and account ID are the essentials). Display options include the
**number of tweets** (default 3), **hashtag** and **@mention** linking, **trim
length** (default 280), the **teaser text**, and timestamp options — you can show
an absolute date (**time format**, default `d-M-Y`) or a relative "2 hours ago"
style via the **time ago** option — plus **Use Twitter style**.

To conserve paid API credits, responses are **cached for about an hour** (the
cache is cleared when you save the form). Remember the **free tier cannot read
posts** — paid API access is required.

## Instagram

The Instagram form collects **Client ID**, **App secret**, and **Redirect URI**,
along with display options: **picture count** (default 3), a **video
thumbnail** option, the **time format**, a **post link** toggle, and **Use
Instagram style**.

### Completing Instagram OAuth

Instagram uses an OAuth flow to obtain an access token:

1. Enter your Client ID, App secret, and Redirect URI, and save.
2. Follow the module's login/authorize link. The built‑in callback at
   `/socialfeed/instagram/auth` (also gated by **Administer socialfeed**)
   receives the authorization code, exchanges it for a short‑lived and then a
   long‑lived (~60‑day) token, and saves it automatically.
3. The **global** long‑lived token is auto‑refreshed after about 50 days. If you
   use a per‑block token override, you must renew that one manually.

Instagram requires a **Professional (Creator or Business)** account on the Graph
API.

## Placing the blocks

Once a platform is configured, place its block under **Structure → Block
layout** (`/admin/structure/block`):

- **Facebook Block**
- **X (formerly Twitter) Post Block**
- **Instagram Post Block**

Place all three together to build a combined social wall. Each block renders a
list of its platform's posts, cached for about an hour.

### Per‑block "Customize Feed" override

Each block has a **Customize Feed** checkbox, visible only to users with
**Administer socialfeed**. Tick it to give that block its own credentials and
display options instead of the global ones — useful when you want two blocks of
the same platform pointed at different accounts. If the global settings are
incomplete, the override is forced on. For the simplest setup, fill in the global
settings and leave Customize Feed off.

## Theming

Each platform's post markup comes from an overridable Twig template, and Facebook
adds a per‑post theme suggestion based on the post's status type. Post text from
the remote APIs is rendered as admin‑filtered markup (scripts and event handlers
are stripped, but a broad tag set is allowed) — it is only as trustworthy as the
connected account. If you need stricter output, override the template and run the
text through your own filter. See the [`agent/`](../agent/start.md) docs for the
full list of theme hooks and preprocess behaviour.
