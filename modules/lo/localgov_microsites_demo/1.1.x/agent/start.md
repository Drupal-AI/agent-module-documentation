<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Microsites Demo Content (localgov_microsites_demo) — agent index

**Ships example groups, users, nodes, directories, taxonomy and files (the "Scarfolk" microsites) to demonstrate and develop the LocalGov Microsites distribution.**

- **Version:** 1.1.x (release 1.1.0-rc1) — core `^10 || ^11`
- **Depends:** default_content, localgov_directories, localgov_microsites_group
- **Mechanism:** all content declared as `default_content:` UUID lists in `localgov_microsites_demo.info.yml`; enabling imports them. No routes, permissions, services or code.
- **Security:** demo/dev content module — no endpoints or secrets, but it creates demo users and public content, so it is not for production. No code-level security findings.
