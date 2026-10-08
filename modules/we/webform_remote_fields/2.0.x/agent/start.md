<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Remote Fields — agent index

Custom **webform elements whose options/values are populated from a REST endpoint** (select/autocomplete
backed by an external API vs a static list). example/api-test submodules; provides permissions. Version
**2.0.2**. Core `^9||^10||^11`.

**Security:** the endpoint is **admin-configured**, fetched **server-side** (timeouts/caching; optional
follow-redirects). Not anon SSRF, but keep the endpoint on **trusted** hosts (follow-redirects/compromised
endpoint could reach internal hosts); treat fetched values as untrusted (escape). No access role.
