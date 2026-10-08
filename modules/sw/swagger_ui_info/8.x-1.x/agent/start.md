<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swagger UI Info — agent index

**Displays API information via an embedded Swagger UI** (browse/try an OpenAPI spec). Provides permissions.
Version **8.x-1.3**. Core `^9.4||^10||^11`.

Developer/API-docs — reveals the **API surface**: gate the route (its permission), don't expose internal
endpoints; "try it" calls use the caller's auth. No access role beyond permission.
