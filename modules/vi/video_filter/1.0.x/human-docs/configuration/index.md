# Configuration

Video Filter is a text‑format filter, so all of its configuration lives on the text
formats where you enable it — there is no separate settings page.

## Enable the filter on a text format

1. Log in as a user with permission to administer filters (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit the format you want (for example **Full HTML**, or a dedicated authoring
   format — see the security note below about which formats are appropriate).
4. Under **Enabled filters**, tick **Video Filter**.
5. Configure its options under **Filter settings** (below), then **Save
   configuration**.

## Per‑format settings

Under **Filter settings → Video Filter** you'll find:

- **Width** *(default 400)* — the default player width. Leave it blank to emit no width
  attribute and size the player with CSS instead.
- **Height** *(default 400)* — the default player height.
- **Enabled plugins** — a checkbox list of the provider codecs (YouTube, Vimeo,
  Dailymotion, Twitch, Spotify, and dozens more). Only the providers you tick will be
  matched. Ticking just the providers you actually use is the safest choice. Note: if
  you leave **every** box unchecked, the module falls back to trying *all* installed
  codecs.
- **Allow multiple sources** *(default on)* — when on, an author can list several URLs
  separated by commas (`[video:URL1,URL2,URL3]`) and the filter picks one at random on
  render.

## Author tag syntax

Once the filter is enabled, editors write a `[video:…]` tag in the body. Examples:

```
[video:https://www.youtube.com/watch?v=uN1qUeId]
[video:https://youtu.be/uN1qUeId autoplay:1]
[video:https://www.youtube.com/watch?v=ID width:640 height:360]
[video:https://www.youtube.com/watch?v=ID ratio:4/3]
[video:https://www.youtube.com/watch?v=ID align:right]
[video:URL1,URL2,URL3]           # random source, needs "Allow multiple sources"
```

Inline options after the URL let an author override the per‑format defaults for a single
video:

- **width:** and **height:** — the player size for this embed.
- **ratio:** — force an aspect ratio, written as `16/9`, `4/3`, and so on.
- **align:** — `left`, `right`, or `center`.
- **autoplay:**, **loop:**, **start:**, and other provider‑specific options where the
  codec supports them (YouTube, for example, understands `autoplay`, `loop`, `start`,
  `theme`, `color`, and playlists via a `&list=` URL parameter).

Option values are restricted to letters, numbers, and slashes, so authors can't smuggle
markup in through an option. When the filter is active on a format, Drupal automatically
shows editors a tip listing the enabled providers and example syntax under the format's
description.

## What editors see if a URL doesn't match

If an author pastes a URL that none of the enabled providers recognize, no player is
produced for that tag — so double‑check that the relevant provider is ticked under
**Enabled plugins**.

## Security — only enable on trusted formats

Video Filter produces embed HTML (iframes), and filter output is treated as trusted
markup. Because of that:

- **Enable it only on text formats used by trusted authors.** The typical mistake is
  turning it on for a low‑trust format so anonymous or basic users can embed video — that
  hands untrusted users the ability to output raw embed markup.
- On any format reachable by lower‑trust roles, also enable a **Limit allowed HTML tags**
  (`filter_html`) filter and make sure the filter ordering is sensible, so untrusted
  markup is still constrained.

Treating Video Filter as a convenience for trusted editors — not as a general‑purpose
embed tool for the public — keeps you on the safe side.

## For developers — adding a provider

Each provider is a plugin of the module's `video_filter` plugin type. To support a
service that isn't built in, write a `@VideoFilter` codec class (declaring an `id`,
`name`, one or more `regexp` patterns, and an aspect `ratio`) and implement `iframe()`
or `html()` to build the embed. After a cache rebuild it appears in the **Enabled
plugins** checkboxes. The bundled **video_filter_example** submodule is a working
template. Modules can also adjust the assembled video just before render via
`hook_video_filter_video_alter()`.
