<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Edit Access by Term — agent index

**Restricts node edit access by taxonomy term** (user/role allow-lists on terms). Provides permissions. Version
**2.0.0**. Core `^11||^12`.

The check runs in `hook_form_alter` (throws `AccessDeniedHttpException` on the node edit form for disallowed
users).
