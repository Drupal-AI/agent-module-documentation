<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enviromage (enviromage) — agent index
**Admin dashboard: dry-run composer-update profiling (memory/time), module disk sizes, and PHP env inspection.**

- **Version:** 1.0.x
- **Core:** ^10 — depends on `automatic_updates`.
- **Routes (all `administer env settings`, restrict access):** `.admin_settings`, `.run_composer`, `.get_modules_size`, `.get_env_conf`, `.log_display` under `/admin/config/development/enviromage`.
- **Services:** `enviromage.utility`, `.get_env_conf`, `.get_modules_size`, `.run_composer_command`, `.controller`.
- **Tables:** `enviromage_command`, `enviromage_log`, `enviromage_msize`.
- **Security:** privileged **command-execution** surface — `RunComposerCommandForm` builds `composer update ... --dry-run --profile` and `RunComposerCommand::run_composer_command()` runs it via `proc_open()` (`src/RunComposerCommand.php:248`). Gated only by admin-only `administer env settings`; version constraint validated by `VersionParser` and package limited to a module select, so not reachable by non-admins and not trivially injectable — but grant the permission only to trusted operators. `--dry-run` means no changes applied. (Task hint about "image files" is inaccurate — no image handling.)

See [configure/dashboard.md](configure/dashboard.md).
