<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TransactionNamer service

Source: `src/TransactionNamer.php`. Service id **`dynatrace_transactions.transaction_namer`**
(defined in `dynatrace_transactions.services.yml`, no constructor arguments).

## What it does

```php
class TransactionNamer {
  protected $last_transaction_name = '';
  public function setTransactionName(string $name) {
    $this->last_transaction_name = $name;
  }
}
```

- `setTransactionName(string $name)` is the **entire public surface**. It only assigns `$name` to a
  protected property `$last_transaction_name`.
- The stored property exists **on purpose** so PHP/opcode optimization cannot treat the call as a
  dead no-op — the method call itself must genuinely execute, because that is what Dynatrace hooks.
- **No network, no header, no credential.** The method makes no HTTP request, sets no PHP header,
  reads no env var / Key / setting. There is no PHP APM extension involved (Dynatrace ships none).

## How Dynatrace consumes it

Dynatrace's OneAgent instruments PHP at runtime. You configure a **request attribute** in the
Dynatrace tenant that captures the **argument** passed to
`Drupal\dynatrace_transactions\TransactionNamer::setTransactionName`. That captured value can then be
used to name the transaction/trace. All of that configuration lives in Dynatrace, not in this module.

## Calling it from your own code

Other modules can set a custom name by resolving the service and calling the method — e.g. inside a
controller, form, or a higher-priority event subscriber:

```php
\Drupal::service('dynatrace_transactions.transaction_namer')
  ->setTransactionName('my/custom/name (context)');
```

The last call before Dynatrace captures the value wins. The bundled `EventSubscriber` calls it during
`KernelEvents::REQUEST` at priority 28 (see [../internals/naming.md](../internals/naming.md)); to
override the computed name, call it later in the request lifecycle or from a lower-priority
subscriber.
