<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ships example groups, users, nodes, directories, taxonomy and files to demonstrate and develop the LocalGov Microsites distribution.

---

LocalGov Microsites Demo Content installs a ready-made set of example content — three microsite groups (Scarfolk People's Park, Independent Living, Digital Blog), their controller/editor users, pages, news, events, directory channels/venues, taxonomy terms and image files — to demonstrate and develop the LocalGov Microsites distribution.

The content is defined entirely through the Default Content module: the `.info.yml` lists the UUIDs of every group, user, group relationship, node, taxonomy term and file to import, and enabling the module imports them. It depends on `default_content`, `localgov_directories` and `localgov_microsites_group`, so it is meant to run on a LocalGov Microsites site. Because it creates demo users (with group roles) and publicly visible content, it is a development/demonstration aid, not something to enable on production.

Typical use: on a LocalGov Microsites dev or demo site, enable the module to populate three fully-formed example microsites, then explore or build against them; uninstalling removes the module but not already-imported content (standard Default Content behaviour).
---
- Populate a LocalGov Microsites demo site with example content.
- Create three example microsite groups.
- Import controller and editor users per microsite.
- Add example pages, news articles and events.
- Seed directory channels, venues and promotional pages.
- Provide directory facets for filtering demos.
- Import example taxonomy terms and blog authors.
- Attach example image files to the content.
- Wire group relationships between users, nodes and terms.
- Demonstrate the microsites feature end to end.
- Give developers realistic content to build against.
- Show a microsite webform (Contact us) example.
- Bootstrap training or evaluation environments.
- Reset a demo environment by reinstalling.
- Avoid hand-building demo content.
