<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enable pretty URLs for Views exposed filter identifiers.

---

Pretty URL adds a checkbox in Views exposed-filter identifier settings to enable pretty URLs like `?cloud=aws,gcp` — so multi-value exposed filters produce clean, comma-separated query parameters instead of the default `field[]=aws&field[]=gcp` array syntax, giving nicer, shareable filter URLs. Depends on core `views` and `taxonomy`; supports Drupal 9, 10, and 11.

---

- Enable pretty exposed-filter URLs.
- Produce ?cloud=aws,gcp style.
- Avoid array query syntax.
- Add a Views checkbox.
- Give shareable filter URLs.
- Support multi-value filters.
- Depend on core `views` and `taxonomy`.
- Support Drupal 9, 10, and 11.
- Configure per filter.
- Aid UX/SEO.
- Handle pretty URLs.
- Clean up query strings
- Support Drupal.
- Support Drupal.
- Support Drupal.
