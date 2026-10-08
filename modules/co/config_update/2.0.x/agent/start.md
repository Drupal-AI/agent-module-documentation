# config_update — agent start

API-only base module (no UI, no permissions). Depends on core `config`. Exposes three
services for listing, diffing, and reverting/importing configuration against the defaults
shipped in a module/theme/profile's `config/install` + `config/optional`. The
`config_update_ui` submodule and Features build UIs on these.

- Call the lister / differ / reverter services in code → [api/services.md](api/services.md)
- React to or alter import/revert operations via events → [extend/events.md](extend/events.md)
