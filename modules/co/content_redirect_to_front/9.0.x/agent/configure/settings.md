<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Redirect to Front — configure (content_redirect_to_front)

**Settings route:** `/admin/config/content/content_redirect_to_front_settings`
(`content_redirect_to_front.settings`, permission `access content_redirect_to_front form`).

## Fields
- **Entities to redirect** (`enabled_types`) — checkboxes of every entity type. A checked
  type redirects all its bundles by default.
- **Bundle specific settings** (`bundle_settings`) — per entity type, tick individual
  bundles to redirect only those. If a type is checked but no bundle is ticked, all
  bundles redirect.
- **Message settings** (`message_settings.message_enabled`, `message_content`) — optional
  warning shown to users who hold the skip permission when they view a would-be-redirected
  page.

## Permissions
- `access content_redirect_to_front form` — reach the settings form.
- `skip redirecting to front for all content` — bypass the redirect entirely (the user
  sees the canonical page; optionally a warning message).

## How the redirect works
`RedirectSubscriber::onKernelRequest` runs on `KernelEvents::REQUEST` at **priority 28**
(above Dynamic Page Cache at 27). It matches the current route against
`/entity\.(?P<content_type>.+)\.canonical/U`, checks the type/bundle config, and if the
entity is enabled returns a `TrustedRedirectResponse` to the front page for the current
language. Users with the skip permission are exempt (and optionally shown the message).
The front page is never redirected.
