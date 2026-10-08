<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Message GC Notify — agent index

**Sends messages via the GC Notify service** (+ a Notifier plugin for Message Notify). Provides permissions.
Version **1.0.3**. Core `^10||^11`.

Messaging/integration — sends **recipient PII + content to the GC Notify API** (egress — disclose); **API key** as
a secret (env/Key, HTTPS). No access role beyond permission.
