# Devel Generate permissions

From `devel_generate.permissions.yml`:

- `administer devel_generate` — access the generate forms and run generation.
- Per-plugin permissions are added dynamically via
  `DevelGeneratePermissions::permissions` (each generator can declare its own `permission`
  in its annotation).

Grant only on development environments.
