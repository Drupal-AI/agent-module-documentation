<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vote Anon — agent index

**Enables anonymous (and authenticated) voting** on content (Views display). Depends on core `views`, `node`,
`user`. Provides permissions. Version **2.0.2**. Core `^10.3||^11||^12`.

User-engagement/voting — **anonymous votes are spoofable** (IP/cookie dedup is bypassable): rate-limit/CAPTCHA,
treat counts as approximate, don't use for security/money-sensitive decisions. No access role beyond
permission.
