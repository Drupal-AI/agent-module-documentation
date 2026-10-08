<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Autosubmit — agent index

Provides one Views **exposed form** plugin, `autosubmit`, so an exposed filter form submits
itself (as you type / change a control) instead of needing an Apply click. No settings form,
no configure route, no permissions, no Drush, no plugin *types* of its own.

- **Select it on a view, its two options, and where it is stored in config** →
  [plugins/autosubmit.md](plugins/autosubmit.md)

Key fact: the setting lives in the view display config at
`display_options.exposed_form.type: autosubmit`, with
`options.autosubmit_hide` (bool, default TRUE) and `options.timeout` (ms, default 500).
