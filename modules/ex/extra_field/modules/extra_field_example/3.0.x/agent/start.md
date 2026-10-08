<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Field Example — agent index

Demo submodule of [`extra_field`](../../../../3.0.x/agent/start.md). Registers **eight
example plugin classes** and nothing else — no config, no services, no routes, no
permissions, no settings. Enable it to see working Extra Field plugins, copy one into your
own module, then uninstall it.

- **Every shipped plugin: id, class, bundles, base class, what it demonstrates, plus the two
  known pitfalls** → [plugins/examples.md](plugins/examples.md)

Quick facts:

| Display plugin ids | `all_nodes`, `article_only`, `formatted_field`, `multilingual_field` |
|---|---|
| Form plugin ids | `example_markup`, `example_custom_submit`, `example_custom_input` |
| Pseudo-field names | `extra_field_` + id (e.g. `extra_field_all_nodes`) |
| Enabled by default (`visible = true`) | `all_nodes`, `example_markup`, `example_custom_submit`, `example_custom_input` |
| Install hook | `extra_field_example_install()` deletes the `discovery` cache bin |
| Pitfall | `ExampleWithDependencyInjection` reuses the id `article_only`; `example_custom_input` needs a `voucher` entity type that core does not provide |

To place/remove these on a display, see the parent's
[api/placement.md](../../../../3.0.x/agent/api/placement.md).
