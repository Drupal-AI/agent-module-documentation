<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Status Code Test — agent index

Adds a **configurable endpoint that returns a chosen HTTP status code** (test monitoring/LB/error handling).
Provides permissions. Version **1.1.1**. Core `^10.2||^11||^12`.

Developer/testing — gate by its permission, don't leave on production (abuse/fake outages). No content/access
role beyond permission.
