<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ConvertKitAPI client

`Drupal\convertkit_esp\Plugin\ConvertKitAPI` wraps ConvertKit v3 over Guzzle (base `https://api.convertkit.com/`, api_version `v3`). Reads use the **api_key**, privileged calls use the **api_secret**, both passed as request parameters (query for GET, JSON body otherwise) — TLS verification is left at Guzzle's secure default.

Key methods:
- `form_subscribe($form_id, $options)` / `add_subscriber_to_sequence($sequence_id, $email)` — subscribe.
- `add_tag($tag, $options)` / `get_subscriber_tags($subscriber_id)` — tagging.
- `get_subscriber_id($email)` — paginated lookup by email.
- `get_resources($resource)` — forms, landing_pages, subscription_forms, tags.
- `form_unsubscribe($options)` — unsubscribe by email.
- `list_purchases`/`create_purchase` — commerce data.

`make_request()` returns decoded JSON or FALSE on non-2xx/3xx. Debug logging (constructor `$debug`) writes to `src/Plugin/logs/debug.log` and instantiates a `Logger` class that is not imported in this file — treat debug mode as broken until a Monolog `Logger` use-statement is added. Reach the client through the `convertkit_esp` service (`Convertkit`) rather than constructing it directly.
