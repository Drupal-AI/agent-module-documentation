<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the site-icon formatter

1. Add (or reuse) a **Link** field on your entity/bundle.
2. At *Manage display* for that bundle, set the field's format to **Link (favicon)** (`social_media_link`).
3. Configure the formatter:
   - **Display view** — `Icon only`, `Icon and URL`, or `Icon and Title`.
   - **Icon size** — `64px` (large), `32px` (medium, default) or `16px` (small).
4. Ensure the public files directory is writable; icons are cached under `public://social-media-icons/`.

## Behaviour & operational notes
- On render, the host of each link is parsed and an icon is requested from a favicon service via `http_client`.
- The response must have a content type in the allow-list (ico/png/gif variants) and be ≤ 1 MB (`MAX_BYTES`), otherwise the default icon is shown.
- Successful icons are written once and reused; delete the cached file to force a refresh.
- Provide `images/icons/default_social_link.svg` in your active theme to override the module's default fallback icon.
- Internal (`internal:`) and entity (`entity:`) URIs are converted to absolute URLs before the host is parsed.
- Requires outbound network access; fetch/write failures are logged to the `Social media icon` channel and fall back to the default icon.
