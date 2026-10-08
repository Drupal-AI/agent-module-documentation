<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Override Media Options — agent index

Lets **non-admins override default publishing options** (e.g. published status) for **media they can
edit** (media analogue of "override node options"). Depends on core `media`. Config at
`override_media_options.settings`; provides permissions. Version **2.0.7**. Core `^9||^10||^11`.

**Access-delegation:** grants override capability (scoped to editable media) via permissions — verify
role assignments (overriding published status = publish/unpublish media) match your trust model.
