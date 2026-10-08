<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig-Extensions filters (Text, Date, Array)

Ports three filters from the historical `twig/extensions` library into Drupal's Twig environment
(services `bamboo_twig_extensions.twig.text`, `.date`, `.array`; classes `TwigText`, `TwigDate`,
`TwigArray`). The filters are **prefixed `bamboo_extensions_`** (they are NOT registered under the
bare upstream names):

- `bamboo_extensions_truncate` (Text, needs the Twig environment) —
  `string | bamboo_extensions_truncate(length = 30, preserve = false, separator = '...')`.
  Truncates to `length`; `preserve=true` avoids cutting mid-word; appends `separator`.
  ```twig
  {{ node.body.value | striptags | bamboo_extensions_truncate(120, true, '…') }}
  {{ 'Hello World Foo Bar' | bamboo_extensions_truncate(8) }}   {# Hello Wo... #}
  ```
- `bamboo_extensions_time_diff` (Date, needs the Twig environment) —
  `date | bamboo_extensions_time_diff(now = null, unit = null, humanize = true)`. Renders a
  human-readable difference ("3 days ago"). `now` defaults to the current time.
  ```twig
  {{ node.getCreatedTime | bamboo_extensions_time_diff }}
  ```
- `bamboo_extensions_shuffle` (Array) — `array | bamboo_extensions_shuffle`. Returns the array in
  random order.
  ```twig
  {% for item in items | bamboo_extensions_shuffle %}{{ item }}{% endfor %}
  ```

There is no `wordwrap` filter in this build — only the three above.
