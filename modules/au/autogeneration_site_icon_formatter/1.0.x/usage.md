<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field formatter for core Link fields that renders each URL together with the target site's favicon.
---
The formatter (`social_media_link`, in `AutoGenerationSocialMediaLinkFormatter`) parses the host from each link value and requests an icon for that host from a favicon service using the core `http_client`. The response is validated against an allow-list of icon/image content types and a 1 MB size cap, then written to `public://social-media-icons/` and reused on later renders; a bundled or theme-provided default SVG is shown when no icon can be fetched (bad URL, wrong type, oversize, or a request error). Display options let editors choose icon-only, icon+URL or icon+title, and a small/medium/large icon size.

Operationally the module performs a server-side outbound HTTP request per distinct host at render time and creates files under the public files directory, so it needs outbound network access and a writable public filesystem. The host that is looked up comes from the (editor-controlled) link field value; it is appended as a path segment to a fixed third-party favicon service rather than being fetched directly. This is a field-display module: it has no routes, permissions or forms of its own.
---
- Show a favicon next to each link in a Link field.
- Display social-media profile links with their site icons.
- Choose icon-only, icon + URL, or icon + title display.
- Select a small (16px), medium (32px) or large (64px) icon size.
- Cache fetched favicons in `public://social-media-icons/` for reuse.
- Fall back to a default SVG icon when no favicon is available.
- Override the default icon by placing `images/icons/default_social_link.svg` in your theme.
- Render a footer/header row of social links with recognizable icons.
- Reject non-image responses via the content-type allow-list.
- Cap fetched icons at 1 MB to avoid oversized downloads.
- Apply the formatter to any entity's Link field via Manage Display.
- Handle internal/entity URIs by resolving them to absolute URLs first.
- Escape host names when building cache filenames and CSS hooks.
- Log fetch/write errors to the `Social media icon` logger channel.
- Present a consistent icon set for partner or sponsor links.
- Avoid manual icon uploads by auto-generating them from URLs.
- Use the provided Twig template to customise link+icon markup.
- Display multiple links (multi-value field) each with its own icon.
- Gracefully render just the link when the host cannot be resolved.
- Refresh a cached icon by deleting the stored file.