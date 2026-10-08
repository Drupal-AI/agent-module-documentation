<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Spotify Now Playing provides now-playing widgets/endpoints from Spotify.

---

Spotify Now Playing **shows what's playing on Spotify** — widgets and endpoints that display the currently/
recently playing track from a Spotify account, via the Spotify API. It provides its own permissions.

Use it to show a Spotify now-playing widget. It is an integration feature. Security/data handling: it authenticates
to the **Spotify API** with **OAuth credentials/tokens** (store as secrets — env/Key — over HTTPS) and calls
Spotify (egress); if it exposes an endpoint that returns the now-playing data, ensure that endpoint only reveals
what you intend. It has no access-control role beyond its permission. Configure the Spotify credentials.

---

- Show Spotify now-playing.
- Provide widgets/endpoints.
- Display the current track.
- Provide its own permissions.
- Serve integration.
- Use the Spotify API.
- Authenticate with Spotify OAuth credentials/tokens (store as secrets, HTTPS).
- Call Spotify (egress).
- Expose only intended now-playing data on any endpoint.
- Have no access-control role beyond permission.
- Configure the Spotify credentials.
- Handle Spotify now-playing.
- Show tracks.
- Configure the client.
- Display playing.
- Handle the integration.
- Fetch now-playing.
- Show the widget.
- Secure the tokens.
- Provide Spotify now-playing.
