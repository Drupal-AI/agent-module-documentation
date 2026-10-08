<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
D8: Bootstrap Tour integrates the Bootstrap Tour JavaScript plugin so you can build step-by-step, popover-based guided tours of a site's UI. Steps are configured in an admin form and rendered on the page through a block.

Use it for onboarding new users, highlighting new features, or walking editors through an admin workflow with anchored popovers.
---
Enable with `drush en bs_tour`. Configure the tour steps at `/admin/config/user-interface/bs-tour` (route `bs_tour.admin`), gated by the module's own `administer bs tour` permission (`restrict access: TRUE`). Place the "BS Tour" block (`src/Plugin/Block/BSTourBlock.php`) on the regions/pages where the tour should run.

The module ships the Bootstrap Tour library assets under `assets/` and declares its front-end library in `bs_tour.libraries.yml`. Tour definitions are stored in module config.
---
- Onboard new users with a guided popover walkthrough.
- Highlight a newly released feature with anchored steps.
- Walk editors through a content-creation workflow.
- Explain an admin dashboard step by step.
- Point out key navigation elements to first-time visitors.
- Attach tour steps to specific CSS selectors on a page.
- Show a tour only on selected pages via block visibility.
- Reduce support requests with an in-context tutorial.
- Sequence multi-step instructions with next/prev buttons.
- Configure tour content without writing JavaScript.
- Restrict tour configuration to trusted admins.
- Reuse the Bootstrap Tour plugin already familiar to themers.
- Introduce a redesigned UI gradually.
- Guide users through a checkout or form flow.
- Provide contextual help anchored to interface elements.
- Toggle tours per role by controlling block placement.