<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vercel Deploy — agent index

Integrates **Vercel deployments** — permitted users trigger a Vercel deploy (rebuild a decoupled/static
front end) from Drupal (toolbar). Depends on core `toolbar`; provides permissions. Version **1.3.3**. Core
`^10.5||^11||^12`.

**Security:** the Vercel deploy hook/token is a **build-trigger capability** — store as a secret; grant the
deploy permission only to trusted editors (repeated triggers → cost/abuse). Deploy access gated by
permission.
