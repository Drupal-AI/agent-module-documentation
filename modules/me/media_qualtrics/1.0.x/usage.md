<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Qualtrics adds a "Remote Media - Qualtrics" field formatter (built on the Media Remote module) that renders a Qualtrics survey/form URL stored in a plain string field as a responsive, auto-resizing `<iframe>` embed, gated by an admin-managed list of allowed Qualtrics hosts.

---

The module extends `media_remote`'s `MediaRemoteFormatterBase` with a single field formatter plugin (`media_qualtrics`, label "Remote Media - Qualtrics") that applies to `string` fields. It builds a URL regex from the configured `allowed_hosts` list (default `https://qualtrics.com`, plus any custom Qualtrics domains or vanity URLs), and only renders values whose URL matches one of those hosts — anything else is skipped. Matching values are emitted through the `media_qualtrics` theme hook / `media-qualtrics.html.twig` template as an `<iframe class="qualtrics-embed-container">`, with a `Q_CHL=si` query parameter appended so Qualtrics can post height changes back to the parent page, and a fallback "public form" link for browsers where the embed fails. A JS controller library (`media_qualtrics/qualtrics-controller`) listens for those height messages and resizes the iframe. Configuration lives at `/admin/config/media/qualtrics` (route `media_qualtrics.allowed_hosts_settings`, permission "administer qualtrics allowed hosts"), where hosts are entered one per line and validated to be bare `https://` domains. When the CSP module is present, an event subscriber automatically appends the allowed hosts to the `frame-src` directive on non-admin routes so the embeds are not blocked.

---

- Embed a Qualtrics survey on a node by pasting its `/jfe/form/...` URL into a string field formatted with "Remote Media - Qualtrics".
- Add a Qualtrics feedback form to a landing page as an auto-resizing iframe that grows with the survey content.
- Allow a custom Qualtrics vanity domain (e.g. `https://survey.example.com`) so its embeds render and pass validation.
- Restrict which Qualtrics domains editors may embed by curating the allowed-hosts list.
- Automatically extend the site's Content Security Policy `frame-src` to cover Qualtrics hosts when the CSP module is enabled.
- Provide a graceful "view it on qualtrics.com" fallback link for users whose browser blocks the iframe.
- Collect survey responses inline on the site instead of sending users off to Qualtrics.
- Store survey URLs in a simple text field rather than creating a bespoke media type.
- Reuse the same Qualtrics embed field across multiple content types via Manage form/display.
- Prevent arbitrary external iframes by only rendering URLs that match approved Qualtrics hosts.
- Support both `/jfe/form/[survey-id]` and `/se/?SID=[survey-id]` Qualtrics URL styles.
- Give editors a copy-paste workflow: paste the survey link, pick the formatter, done.
- Localise/scope embeds by configuring different allowed hosts per environment via config overrides.
- Auto-derive a media default name ("Qualtrics from <url>") when used through Media Remote's flows.
- Keep survey embeds responsive on mobile through the shipped `qualtrics-styles.css` and JS resizer.
- Add a self-service Qualtrics form to a "Contact us" or "Book a demo" page.
- Present the same survey on many pages by referencing the string field value.
- Audit and centrally manage every Qualtrics domain the site is allowed to frame.
- Avoid mixed-content issues by enforcing `https://` on every allowed host at validation time.
- Use it alongside Media Remote's other providers (YouTube, Vimeo, etc.) for a consistent remote-embed field pattern.
- Embed post-purchase or post-event survey forms directly in confirmation pages.
