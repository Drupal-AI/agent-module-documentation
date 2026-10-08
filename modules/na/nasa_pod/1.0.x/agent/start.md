<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NASA Pic of the Day (nasa_pod) — agent index

**Block + route showing NASA's Astronomy Picture of the Day from the APOD API.**

- **Version:** 1.0.x (dev-1.0.x checkout)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Route:** `nasa_pod.nasa_pod_controller_showAstroPic` → `nasa/pic-of-the-day` (perm `access content`).
- **Block:** `NasaPodBlock`. **Service:** `nasa_client` (Guzzle via `@http_client_factory`, base_uri `https://api.nasa.gov`). **Library:** `nasa_pod/nasa_pod_library`.
- **Templates:** `nasa-pod-block.html.twig`, `nasa-pod-detail.html.twig`.

**Access:** read-only public display gated by `access content`. The NASA API key defaults to a built-in value in `src/Service/NasaClient.php` (`getImage`/`getImageDetails`); there is no admin form for it.
