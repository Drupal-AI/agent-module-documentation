<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lazy Guinea Pig (lgp) — agent index

**Dev-only debugging helpers: log variables to a temp `lgp.log`, tail it with a Drush command.**

- **Version:** 2.0.x
- **Core:** `^10 | ^9`
- **Functions:** `lp()` print_r, `ld()` var_dump, `lx()` var_export, `lbt()` backtrace (+ `lfp/lfd/lfx`), each with a `$use_stdout` option.
- **Drush:** `lg-console` (alias `lgc`, `Commands\LgpCommands`) tails `lgp.log`.
- **State:** `lgp_temp_dir_func` can override the log directory. `hook_requirements` shows the log path.
- No routes, forms, permissions or config.

**Security:** developer tool with no web surface (no routes/endpoints); writes only to the system temp dir. README warns not to use in production. See [drush/lgp.md](drush/lgp.md).
