<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stand with Ukraine provides a single block that renders a `#StandWithUkraine` support banner overlay linking to `https://war.ukraine.ua/`.
---
The module is intentionally tiny: a `@Block` plugin (`StandWithUkraine`) outputs a fixed markup overlay `<div id="stand_with_ukraine_overlay">` with an anchor to the Ukraine support site, styled/positioned by the module's own CSS and JS libraries (`stand_with_ukraine.libraries.yml`, `css/`, `js/`). Block visibility is granted by the standard `access content` permission via `blockAccess`. There is no admin settings form of substance (`blockForm` is empty) and no external data is fetched.

There is essentially nothing to configure or secure beyond normal block placement: place the block in a region (e.g. via Block layout), optionally restrict it with core block visibility conditions, and it displays the banner to anyone with `access content`. Setup is: enable the module, place the "Stand With Ukraine block" in a theme region.
---
- Enable the module to expose the banner block.
- Place the "Stand With Ukraine block" in a theme region.
- Show a #StandWithUkraine solidarity banner site-wide.
- Link visitors to https://war.ukraine.ua/ from the banner.
- Position the banner as a fixed overlay via the bundled CSS.
- Restrict the block to specific pages with core visibility rules.
- Restrict the block to specific content types or roles.
- Add the banner only to the front page.
- Remove the banner by unplacing or disabling the block.
- Override the banner styling in a custom theme.
- Use core block caching for the static markup.
- Display the banner to all users with `access content`.
- Temporarily show support during a campaign, then disable.
- Combine with other announcement blocks in a header region.
- Confirm the outbound link opens in a new tab.
- Audit the block's static markup before deploying.
- Translate surrounding block title if desired.
- Toggle placement per theme.
