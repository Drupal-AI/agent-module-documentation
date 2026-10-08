<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail — agent index

Provides a **config entity for managing the emails sent by the site** (subject/body/recipients as manageable/
exportable config vs hardcoded). `mail_example` submodule; provides permissions. Version **8.x-1.2**. Core
`^9.2||^10||^11`.

Admin/messaging — email definitions are config; gate who edits via its permission; ensure sensitive data
isn't inadvertently emailed. No access role beyond permission.
