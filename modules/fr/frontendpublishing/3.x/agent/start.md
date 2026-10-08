<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Frontend Publishing (frontendpublishing) — agent index

API for an **integrated front-end publishing workflow** (edit/publish in-context). Version **3.1.0**.
Submodule `frontendpublishing_scheduler`.

**Security:** front-end publish/edit/schedule are content-mutating — they must enforce the user's
**actual edit/publish permissions** (a front-end UI must not perform actions the user couldn't do in
admin). Confirm access-checked, not just hidden.