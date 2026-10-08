<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Simplenews checkout pane

## Enable the pane
1. Edit a checkout flow at `/admin/commerce/config/checkout-flows` (permission `administer commerce_checkout flow`).
2. In the flow's panes, place **Simplenews subscription** (plugin id `simplenews_subscription`) on a step. Default step is `summary`.

## Pane configuration (`buildConfigurationForm`)
- **Newsletters** — checkboxes of visible Simplenews newsletters (`simplenews_newsletter_get_visible()`); stored as `configuration['newsletters']`.
- **Label** — fieldset title shown to the shopper (`configuration['label']`, default "Subscribe to newsletters").
- **Display in review step** — checkbox (`configuration['review']`).
- **Review label** — text used in the review summary, supports the `@newsletters` placeholder (`configuration['review_label']`).

## Shopper flow
- `buildPaneForm()` renders the configured newsletters as checkboxes inside a fieldset.
- `submitPaneForm()` reads `$this->order->getEmail()`, loads `Subscriber::loadByMail($email)` (creates one if none), then calls `$subscriber->subscribe($newsletter_id)` and saves for each selected newsletter.
- `buildPaneSummary()` outputs the review label when *Display in review step* is on.

## Notes
- Subscription always uses the order's own email — there is no free-text email field to abuse.
- The `.module` and `.install` files are legacy Drupal 7 code (variable_get/db_query/Rules) and do not run on Drupal 10/11; ignore them when operating the module.
- No Drush commands, no custom routes/permissions of its own.
