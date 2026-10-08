<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Youtube API is a developer toolkit wrapping the YouTube Data API v3.

---

**Youtube API** provides a service/toolkit that wraps Google's YouTube Data API v3. Per-resource classes (videos, channels, playlists, search, comments, captions, etc.) build requests against the fixed googleapis.com base URL and execute them with the Guzzle `http_client` (default TLS), appending the configured API key. It ships an admin settings form (`youtubeapi.settings`) and a test page, both gated by `access administration pages`. The request host is fixed in code, so it is not a URL-proxy/SSRF surface.

Use it as a base to fetch YouTube data (videos, channels, playlists) from Drupal code.

---

- Wrap the YouTube Data API v3.
- Fetch video metadata from YouTube.
- Fetch channel and playlist data.
- Search YouTube from Drupal code.
- Retrieve comments and comment threads.
- Retrieve captions and categories.
- Build requests to a fixed googleapis host.
- Execute requests with Guzzle over HTTPS.
- Append a configured API key to requests.
- Provide per-resource API classes.
- Configure the API key in admin settings.
- Test API calls from a test page.
- Gate config/test behind 'access administration pages'.
- Serve as a base library for YouTube features.
- Decode JSON responses to arrays.
- List playlist items and subscriptions.
- Fetch i18n languages/regions.
- Integrate Drupal with Google YouTube.