# components — agent start

Registers folders as custom Twig namespaces (`@ns/tpl.twig`) and adds Twig helpers.
No admin UI, no permissions, no config — all declared in `.info.yml` / code.

- Register namespaces + Twig `template()`/`set`/`add`/`recursive_merge` helpers → [theming/twig.md](theming/twig.md)
- Alter namespaces / protected namespaces via hooks → [hooks/hooks.md](hooks/hooks.md)
