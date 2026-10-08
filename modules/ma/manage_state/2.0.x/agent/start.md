<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage State — agent index

UI to **view/manage data in the Drupal State API** (key/value runtime state) — inspect, edit, delete.
Config at `manage_state.state_overview`; provides permissions. Version **2.0.0**. Core
`^10.3||^11||^12`.

**Security:** state holds sensitive operational values and editing it changes behaviour — restrict the
permission to trusted admins; use carefully (esp. production). Developer/admin tool.
