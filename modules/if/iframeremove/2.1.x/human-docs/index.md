# IFrame Removing Filter — manual setup guide

**IFrame Removing Filter** (`iframeremove`) is a text-format filter that strips
`<iframe>` embeds out of rendered content unless the iframe's source hostname is on a
domain allowlist you control. It's a lightweight, targeted security tool: when a text
format allows Full HTML, authors — or content pasted from elsewhere — could embed
iframes pointing anywhere. This filter lets you permit only trusted embed providers
(YouTube, Vimeo, your own domains) and quietly removes everything else when the
content is displayed.

The filter runs on display: it looks at each iframe's `src`, extracts the hostname,
and drops any iframe whose host is empty, unparseable, or not matched by your
allowlist. Matching supports `*` wildcards, so you can allow a whole domain and its
subdomains (for example `*.example.com`). Iframes with no `src` at all are left
alone. Because it transforms the markup as it renders (an "irreversible" filter),
it's meant for display, not for round-tripping exact source.

There is **no global settings page** — the filter is configured **per text format**,
alongside Drupal's other filters. It has no permissions and no dependencies. Its one
setting is the domain whitelist. Its configuration lives inside the text format
config, so it deploys with the rest of your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page of its own. You enable and configure the filter on each
text format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format you want to protect (typically **Full HTML** or any format that allows
   `<iframe>`).
2. Under **Enabled filters**, tick **iFrame remove filter**.
3. In **Filter settings**, fill the **Whitelist** textarea — one domain per line.
   Only iframes whose `src` host matches an entry survive; everything else is stripped
   on display.
   - `youtube.com` matches exactly that host.
   - `*.youtube.com` (or `*youtube.com`) also allows subdomains.
   - `*` matches anything.
   - An **empty whitelist removes all iframes**.
4. Under **Filter processing order**, place this filter **after** the HTML-limiting
   and WYSIWYG filters so it runs on the cleaned markup.
5. Save the format.

From then on, when that format is rendered, only iframes from your allowlisted hosts
appear; all others are removed. Because it works at render time, you can tighten or
loosen the allowlist later without editing any content — the change applies the next
time the content is displayed.
