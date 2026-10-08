<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Remove Generator (remove_generator) — agent index

Single-purpose hardening module: removes core's `<meta name="Generator" content="Drupal …">` tag
from the `<head>` of every page, so the site stops advertising that it runs Drupal. **Nothing to
configure** — enable = tag gone, uninstall = core adds it back. The whole module is one hook in
`remove_generator.module`; there is no settings form, no routes, no services, no permissions, no
schema, no plugins, and no dependencies, so this index is the complete documentation.

How it works (all of `remove_generator.module`):
```php
function remove_generator_page_attachments_alter(array &$attachments) {
  foreach ($attachments['#attached']['html_head'] as $key => $value) {
    if ($value[1] == 'system_meta_generator') {
      unset($attachments['#attached']['html_head'][$key]);
    }
  }
}
```
It matches the head element whose render-array name is `system_meta_generator` (the key core's
System module attaches the generator tag under) and `unset()`s it. It affects only that HTML meta
tag — it does **not** touch the `X-Generator` HTTP response header or any other Drupal fingerprint.

Facts:
- **Depends on:** nothing (no `dependencies:` in info.yml; empty `composer.json` `require`).
- **Core:** `^9.4 || ^10 || ^11`. **Package:** none (no `package:` key). **Version:** 2.1.x.
- **Settings page / configure route:** none (`configure` null). **Permissions:** none.
- **Services / routes / plugin types / Drush / config schema:** none.
- **Hook implemented:** `hook_page_attachments_alter()` (`remove_generator.module:11`).
- **No security surface.**
