<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search — agent index

Creates **search pages powered by Google Vertex AI Search** (enterprise/generative search over your data
store). Depends on core `search`, `token`; provides permissions. Version **1.12.0**. Core `^10.1||^11||^12`.

**Security:** store Google Cloud credentials (service-account key/OAuth) as **secrets**; queries/content sent
to Google (data-handling); ensure results **respect content access** (don't surface restricted content). No
access role beyond permission.
