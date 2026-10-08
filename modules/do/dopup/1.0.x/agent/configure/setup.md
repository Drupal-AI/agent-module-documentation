<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a Dopup popup

1. **Create a webform** (Structure → Webforms) with the fields you want to capture.
2. **Tag it** with the category `dopup` (webform Settings → General → Categories). Only webforms in this category appear in the block picker.
3. **Enable** the module (`drush en dopup`); Webform is a hard dependency.
4. **Place the block**: Structure → Block layout → place "Dopup" into a region.
5. **Configure the block** at `/admin/config/system/dopup/{block}`:
   - *Webform*: chosen through the `/dopup/autocomplete-webform` autocomplete.
   - *Position*: center / left-bottom / right-bottom / top-right / top-left / custom.
   - *Trigger*: delay in seconds, or scroll-percentage.
   - *Custom styles*: raw CSS for the popup container.
6. Settings persist in `dopup.settings`, keyed by block id.

**Security note:** the autocomplete endpoint is only gated by `access content` and disables entity access checks, so it discloses every webform id on the site to anonymous users. Do not treat webform machine names as secret while this module is enabled.
