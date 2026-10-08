<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Reference — agent index

Field type **referencing remote data elements via an external JSON:API** (reference items in another
system, not local entities). Config at `jsonapi_reference.json_api_reference_config_form`; provides
permissions. Version **2.0.0-alpha4**. Core `^10.2||^11`.

**Security:** endpoint is admin-configured (not open SSRF) — store its credentials as secrets, reach over
TLS, escape fetched data on output (external input); confirm configured endpoints are trusted.
