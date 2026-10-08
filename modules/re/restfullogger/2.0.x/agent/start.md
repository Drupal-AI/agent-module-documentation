<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RESTful Logger — agent index

A **REST resource for POSTing log messages into Drupal's logger** (watchdog/dblog — centralize decoupled/
integration logs). Depends on core `rest`; provides permissions. Version **2.0.2**. Core `^10||^11`.

Access correctly gated — POST checks the **`post log messages`** permission. Keep it **restricted to trusted
integrations** (a poster could spam/inject log entries); consider rate-limiting; don't push sensitive data.
No other access role.
