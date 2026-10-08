<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Publishing options — agent index

Admin interface to **create custom publishing options** — extra boolean content flags alongside core
Published/Promoted/Sticky (Featured/Archived/etc.). Machine name `publishing_options`. Config at
`publishing_options.settings`; provides permissions. Version **3.0.0**. Core `^10||^11`.

Content-editing/publishing — flags are metadata; not access controls unless you build access logic around
them.
