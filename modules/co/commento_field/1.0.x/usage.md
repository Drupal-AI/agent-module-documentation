<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commento Field embeds the hosted Commento comment widget via a field.

---

Commento Field integrates [Commento](https://commento.io/) — a lightweight, privacy-focused,
hosted commenting service — into Drupal as a field, so content can display a Commento comment
thread instead of core comments. Visitors comment through the embedded Commento widget, which loads
from Commento's CDN (`https://cdn.commento.io/js/commento.js`). The thread on each page is keyed by
the entity's canonical URL, so you register your site's domain in your commento.io account; there
is no Drupal setting for a Commento server URL, and the module does not connect to a self-hosted
Commento instance.

The field itself stores only a per-entity on/off flag: a widget checkbox (gated by
`toggle commento comments`) turns the thread on or off for that piece of content, defaulting to on.
The formatter shows the thread only to viewers with `view commento comments`. Display options on
the field's "Manage display" settings let you disable Commento's auto-init, disable its default
font, and hide deleted comments. Supports Drupal 9, 10, and 11. Because the widget loads
third-party JavaScript and sends comment activity (including each page's URL) to Commento, review
the privacy and data-flow implications for your audience.

---

- Embed the hosted Commento comment widget on entity pages.
- Display a Commento thread as a field on content.
- Replace core comments with Commento.
- Toggle the thread per entity with a widget checkbox.
- Gate toggling with `toggle commento comments`.
- Gate viewing with `view commento comments`.
- Key each thread by the entity's canonical URL (`data-page-id`).
- Load Commento's script from its CDN (no self-hosted server setting).
- Disable Commento auto-init from the display settings.
- Disable Commento's default font from the display settings.
- Hide deleted comments from the display settings.
- Fall back to the field default when an existing entity has no stored value.
- Support Drupal 9, 10, and 11.
- Use a privacy-focused, hosted service.
- Review third-party data-flow before public use.
- Register the site domain in the commento.io account.
- Provide a lightweight comments field.
- Show a noscript prompt when JavaScript is off.
