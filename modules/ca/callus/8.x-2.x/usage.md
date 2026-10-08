<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Call Us

## What it is / when to use

- Displays a floating call-to-action button (phone number) plus optional social-media links on the site.
- Use for quick-contact affordances on marketing/brochure sites.
- Fully configurable colours, label, and screen side from an admin form.

---

## Install & configure

- Enable the module and visit `/admin/config/user-interface/call-us` (route `callus.form`, permission `administer site configuration`).
- Set the phone number (required, numeric, min 10 digits), button label, side (Right/Float Right/Left), and background/font colours.
- Optionally add Facebook, Gmail, Twitter, LinkedIn, and YouTube URLs.
- Styling and behaviour are applied through the module's CSS/JS libraries.

---

## Usage & API notes

- Settings persist to the `callus.settings` config object.
- The admin form validates that the phone number is numeric and at least 10 characters.
- Colours use HTML5 `color` input types for background and font.
- Button side option controls placement/float via CSS classes.
- Social links are optional; empty values simply hide those buttons.
- The button and links are injected on the frontend via the module's libraries.
- Only one admin route exists; there are NO callback/webhook or anonymous endpoints.
- No external API calls are made — the "Gmail/social" fields are plain link URLs.
- Menu link is provided via `callus.links.menu.yml`.
- Images/icons ship under the module's `images/` directory.
- Access to configuration is limited to `administer site configuration`.
- To change markup, override the module's template/library assets.
- Suitable as a lightweight alternative to full contact-widget modules.
- The label field is optional; the phone number is the only required field.
- No permissions are declared beyond the core config permission on the route.
- Uninstall removes the `callus.settings` config.
