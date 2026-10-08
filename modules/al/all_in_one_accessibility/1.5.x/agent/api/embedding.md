<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# All in One Accessibility — how the widget is embedded

The module injects a **third-party, hosted** script on every page; it does not implement the
accessibility features itself.

## `hook_library_info_build()` (`all_in_one_accessibility.module`)

Builds a dynamic library whose single JS asset is an **external URL**:

```
https://www.skynettechnologies.com/accessibility/js/all-in-one-accessibility-js-widget-minify.js
  ?colorcode=<colorcode>&token=<userid>&t=<random>
  &position=<position>.<aioa_icon_type>.<aioa_icon_size>.<aioa_icon_sizes>.<widget_size>
           .<is_widget_custom_size>.<is_widget_custom_size_mobile>.<is_widget_custom_position>
           .<widget_icon_size_custom>.<widget_position_left>.<widget_position_bottom>
           .<widget_position_right>.<widget_icon_size_custom_mobile>.<widget_position_top>
           .<statement_link>
```

with `attributes: { id: 'aioa-adawidget' }`. Missing values fall back to defaults
(`widget_size=regularsize`, `aioa_icon_type=aioa-icon-type-1`, `aioa_icon_size=aioa-default-icon`,
custom flags `0`, positions empty). The values come from
`all_in_one_accessibility.userid.settings`.

## `hook_page_attachments()`

Attaches the library (`all_in_one_accessibility/ada_lib`) to every page response, so the widget
loads site-wide with no block placement.

## Install-time vendor call (`all_in_one_accessibility.install`)

On install the module POSTs the site host (base64-encoded) to the vendor endpoint
`https://ada.skynettechnologies.us/api/add-user-domain` to register the domain. This is an
outbound call to Skynet Technologies.

## Implications for agents

- Everything you can change locally is in the `all_in_one_accessibility.userid.settings` config
  object (see [../configure/settings.md](../configure/settings.md)); the widget's behaviour is
  otherwise controlled remotely by the token/plan.
- To verify configuration on a running site, read that config object — do **not** rely on the
  remote widget being reachable. The DOM marker for the injected script is `id="aioa-adawidget"`.
