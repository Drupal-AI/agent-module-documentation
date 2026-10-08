# Form Factory — manual setup guide

**Form Factory** (`formfactory`) provides an object‑oriented, fluent interface for
building Drupal Form API render arrays. Instead of hand‑writing deeply nested
`$form` arrays, developers construct forms with chained method calls, which is
easier to read and less error‑prone.

It is the **superstructure** that its companion module, Form Factory Kits, plugs
into. On its own, Form Factory provides a simple service that can load an existing
`$form` array, let you append `FormFactoryKit` objects to it, and return the
modified array. A typical `buildForm()` looks like this:

```php
public function buildForm(array $form, FormStateInterface $form_state) {
  $factory = $this->formFactoryService->load($form);
  $k = $this->formFactoryKitsService;

  $factory->append($k->text())
    ->append($k->submit());

  return $factory->getForm();
}
```

This is a **developer API** — there is no admin UI, no settings page, and it has
no content or access role of its own. You use it entirely from PHP code. It builds
on the **Kits** array‑builder library and, in practice, is paired with the **Form
Factory Kits** module, which supplies the actual field kits (text, submit, tabs,
and so on).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on the Kits module).

There is **no configuration page** — this is a code‑only developer library. Once
enabled, its services are available to your custom modules.

## How to use it

Enable the module, then inject the Form Factory service into your form or service
and use its fluent `load()` / `append()` / `getForm()` methods (as shown above) to
assemble Form API arrays. To get ready‑made field kits to append, also install
**Form Factory Kits**.
