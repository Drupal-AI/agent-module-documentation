<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login Attempts — agent index

Shows users their **remaining login attempts before core flood control locks the account** (reads `user.flood`
+ the core `flood` table; warns before temporary block). Requires PHP 8.3. Depends on core `user`. Version
**1.1.0**. Core `^10||^11`.

Security-adjacent UX — **builds on core flood control**, doesn't replace/weaken it (core still blocks). Minor:
reveals the remaining-attempt count. No access role.
