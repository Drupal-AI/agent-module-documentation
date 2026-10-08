<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# auu (Auto unblock users)

Auto-unblocks accounts temporarily blocked by Login Security.

- `auu_form_alter()` adds `auu_user`/`auu_message_opt`/`auu_message` to the Login Security settings form; stored in `auu.settings`.
- Hard dep: `login_security`. Configure via `login_security.settings`. No own routes/permissions.

See [../usage.md](../usage.md).
