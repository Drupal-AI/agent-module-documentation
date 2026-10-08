<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SMS System — agent index

API/tool for **sending SMS triggered by events** (via an SMS gateway). Depends on `date_popup`; provides
permissions. Version **1.1.0**. Core `^9.5||^10||^11`.

**Security:** store gateway credentials as secrets; SMS costs money — guard event triggers against
spam/cost-abuse (a public trigger = abuse vector); recipient numbers are PII (consent/privacy). No access
role.
