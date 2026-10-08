<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Push — agent index

Sends **browser web push notifications** — manages subscriptions and dispatches via **VAPID**. Depends
on core `rest`, `serialization`, `user`. Requires PHP 8.0. Config at `web_push.settings`; provides
permissions. Version **2.1.0**. Core `^10.3||^11`.

**Security:** store the **VAPID private key as a secret** (it authorizes sending as your origin — never
commit); require user consent (browsers enforce a grant); access-control the subscription REST
resources.
