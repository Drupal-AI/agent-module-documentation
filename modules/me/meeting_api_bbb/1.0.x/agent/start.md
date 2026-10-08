<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Meeting API: BigBlueButton — agent index

A **BigBlueButton provider for the Meeting API** (create/join BBB video meetings). Depends on `meeting_api`,
`key`. Version **1.0.0-alpha7**. Core `^10||^11`.

Integration — BBB **secret via the Key module** (correct); talks to your BBB server (secure separately) over
HTTPS; **join URLs are capabilities** (anyone with the link joins). No access role.
