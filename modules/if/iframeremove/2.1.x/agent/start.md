# IFrame Removing Filter — agent index

One text-format filter that removes `<iframe>` elements whose `src` host is not in an admin
allowlist. Enable it on a text format; its only setting is a newline-separated domain whitelist
(wildcards allowed). No global config page (`configure` null), no permissions, no dependencies.

- **The filter plugin, whitelist format, matching logic, and how to enable/configure it** →
  [plugins/filter.md](plugins/filter.md)

Key facts:
- Plugin: `#[Filter(id: 'iframeremove_filter', type: TYPE_TRANSFORM_IRREVERSIBLE)]`
  (`src/Plugin/Filter/IframeRemoveFilter.php`).
- Setting: `iframeremove_whitelist` (textarea, one domain per line; `*` wildcard → `.*?`).
- Config lives in `filter.format.<format>` → filters (schema `filter_settings.iframeremove_filter`).
- Removes iframes with empty/unparseable host or a host not matching any whitelist regex.
