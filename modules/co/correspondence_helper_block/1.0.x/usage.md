<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Correspondence Helper Block

Provides a simple block that shows two admin-configured text messages (a communication message and a support-contact message) alongside the logged-in user's email address on file.

- Useful on account/confirmation pages where you want to remind a user which email address the site holds for them.
- Pairs a short "we will email your confirmation to" message with the actual account email.
- Configuration is entirely admin-driven; the block itself has no user input.

---

## Installation & configuration

- Install the module like any other Drupal module and enable it.
- Grant the `administer correspondence_helper_block settings` permission to trusted roles.
- Visit `/admin/config/correspondence_helper_block` (route `correspondence_helper_block.route_admin_settings`) to edit the text.
- Set **Communication Text Message** — shown before the on-file email address.
- Set **Support Contact Text** — holds support-team contact information.
- Settings are saved to config object `correspondence_helper_block.settings`.
- Place the provided block via **Block layout** (`/admin/structure/block`) in any region.

---

## Usage & behaviour

- The block renders the configured communication text, the current user's account email, and the support text.
- The email displayed is the *current user's own* email — no other user's data is exposed.
- Anonymous users have no account email, so the block is intended for authenticated contexts.
- The two text values are stored in the module's config and edited through the admin form.
- Text is entered as textareas; treat them as trusted admin content.
- The module defines a theme hook `correspondence_helper_block` (render element `children`) for template overrides.
- No permissions are exposed beyond the single admin settings permission.
- No custom routes exist other than the settings form.
- The block plugin lives in `src/Plugin/Block/CorrespondenceHelperBlock.php`.
- The settings form lives in `src/Form/AdminSettingsForm.php` (extends `ConfigFormBase`).
- To change wording site-wide, edit the settings form values, not code.
- To restyle, override the `correspondence_helper_block` theme template.
- There is no API for programmatic placement beyond standard block placement.
- Multilingual: wrap/translate config via the standard config translation workflow.
- Uninstalling removes the block and its settings config.
