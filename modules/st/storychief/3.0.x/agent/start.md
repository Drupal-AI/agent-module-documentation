<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# StoryChief — agent index

Receives/publishes **stories pushed from StoryChief** (write once, distribute). Incoming webhook is
**HMAC-SHA256 authenticated**: `StoryChiefAccessCheck` recomputes the MAC (keyed with the API key) and
compares via **`hash_equals`**, forbidding on mismatch — forged pushes rejected. Config at
`storychief.admin`; provides permissions. Version **3.0.6**. Core `^9.3.0||^10||^11`.

**Store the StoryChief API key as a secret** (it authenticates the webhook). Pushed stories become
content.
