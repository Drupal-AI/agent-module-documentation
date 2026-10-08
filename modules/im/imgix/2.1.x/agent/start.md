<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imgix — agent index

Renders Drupal images through **Imgix** (real-time image processing + CDN) — on-demand derivatives served
from Imgix. Depends on core `file`. Version **2.1.2**. Core `^9.3||^10||^11`.

**Security:** store the Imgix secure-URL/API token as a secret (sign URLs); images served from Imgix's CDN
— **don't route access-restricted images through a public CDN source**. Media/performance; no access role.
