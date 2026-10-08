<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: precompile all Less libraries

The module registers one Drush command (via `drush.services.yml` → `IplessCommands`, service
`ipless.base`).

| Command | Alias | Effect |
|---|---|---|
| `ipless:generate` | `ipless` | Calls `Ipless::generateAllLibraries()` — discovers every library of every installed module and theme and compiles all their `less:` entries into `public://ipless/`. |

```bash
drush ipless:generate     # or: drush ipless
```

Notes:
- It compiles regardless of `modedev`, but honours nothing if `wikimedia/less.php` is missing (the
  service warns and returns).
- `generateAllLibraries()` also clears the `ipless.force_rebuild` state flag when it finishes.
- Typical use: a deploy/build step that pre-warms compiled CSS so the first web request need not
  compile. Pair with `drush cr` (a cache flush flushes `public://ipless/` and re-flags a rebuild).
