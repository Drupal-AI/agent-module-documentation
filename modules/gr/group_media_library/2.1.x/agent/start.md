<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media Library — agent index

Lets the **core Media Library be used with the Group module** (group-scoped media — browse/manage media per
group). `..._groupmedia`/`..._media_tracker`/`..._widget` submodules. Depends on core `media_library`,
`group`. Version **2.1.0-alpha1**. Core `^10||^11`.

Media/group — media access should follow the **group's membership/permission model** (verify group-scoped
media is members-only via Group/media access config); no access role of its own.
