<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services Environment Variable Parameters — agent index

Sets Symfony **container parameters from `DRUPAL_SERVICE_*` environment variables** (12-factor config —
override CORS/etc. per-environment; `__`→`.`, nested arrays). Version **8.x-1.4**. Core `^8||^9||^10||^11`.

Config/DevOps — **implemented safely**: only matches the **`DRUPAL_SERVICE_` prefix** (client `HTTP_*`
headers never match), only overrides **existing** parameters, runs at **container-compile time** (values
from the trusted environment, not per-request input). Keep secrets in env, not committed. No access role.
