<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Field Login (field_login) — agent index

Lets users **log in using the value of an arbitrary user field** (phone/membership ID vs username). Config at
`field_login.settings`; provides permissions. Version **3.1.1**. Core `^11.1.6`.

Sound: a `UserAuthDecorator` **decorates** core user-auth — looks up the account by the field, then **still
verifies the password** via core's password checker (doesn't weaken the credential check; flood control
applies). Ensure the login field is **unique**; extra identifiers widen enumeration surface (neutral
messages). No other access role.
