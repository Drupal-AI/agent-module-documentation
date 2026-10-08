<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a [consumers:current-name] token replaced by the requesting consumer's name.

---

Consumers Token provides a token `[consumers:current-name]` for consumers name replacement depending on which consumer requested it — so text/config using the token resolves to the name of the API consumer making the current request, useful for per-consumer messaging in a decoupled setup. Depends on `consumers`; supports Drupal 8 through 11.

---

- Provides one token: `[consumers:current-name]`.
- Resolves to the label of the Consumer that made the current request, via the `consumer.negotiator` service (`negotiateFromRequest()`), or an empty string when no Consumer is negotiated.
- Use it anywhere Drupal tokens are accepted (e.g. a Metatag pattern) to vary output per front-end application.
- No configuration, routes, permissions, or settings form — it works once enabled.
- Depends only on the `consumers` module; supports Drupal 8 through 11.
