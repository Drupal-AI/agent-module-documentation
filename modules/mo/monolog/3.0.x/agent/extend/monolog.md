# Extend Monolog — custom handlers, processors, resolvers

Handlers, formatters and processors are just Drupal/Symfony services, so you extend Monolog with
standard OOP + DI — no plugin type, no annotation, no attribute.

## Add a new handler

Declare any class implementing `Monolog\Handler\HandlerInterface` under the
`monolog.handler.<name>` namespace, then reference `<name>` in `monolog.channel_handlers`.

```yaml
services:
  monolog.handler.my_stream:
    class: Monolog\Handler\StreamHandler
    arguments: ['php://stdout', 'DEBUG']
    shared: false
```

For handlers that need Drupal services, write your own class and inject them (see the shipped
`DrupalMailHandler`, which injects the core mail manager, and `DrupalHandler`, which wraps a
`logger`-tagged service). Formattable handlers get their formatter and processable handlers get
their processors applied automatically by the factory when configured in the nested syntax.

## Add a new processor

A processor is a `callable` (Monolog invokes it on each `LogRecord`) registered as
`monolog.processor.<name>`. The module's own processors extend
`Drupal\monolog\Logger\Processor\AbstractRequestProcessor` or implement `__invoke(LogRecord): LogRecord`.

```yaml
services:
  monolog.processor.my_tag:
    class: Drupal\my_module\Logger\MyTagProcessor
    arguments: ['@some.service']
    shared: false
```

Reference it in `monolog.processors`, a handler's `processors:` list, or `monolog.logger.processors`.

## Add a condition resolver

Implement `Drupal\monolog\Logger\ConditionResolver\ConditionResolverInterface` (`resolve(): bool`)
and pass the service as the third argument of a `ConditionalHandler` or `ConditionalFormatter`.
Shipped resolvers: `Cli` (`monolog.condition_resolver.cli`) and `OnGcpResolver`
(`monolog.condition_resolver.on_gcp`, reads the `%monolog.on_gcp%` parameter from `MONOLOG_ON_GCP`).

## Alter existing services

Because these are ordinary services you can decorate or alter them from your own
`ServiceProvider` (`alter(ContainerBuilder)`) — e.g. change a handler's arguments, swap its class,
or decorate a processor. This is exactly how `MonologServiceProvider` itself overrides
`logger.factory` and conditionally registers the `monolog.formatter.gelf` service when the `gelf`
package is present.
