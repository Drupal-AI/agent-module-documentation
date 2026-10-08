<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap 5 badges for Apigee `status_property`

## Enable

```bash
drush en apigee_extras_bootstrap -y   # requires apigee_extras (+ apigee_edge)
```

Use a **Bootstrap 5-based theme** (e.g. the `bootstrap5` contrib theme) so the `badge` / `bg-*`
utility classes actually resolve to styles. The submodule ships no CSS of its own.

## The hook

`apigee_extras_bootstrap.module` implements
`apigee_extras_bootstrap_preprocess_status_property(array &$variables): void`, a preprocess hook
for the `status_property` theme element that Apigee Edge already provides and renders through
`status-property.html.twig`. It does not register a new theme hook or template — it only augments
attributes on the existing one.

Flow:

1. `$raw_value = (string) ($variables['element']['value'] ?? '')`.
2. `$normalized = mb_strtolower($raw_value)`.
3. `$badge_classes = $status_map[$normalized] ?? ['bg-secondary']` — look up the colour class(es).
4. Merge into the wrapper classes:
   ```php
   $variables['attributes']['class'] = array_merge(
     (array) ($variables['attributes']['class'] ?? []),
     ['badge', 'rounded-pill'],
     $badge_classes,
     ['wrapper--status--' . $normalized],
   );
   ```

So every status pill gets `badge rounded-pill <bg-*> wrapper--status--<status>`. Class values are
rendered through Drupal's attribute system (escaped), and `$normalized` comes from the Apigee status
value, not from a request parameter.

## Status → Bootstrap class map (`$status_map`)

| Status value(s) | Classes added |
|---|---|
| `active`, `approved`, `published`, `enabled`, `1` | `bg-success` |
| `inactive`, `disabled`, `0` | `bg-secondary` |
| `revoked`, `blocked`, `deleted`, `error` | `bg-danger` |
| `pending`, `pending_approval` | `bg-warning`, `text-dark` |
| `expired` | `bg-dark` |
| *(anything else)* | `bg-secondary` (fallback) |

`bg-warning` is paired with `text-dark` for contrast/a11y.

## Customising

- **Change the markup:** override `templates/status-property.html.twig` in your own theme; the
  template still receives the augmented `attributes`.
- **Change the colours / add statuses:** implement your own
  `hook_preprocess_status_property()` (later in the preprocess order) and adjust
  `$variables['attributes']['class']`, or key off the `wrapper--status--<status>` modifier in CSS to
  restyle a specific status without touching PHP.
