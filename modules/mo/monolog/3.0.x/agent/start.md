# monolog — agent start

Integrates the [Monolog](https://github.com/Seldaek/monolog) PHP library as Drupal's logger.
The `MonologServiceProvider` **overrides the core `logger.factory`** service, so every
`\Drupal::logger($channel)` becomes a Monolog logger. **No UI, no config entities** — all
configuration is YAML services + parameters, normally in `sites/default/monolog.services.yml`
registered via `$settings['container_yamls'][]`. External dependency: `monolog/monolog ^3.2`.

- Configure channels → handlers/formatters/processors in services.yml → [configure/monolog.md](configure/monolog.md)
- Services, the logger factory, and routing back to dblog → [api/monolog.md](api/monolog.md)
- Add or override handlers/processors/resolvers → [extend/monolog.md](extend/monolog.md)
