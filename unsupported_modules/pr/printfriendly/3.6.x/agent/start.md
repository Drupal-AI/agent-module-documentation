# printfriendly — agent index

Adds a hosted PrintFriendly.com print/PDF/email button to selected node types and loads the
third-party widget from `cdn.printfriendly.com`. Config-only integration: settings form at
`admin/config/printfriendly/config` (`configure: printfriendly.config`). No config schema, no
Drush, no plugin types. Two permissions.

- **All settings keys, the button display logic, and the injected JS/URLs** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `printfriendly.settings` (no shipped schema; keys written by
  `PrintfriendlyConfigForm`).
- `printfriendly_page_attachments()` injects an inline `<script>` on **every** page that sets
  `pf*` JS vars from config and appends `//cdn.printfriendly.com/printfriendly.js`.
- `printfriendly_node_view()` adds the button only when the node's type (or `teaser`) is enabled
  **and** the user has `access printfriendly`.
- Permissions `administer printfriendly` and `access printfriendly` are both
  `restrict access: true`.
- Privacy/third-party: the visited page URL is passed to `printfriendly.com/print?url=…` and
  external JS/CSS/images load from `cdn.printfriendly.com`. Not a code vulnerability — a
  deployment/privacy consideration to document, not a security.md finding.
